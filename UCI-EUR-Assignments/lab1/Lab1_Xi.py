# import packages
import pandas
import numpy

# read in data
data = pandas.read_csv("Cereals.csv")
print(data.head()) # see the data

# Summary Statistics
# statistic of numeric values
print(data.describe())
# statistic of discreate values
print(data["mfr"].value_counts())
print("-"*17)
print(data["type"].value_counts())
data.shape

# # Quantitative/Numerical
# find the columns with values with less than 10 choices and print them
for col in data.columns:
    ct = data[col].unique().__len__()
    print(col,":",ct,end="\t")
    if ct < 10:
        print(data[col].unique(),end="")
    print()

# ## conclude
# 
# So the `mfr`, `type` are nominal; `protein`, `shelf`, `fat` are ordinal
# 
# `vitamin` seems to be quantitative, but why there's only 3 possible values?
# 
# and others are quantitative.

# # Histogram
# import pyplot
from matplotlib import pyplot as plt
import math

# this function aims at plot a histogram of specified data, with a specified bin size
def histo(datas,interval,name,do_save):
    plt.figure(figsize=(4,4)) # fig size
    lim_right = (math.ceil(max(datas)/interval))*interval # x range
    lim_left = (math.floor(min(datas)/interval))*interval # x range
    hist = plt.hist(datas,bins = numpy.arange(lim_left,lim_right+interval/2,interval).tolist(),edgecolor="blue") # hist
    # annotate the pillars
    for i in range(len(hist[0])):
        plt.annotate(text=int(hist[0][i]), xy=(hist[1][i] + interval / 3, hist[0][i]))
    plt.title("histogram of {}, bin size {}".format(name,interval)) # title
    # save figs
    if do_save:
        plt.savefig("figs/histo_{}.png".format(name))
    plt.show()

quantitative_cols = ["calories","sodium","fiber","carbo","sugars","potass","vitamins","cups","rating"] # the columns to be plotted
for col in quantitative_cols:
    datas = data[col].values
    span = max(datas)-min(datas)
    interval = 20 if span >= 140 else 10 if span >=50 else 5 if span >= 20 else 2 if span >= 10 else 1 if span >= 5 else 0.5 if span >=2 else 0.2 # choose bin size
    histo(datas,interval,col,True)

# ## Conclude
# 
# * `potass` and `sodium` have the largest variability.
# * `rating`, `potass`, `vitamins` and `fiber` seems skewed.
#     * in `rating`, the only max value seems extreme
#     * in `potass`, the 2 max values seems extreme
#     * in `sodium`, the 11 min vlaues seems extreme
#     * in `calories`, the 3 min values seems extreme
# 

# # Boxplot
import seaborn

# plot boxplot
fig = seaborn.boxplot(
    data=data,
    x = "shelf",
    y = "rating",
    palette=[seaborn.xkcd_rgb["blue"], seaborn.xkcd_rgb["green"],seaborn.xkcd_rgb["yellow"]], # the colors
    showmeans=True,
    notch = True
)
fig.set_title("bosplot statistic of rating to shelf")
fig.figure.savefig("figs/boxplot_rating_to_shelf") # save
plt.show() # show the plot

# # Correlation
corr = data.corr()
corr_abs = corr.applymap(lambda x:abs(x)) # apply the absolute
seaborn.heatmap(data.corr().applymap(lambda x:abs(x))) # plot the heatmap

print(data.corr()["rating"]) # see the correlations to the rating

print(corr_abs[(corr_abs > 0.6) & (corr_abs != 1)]) # show the correlations with absolute value over 0.6 and not 1

# Normalization / Scaling
from sklearn.preprocessing import Normalizer
from sklearn.preprocessing import LabelEncoder
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import MinMaxScaler

data_norm = data.drop("name",axis=1,inplace=False) # drop the name

# encode the strings
label_encoder = LabelEncoder()
for col in data_norm.columns:
    if data_norm[col].dtype == "object":
        data_norm[col] = label_encoder.fit_transform(data_norm[col])

# fill the missing values
imputer = SimpleImputer(strategy='mean')
data_norm_values = imputer.fit_transform(data_norm)
data_norm = pandas.DataFrame(data_norm_values,columns=data_norm.columns) # and fille the numpy array we get back in the data frame

# Scaling
data_scaled_values = MinMaxScaler().fit_transform(data_norm)
data_scaled = pandas.DataFrame(data_scaled_values,columns=data_norm.columns) # and fille the numpy array we get back in the data frame

# Normalization
data_norm_values = Normalizer().fit_transform(data_norm)
data_norm = pandas.DataFrame(data_norm_values,columns=data_norm.columns) # and fille the numpy array we get back in the data frame

# see
print(data_norm)
print(data_scaled)

# this function aims at plot histogram of every column of the specified data frame
def statistic(df):
    for col in df.columns:
        datas = df[col].values
        interval = 0.1
        histo(datas,interval,col,False)

# see
statistic(data_norm)
statistic(data_scaled)

# see the correlation of normed/scaled data
corr = data_norm.corr()
corr_abs = corr.applymap(lambda x: abs(x))
corr_abs[(corr_abs > 0.6) & (corr_abs != 1)]
corr = data_scaled.corr()
corr_abs = corr.applymap(lambda x: abs(x))
corr_abs[(corr_abs > 0.6) & (corr_abs != 1)]

# ## Conclude
# 
# a)Which pair of variables is the most strongly correlated?
# 
# potass and fiber are most strongly correlated
# 
# b)How can we reduce the number of variables based on these correlations?
# 
# only leave the columns most correlated to consumer rating or use dim-reduce algors PCA/t-SNE
# 
# c)How would the corrections change if we normalize this data first?
# 
# changed.
# 

# # PCA & LR
from sklearn.decomposition import PCA
from sklearn.model_selection import train_test_split

x = data_scaled.drop(columns=["rating"],axis=1,inplace = False) # X
x = x.to_numpy()
y = data_scaled["rating"].values # y

pca = PCA(n_components=3)
pca.fit(x) # fit pca
print(pca.explained_variance_ratio_) # see
print(pca.singular_values_) # see
xx = pca.transform(x) # do dim-reduce

# split train and test
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.3, random_state=12345)
xx_train, xx_test, yy_train, yy_test = train_test_split(xx, y, test_size=0.3, random_state=12345)

# regression
from sklearn.svm import SVR
from sklearn.linear_model import SGDRegressor
from sklearn.linear_model import BayesianRidge
from sklearn.linear_model import LassoLars
from sklearn.linear_model import ARDRegression
from sklearn.linear_model import PassiveAggressiveRegressor
from sklearn.linear_model import TheilSenRegressor
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

# models to use
models = [SVR,SGDRegressor,BayesianRidge,LassoLars,ARDRegression,PassiveAggressiveRegressor,TheilSenRegressor,LinearRegression]

# fit and test with data without pca
for model_cls in models:
    model = model_cls()
    model.fit(x_train,y_train)
    pred = model.predict(x_test)
    acc = mean_squared_error(y_test,pred)
    print("test mse of model {} without pca is {}.".format(model.__class__.__name__, acc))

# fit and test with data applied pca
for model_cls in models:
    model = model_cls()
    model.fit(xx_train,yy_train)
    pred = model.predict(xx_test)
    acc = mean_squared_error(yy_test,pred)
    print("test mse of model {} with pca is {}.".format(model.__class__.__name__, acc))
