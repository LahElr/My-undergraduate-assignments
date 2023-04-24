from lightgbm import LGBMClassifier
from xgboost import XGBClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.linear_model import LogisticRegression

import pickle
import numpy
import pandas

from model import evaluate_AUC, get_train_test_dataset

train = numpy.load("./processed/train.npy")
test = numpy.load("./processed/test.npy")
train_labels = numpy.load("./processed/train_labels.npy")

X_train, X_test, y_train, y_test = get_train_test_dataset(train, train_labels)

models = []

# parameter approximted from predecessors' work
model = LGBMClassifier(
    n_estimators=10000,
    learning_rate=0.02,
    num_leaves=34,
    colsample_bytree=0.95,
    subsample=0.8,
    max_depth=8,
    reg_alpha=0.04,
    reg_lambda=0.07,
    min_split_gain=0.022,
    min_child_weight=39,
    silent=-1,
    verbose=-1,
)
model.fit(X_train,
          y_train,
          eval_set=[(X_train, y_train), (X_test, y_test)],
          eval_metric='auc',
          verbose=200,
          early_stopping_rounds=200)
y_pred = model.predict_proba(X_test)[:, 1]
evaluate_AUC(y_pred, y_test, model.__class__.__name__)
models.append(model)

# simple and naive
model = LGBMClassifier()
model.fit(X_train,y_train)
y_pred = model.predict_proba(X_test)[:, 1]
evaluate_AUC(y_pred, y_test, "{}_x".format(model.__class__.__name__))
models.append(model)

'''

model = XGBClassifier(learning_rate=0.05, n_estimators=20, max_depth=5)
model.fit(X_train, y_train)
y_pred = model.predict_proba(X_test)[:, 1]
evaluate_AUC(y_pred, y_test, model.__class__.__name__)
models.append(model)

model = GradientBoostingClassifier(learning_rate=0.3,
                                   n_estimators=10,
                                   max_depth=2)
model.fit(X_train, y_train)
y_pred = model.predict_proba(X_test)[:, 1]
evaluate_AUC(y_pred, y_test, model.__class__.__name__)
models.append(model)

model = LogisticRegression(C=0.0001)
model.fit(X_train, y_train)
y_pred = model.predict_proba(X_test)[:, 1]
evaluate_AUC(y_pred, y_test, model.__class__.__name__)
models.append(model)

'''

for model in models:
    final_predict = pandas.read_csv("./processed/test_ids.csv")
    y_evaluate_label = model.predict_proba(test)[:, 1]
    final_predict["TARGET"] = y_evaluate_label
    final_predict.to_csv("./result/resultkaggle_{}.csv".format(
        model.__class__.__name__),
                         index=None)
