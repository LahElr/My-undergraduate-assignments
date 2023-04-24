import numpy
import sys
import pandas
import os
import matplotlib.pyplot as plt
import seaborn as sns
import gc

from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import MinMaxScaler
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import PolynomialFeatures
from sklearn.cluster import KMeans
from sklearn.preprocessing import Normalizer

import utils


def my_onehot_encode(data, nan_as_category=True):
    original_columns = list(data.columns)  # //copy
    categorical_columns = [
        col for col in data.columns if data[col].dtype == "object"
    ] # label cols
    data = pandas.get_dummies(data,
                              columns=categorical_columns,
                              dummy_na=nan_as_category)
    new_columns = [c for c in data.columns if c not in original_columns]
    return data, new_columns


# this class aims at calculating the majority of one's
#  previous loans using clustering algorithims
class bin_count:
    def __init__(self):
        self.cluster_count = 3
        self.clusterer = KMeans(
            n_clusters=self.cluster_count, random_state=0, max_iter=10
        )  # only 10 iters is allowed, but in practice, it's still very slow

    def major(self, col):
        col = col.values  # //to_numpy()
        col = col[~numpy.isnan(col)]  # filter nan away
        if 0 < len(col) <= self.cluster_count:
            # if there's no enough points to be clustered
            return (col[0] + col[-1]) / 2
        elif len(col) == 0:
            return numpy.nan  # if nothing left
        self.clusterer.fit(
            numpy.array(col).reshape(-1, 1)
        )  # may raise ConvergenceWarning due to duplicate points, but the result would be correct
        ret = self.clusterer.cluster_centers_.reshape(
            -1)  # the cluster centers
        ret_ind = numpy.argmax(numpy.bincount(
            self.clusterer.labels_))  # the cluster with most points
        return ret[ret_ind]


# this function aims at calculating the employed days percent of one person
def cal_days_employed_percent(row):
    ret = row["DAYS_EMPLOYED"] / (
        row["DAYS_BIRTH"] + 5844
    )  # remove 16 years as it is illegal to use child labours
    if ret < 0:
        ret = 0.0
    return ret


utils.log("prepared for processing.")

# ! application data

app_train = pandas.read_csv("./data/application_train.csv")
app_test = pandas.read_csv("./data/application_test.csv")

label_encoder = LabelEncoder()
label_dicts = {}

for col in app_train:
    if app_train[col].dtype == "object":
        utils.log("LabelEncoder: encoding column \"{}\"".format(col))
        label_encoder.fit(app_train[col])
        labels = app_train[col].unique()
        app_train[col] = label_encoder.transform(app_train[col])
        app_test[col] = label_encoder.transform(app_test[col])
        label_dicts["application_{}".format(col)] = dict(
            zip(label_encoder.transform(labels), labels))

app_train = pandas.get_dummies(app_train)
app_test = pandas.get_dummies(app_test)

train_labels = app_train["TARGET"]
app_train, app_test = app_train.align(app_test, join="inner", axis=1)
app_train["TARGET"] = train_labels

utils.log("processing poly feat for app.")
# do poly feature engineering using combination of 5 features
poly_cols = ["EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3",
             "DAYS_BIRTH"]  # the columns of the greatest correlation
poly_features_train = app_train[poly_cols + ["TARGET"]]
poly_features_test = app_test[poly_cols]

poly_target = poly_features_train["TARGET"]
poly_features_train = poly_features_train.drop(columns=["TARGET"])

utils.log("processing imputing for app.")
# fill missing values
imputer = SimpleImputer(strategy="median")  # No mean
poly_features_train = imputer.fit_transform(poly_features_train)
poly_features_test = imputer.transform(poly_features_test)

poly_transformer = PolynomialFeatures(degree=4)  # changable

# fit polynomial features
poly_transformer.fit(poly_features_train)

# apply polynomial features
poly_features_train = poly_transformer.transform(poly_features_train)
poly_features_test = poly_transformer.transform(poly_features_test)

utils.log("extract polynomial features columns.")
# extract polynomial features columns
poly_features_train = pandas.DataFrame(
    poly_features_train, columns=poly_transformer.get_feature_names(poly_cols))
poly_features_test = pandas.DataFrame(
    poly_features_test, columns=poly_transformer.get_feature_names(poly_cols))

# add in the target
poly_features_train["TARGET"] = poly_target

# left join polynomial features into training dataframe
poly_features_train["SK_ID_CURR"] = app_train["SK_ID_CURR"]
app_train_poly = app_train.merge(poly_features_train,
                                 on="SK_ID_CURR",
                                 how="left")

# left join polnomial features into testing dataframe
poly_features_test["SK_ID_CURR"] = app_test["SK_ID_CURR"]
app_test_poly = app_test.merge(poly_features_test, on="SK_ID_CURR", how="left")

# align the dataframes
app_train_poly, app_test_poly = app_train_poly.align(app_test_poly,
                                                     join="inner",
                                                     axis=1)

# make copies
app_train_domain = app_train.copy()
app_test_domain = app_test.copy()

utils.log("processing driven columns for app.")
# some driven columns
app_train_domain["CREDIT_INCOME_PERCENT"] = app_train_domain[
    "AMT_CREDIT"] / app_train_domain["AMT_INCOME_TOTAL"]
app_train_domain["ANNUITY_INCOME_PERCENT"] = app_train_domain[
    "AMT_ANNUITY"] / app_train_domain["AMT_INCOME_TOTAL"]
app_train_domain["CREDIT_TERM"] = app_train_domain[
    "AMT_ANNUITY"] / app_train_domain["AMT_CREDIT"]
app_train_domain["DAYS_EMPLOYED_PERCENT"] = app_train_domain.apply(
    cal_days_employed_percent, axis=1)

app_test_domain["CREDIT_INCOME_PERCENT"] = app_test_domain[
    "AMT_CREDIT"] / app_test_domain["AMT_INCOME_TOTAL"]
app_test_domain["ANNUITY_INCOME_PERCENT"] = app_test_domain[
    "AMT_ANNUITY"] / app_test_domain["AMT_INCOME_TOTAL"]
app_test_domain["CREDIT_TERM"] = app_test_domain[
    "AMT_ANNUITY"] / app_test_domain["AMT_CREDIT"]
app_test_domain["DAYS_EMPLOYED_PERCENT"] = app_test_domain.apply(
    cal_days_employed_percent, axis=1)

# merge the driven columns by inner join
app_train = pandas.merge(app_train_domain,
                         poly_features_train,
                         how="inner",
                         on="SK_ID_CURR")
app_test = pandas.merge(app_test_domain,
                        poly_features_test,
                        how="inner",
                        on="SK_ID_CURR")

# align
app_train, app_test = app_train.align(app_test, join="inner", axis=1)

app_train.to_csv("./processed/train_unfin_app.csv")
app_test.to_csv("./processed/test_unfin_app.csv")

utils.log("finished processing for application datas.")

del app_test_domain, app_train_domain
gc.collect()

# ! breau data

bureau = pandas.read_csv("./data/bureau.csv")
bureau_balance = pandas.read_csv("./data/bureau_balance.csv")

previous_loan_counts = bureau.groupby(
    "SK_ID_CURR", as_index=False)["SK_ID_BUREAU"].count().rename(
        columns={"SK_ID_BUREAU": "previous_loan_counts"})

app_train = app_train.merge(previous_loan_counts, on="SK_ID_CURR", how="left")
app_test = app_test.merge(previous_loan_counts, on="SK_ID_CURR", how="left")

# fill missing values by 0
app_train["previous_loan_counts"] = app_train["previous_loan_counts"].fillna(0)
app_test["previous_loan_counts"] = app_test["previous_loan_counts"].fillna(0)

utils.log("processing agg for bureau.")
bin_counter = bin_count()
# group by the applier id, calculate aggregation statistics
bureau_agg = bureau.drop(columns=["SK_ID_BUREAU"]).groupby(
    "SK_ID_CURR", as_index=False).agg(["count", "mean", "max", "min",
                                       "sum"]).reset_index()

bureau_agg_cols = ["SK_ID_CURR"]  # list of column names

utils.log("processing agg cols for bureau.")
# for all var names
for var in bureau_agg.columns.levels[0]:
    if var != "SK_ID_CURR":
        # for all agg_ways:
        for agg_way in bureau_agg.columns.levels[1][:-1]:
            bureau_agg_cols.append(
                "bureau_{}_{}".format(var, agg_way)
            )  # make a new column name for the variable and agg_way
bureau_agg.columns = bureau_agg_cols

app_train = app_train.merge(bureau_agg, on="SK_ID_CURR", how="left")
app_test = app_test.merge(bureau_agg, on="SK_ID_CURR", how="left")

app_train.to_csv("./processed/train_unfin_bureau.csv")
app_test.to_csv("./processed/test_unfin_bureau.csv")

utils.log("finished processing for breau datas.")

del bureau, bureau_agg, bureau_balance
gc.collect()

# ! pos cash balance

pos = pandas.read_csv("./data/POS_CASH_balance.csv")

utils.log("processing agg for pos.")
pos, cat_cols = my_onehot_encode(pos)
# features
aggregations = {
    "MONTHS_BALANCE": ["max", "mean", "size"],
    "SK_DPD": ["max", "mean"],
    "SK_DPD_DEF": ["max", "mean"]
}
for cat in cat_cols:
    aggregations[cat] = ["mean"]
pos_agg = pos.groupby("SK_ID_CURR").agg(aggregations)
pos_agg.columns = pandas.Index(
    ["POS_{}_{}".format(e[0], e[1].upper()) for e in pos_agg.columns.tolist()])
# count pos cash accounts
pos_agg["POS_COUNT"] = pos.groupby("SK_ID_CURR").size()

app_train = app_train.merge(pos_agg, on="SK_ID_CURR", how="left")
app_test = app_test.merge(pos_agg, on="SK_ID_CURR", how="left")

app_train.to_csv("./processed/train_unfin_pos.csv")
app_test.to_csv("./processed/test_unfin_pos.csv")

utils.log("finished processing for pos_cash_balance datas.")

del pos, pos_agg
gc.collect()

# ! installments_payments

installments = pandas.read_csv("./data/installments_payments.csv")

installments, cat_cols = my_onehot_encode(installments)

utils.log("processing domain for installments.")
installments["PAYMENT_PERC"] = installments["AMT_PAYMENT"] / installments[
    "AMT_INSTALMENT"]
installments["PAYMENT_DIFF"] = installments["AMT_INSTALMENT"] - installments[
    "AMT_PAYMENT"]
installments["Dpandas"] = installments["DAYS_ENTRY_PAYMENT"] - installments[
    "DAYS_INSTALMENT"]
installments["DBD"] = installments["DAYS_INSTALMENT"] - installments[
    "DAYS_ENTRY_PAYMENT"]
installments["Dpandas"] = installments["Dpandas"].apply(lambda x: x
                                                        if x > 0 else 0)
installments["DBD"] = installments["DBD"].apply(lambda x: x if x > 0 else 0)

utils.log("processing agg for installments.")
aggregations = {
    "NUM_INSTALMENT_VERSION": ["nunique"],
    "Dpandas": ["max", "mean", "sum"],
    "DBD": ["max", "mean", "sum"],
    "PAYMENT_PERC": ["max", "mean", "sum", "var"],
    "PAYMENT_DIFF": ["max", "mean", "sum", "var"],
    "AMT_INSTALMENT": ["max", "mean", "sum"],
    "AMT_PAYMENT": ["min", "max", "mean", "sum"],
    "DAYS_ENTRY_PAYMENT": ["max", "mean", "sum"]
}
for cat in cat_cols:
    aggregations[cat] = ["mean"]
installments_agg = installments.groupby("SK_ID_CURR").agg(aggregations)
installments_agg.columns = pandas.Index([
    "INSTAL_{}_{}".format(e[0], e[1].upper())
    for e in installments_agg.columns.tolist()
])

installments_agg["INSTAL_COUNT"] = installments.groupby("SK_ID_CURR").size()

app_train = app_train.merge(installments_agg, on="SK_ID_CURR", how="left")
app_test = app_test.merge(installments_agg, on="SK_ID_CURR", how="left")

app_train.to_csv("./processed/train_unfin_ins.csv")
app_test.to_csv("./processed/test_unfin_ins.csv")

utils.log("finished processing for installments_payments datas.")

del installments, installments_agg
gc.collect()

# ! credit_card_balance

credit_card_balance = pandas.read_csv("./data/credit_card_balance.csv")
credit_card_balance, cat_cols = my_onehot_encode(credit_card_balance)

utils.log("processing agg for credit card.")
# general aggregations
credit_card_balance.drop(["SK_ID_PREV"], axis=1, inplace=True)
credit_card_agg = credit_card_balance.groupby("SK_ID_CURR").agg(
    ["min", "max", "mean", "sum", "var"])
credit_card_agg.columns = pandas.Index([
    "CC_{}_{}".format(e[0], e[1].upper())
    for e in credit_card_agg.columns.tolist()
])
# count credit card lines
credit_card_agg["CC_COUNT"] = credit_card_balance.groupby("SK_ID_CURR").size()

app_train = app_train.merge(credit_card_agg, on="SK_ID_CURR", how="left")
app_test = app_test.merge(credit_card_agg, on="SK_ID_CURR", how="left")

app_train.to_csv("./processed/train_unfin_credit.csv")
app_test.to_csv("./processed/test_unfin_credit.csv")

utils.log("finished processing for credit_card_balance datas.")

del credit_card_balance, credit_card_agg
gc.collect()

# ! previous_application

previous_app = pandas.read_csv("./data/previous_application.csv")
previous_app, cat_cols = my_onehot_encode(previous_app)

utils.log("imputing for previous.")
prev_col = previous_app.columns.tolist()
imputer = SimpleImputer(missing_values=numpy.nan,
                        strategy="constant",
                        fill_value=32575) 
previous_app = imputer.fit_transform(previous_app)
previous_app = pandas.DataFrame(previous_app, columns=prev_col)
previous_app["APP_CREDIT_PERC"] = previous_app[
    "AMT_APPLICATION"] / previous_app["AMT_CREDIT"]

utils.log("processing agg for previous.")
# previous applications numeric features
num_aggregations = {
    "AMT_ANNUITY": ["min", "max", "mean"],
    "AMT_APPLICATION": ["min", "max", "mean"],
    "AMT_CREDIT": ["min", "max", "mean"],
    "APP_CREDIT_PERC": ["min", "max", "mean", "var"],
    "AMT_DOWN_PAYMENT": ["min", "max", "mean"],
    "AMT_GOODS_PRICE": ["min", "max", "mean"],
    "HOUR_APPR_PROCESS_START": ["min", "max", "mean"],
    "RATE_DOWN_PAYMENT": ["min", "max", "mean"],
    "DAYS_DECISION": ["min", "max", "mean"],
    "CNT_PAYMENT": ["mean", "sum"],
}
# previous applications categorical features
cat_aggregations = {}
for cat in cat_cols:
    cat_aggregations[cat] = ["mean"]

prev_app_agg = previous_app.groupby("SK_ID_CURR").agg({
    **num_aggregations,
    **cat_aggregations
})
prev_app_agg.columns = pandas.Index([
    "PREV_{}_{}".format(e[0], e[1].upper())
    for e in prev_app_agg.columns.tolist()
])

utils.log("counting previous approved applications.")
# previous applications: approved applications - only numerical features
approved = previous_app[previous_app["NAME_CONTRACT_STATUS_Approved"] == 1]
approved_agg = approved.groupby("SK_ID_CURR").agg(num_aggregations)
approved_agg.columns = pandas.Index([
    "APPROVED_{}_{}".format(e[0], e[1].upper())
    for e in approved_agg.columns.tolist()
])
prev_app_agg = prev_app_agg.join(approved_agg, how="left", on="SK_ID_CURR")

utils.log("counting previous refused applications.")
# previous applications: refused applications - only numerical features
refused = previous_app[previous_app["NAME_CONTRACT_STATUS_Refused"] == 1]
refused_agg = refused.groupby("SK_ID_CURR").agg(num_aggregations)
refused_agg.columns = pandas.Index([
    "REFUSED_{}_{}".format(e[0], e[1].upper())
    for e in refused_agg.columns.tolist()
])
prev_app_agg = prev_app_agg.join(refused_agg, how="left", on="SK_ID_CURR")

app_train = app_train.merge(prev_app_agg, on="SK_ID_CURR", how="left")
app_test = app_test.merge(prev_app_agg, on="SK_ID_CURR", how="left")

app_train.to_csv("./processed/train_unfin_prev.csv")
app_test.to_csv("./processed/test_unfin_prev.csv")

utils.log("finished processing for previous_application datas.")

del refused, refused_agg, approved, approved_agg, previous_app, prev_app_agg
gc.collect()

# app_test.replace(to_replace=numpy.NaN, value=10000, inplace=True)
# app_train.replace(to_replace=numpy.NaN, value=10000, inplace=True)
app_test.replace(to_replace=numpy.inf, value=10000, inplace=True)
app_train.replace(to_replace=numpy.inf, value=10000, inplace=True)

# ! fileter low correlated columns

app_train.to_csv("./processed/train_full.csv")
app_test.to_csv("./processed/test_full.csv")

# no filter all data
'''
utils.log("filetering low correlated columns.")
new_corrs = []
columns = app_train.columns.values.tolist()
# iterate through the columns
for col in columns:
    # calculate correlation with the target
    corr = train_labels.corr(app_train[col])
    # append the list as a tuple
    new_corrs.append((col, abs(corr)))

new_corrs = sorted(new_corrs, key=lambda x: (x[1]), reverse=False)

for i in range(100):
    if (new_corrs[i][0] == "SK_ID_CURR"):
        continue
    app_train = app_train.drop(columns=[new_corrs[i][0]])
    app_test = app_test.drop(columns=[new_corrs[i][0]])
'''

app_train.to_csv("./processed/train_filtered.csv")
app_test.to_csv("./processed/test_filtered.csv")

utils.log("normalizing/scaling.")
train = app_train.drop(columns=["SK_ID_CURR"])
test_ids = pandas.DataFrame(app_test[["SK_ID_CURR"]])
test = app_test.drop(columns=["SK_ID_CURR"])
#scaler = MinMaxScaler(feature_range = (0, 1))
scaler = Normalizer()
imputer = SimpleImputer(strategy="median")

utils.log("imputing.")
imputer.fit(train)
train = imputer.transform(train)
test = imputer.transform(test)
scaler.fit(train)
train = scaler.transform(train)
test = scaler.transform(test)

train = numpy.array(train)
test = numpy.array(test)
train_labels = numpy.array(train_labels)

numpy.save("./processed/train.npy", train)
numpy.save("./processed/test.npy", test)
numpy.save("./processed/train_labels.npy", train_labels)
test_ids.to_csv("./processed/test_ids.csv")
