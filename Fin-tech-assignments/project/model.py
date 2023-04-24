from sklearn.metrics import roc_auc_score
from sklearn.model_selection import train_test_split


def evaluate_AUC(y_pred, y_true,name):
    score = roc_auc_score(y_true, y_pred)
    print("The ROC_AUC score of mode {} is {}.".format(name,score))
        


def get_train_test_dataset(total_train, total_train_labels):
    X_train, X_test, y_train, y_test = train_test_split(total_train,
                                                        total_train_labels,
                                                        test_size=0.3,
                                                        random_state=31)
    return X_train, X_test, y_train, y_test


import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.optim import Adam

device = torch.device("cuda:1")


class LinearModel(nn.Module):
    def __init__(self, in_feat, out_feat, hidden_feat, hidden_layer_count):
        super(LinearModel, self).__init__()
        self.layers = []
        self.layers.append(nn.Linear(in_feat, hidden_feat))
        for i in range(hidden_layer_count):
            self.layers.append(
                nn.Linear(hidden_feat, hidden_feat))
            self.layers.append(nn.Sigmoid())
        self.layers.append(nn.Linear(hidden_feat, out_feat))
        self.layers.append(nn.Sigmoid())
        self.layers = nn.Sequential(*self.layers)

    def forward(self, x):
        x = self.layers(x)
        return x


class NaiveWeightModel(nn.Module):
    def __init__(self, in_feat, out_feat, hidden_feat):
        super(NaiveWeightModel, self).__init__()
        self.weight_layers = [
            nn.Linear(in_feat, hidden_feat), nn.Sigmoid(),
            nn.Linear(hidden_feat, hidden_feat), nn.Sigmoid()
        ]
        self.weight_layers = nn.Sequential(*self.weight_layers)
        self.head_layers = [
            nn.Linear(in_feat, hidden_feat), nn.Sigmoid()
        ]
        self.head_layers = nn.Sequential(*self.head_layers)
        self.tail_layers = [
            nn.Linear(hidden_feat, out_feat), nn.Sigmoid()
        ]
        self.tail_layers = nn.Sequential(*self.tail_layers)

    def forward(self, x):
        w = self.weight_layers(x)
        x = self.head_layers(x)
        x = x * w
        x = self.tail_layers(x)
        return x


from torch.utils.data import Dataset
import numpy
'''
train = numpy.load("./processed/train.npy", train)
test = numpy.load("./processed/test.npy", test)
label = numpy.load("./processed/train_labels.npy", train_labels)
test_ids = pandas.read_csv("./processed/test_ids.csv")
'''


class default_risk_dataset(Dataset):
    def __init__(self, x, y=None):
        self.x = x
        self.y = y
        self.has_label = (y is not None)
        self.length = x.shape[0]
        if y is not None and y.shape[0] != x.shape[0]:
            raise RuntimeError("x and y not same length.")

    def __len__(self):
        return self.length

    def __getitem__(self, index):
        x = self.x[index]
        label = 3 if self.y is None else self.y[index]
        y = [3.,3.] if self.y is None is None else (numpy.eye(2)[int(label)]).astype(numpy.float32)
        return (x, y, label)
