import torch
import numpy
import math
import pandas
import torch.nn as nn
import torch.nn.functional as F
from torch.optim import Adam
from torch.utils.data import Dataset
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt
from model import LinearModel, NaiveWeightModel, default_risk_dataset, device, get_train_test_dataset, evaluate_AUC


def to_tensor(x: numpy.ndarray):
    return torch.from_numpy(x).to(device)


def to_numpy(x: torch.Tensor):
    return x.cpu().detach().numpy()


def early_stop(losses, accs):
    l = 3  # early stop if the model doesnot improve in l epoches
    if len(losses) < l or len(accs) < l:
        return False
    cur_loss = losses[-1]
    cur_acc = accs[-1]
    for loss in losses[-l:-1]:
        if loss > cur_loss:
            return False
    for acc in accs[-l:-1]:
        if acc < cur_acc:
            return False


train = numpy.load("./processed/train.npy").astype(numpy.float32)
test = numpy.load("./processed/test.npy").astype(numpy.float32)
label = numpy.load("./processed/train_labels.npy").astype(numpy.float32)
test_ids = pandas.read_csv("./processed/test_ids.csv")

X_train, X_test, y_train, y_test = get_train_test_dataset(train, label)

train_loader = DataLoader(default_risk_dataset(X_train, y_train),
                          batch_size=64,
                          shuffle=True,
                          num_workers=4)
test_loader = DataLoader(default_risk_dataset(X_test, y_test),
                         batch_size=64,
                         shuffle=True,
                         num_workers=4)
eval_loader = DataLoader(default_risk_dataset(test),
                         batch_size=64,
                         shuffle=True,
                         num_workers=4)

model = NaiveWeightModel(X_train.shape[1], 2,
                         math.ceil(X_train.shape[1] * 0.8)).to(device)
# model = LinearModel(X_train.shape[1], 2, math.ceil(X_train.shape[1] * 0.8),
#                     2).to(device)
# model = LinearModel(X_train.shape[1], 2, math.ceil(X_train.shape[1] * 0.8),
#                     1).to(device)

print("using model {}:".format(model.__class__.__name__), end="")
print("(", X_train.shape[1], 2, math.ceil(X_train.shape[1] * 0.8), 1, ")")
print("lr=0.01")
print("n_epoch=50")
print("use sigmoid as act_f")

# print(model)
# for p in model.parameters():
#     print(p)
# exit(0)

optimizer = Adam(model.parameters(), lr=0.01)
loss_func = nn.MSELoss()

model.train()
report_every = 5


def train_model(n_epoch=50):
    try:
        epoch_losses = []
        epoch_accuracies = []
        for epoch in range(n_epoch):
            if epoch == 0:
                print("train start!")
            elif epoch % report_every == 0:
                print("it's epoch {} now! loss {} acc {}.".format(
                    epoch, epoch_losses[-1], epoch_accuracies[-1]))
            for step, data in enumerate(train_loader):
                x, y, labels = data
                x = x.to(device)
                y = y.to(device)

                optimizer.zero_grad()
                y_pred = model(x)
                loss = loss_func(y_pred, y).float()
                loss.backward()
                optimizer.step()

            eval_losses = []
            eval_accuracies = []
            for step, data in enumerate(test_loader):
                x, y, labels = data
                x = x.to(device)
                y = y.to(device)
                y_pred = model(x)

                loss = loss_func(y_pred, y)
                eval_losses.append(to_numpy(loss))

                labels = to_numpy(labels)
                y_pred = y_pred.cpu().detach().numpy()
                pred = numpy.argmax(y_pred, axis=1).reshape(-1)
                eval_accuracy = numpy.sum(
                    pred == labels.astype(numpy.int)).astype(numpy.int)
                eval_accuracies.append(eval_accuracy / len(labels))
                # print(eval_accuracy/len(labels))

            epoch_loss = numpy.mean(eval_losses)
            epoch_losses.append(epoch_loss)
            epoch_accuracy = numpy.mean(eval_accuracies)
            epoch_accuracies.append(epoch_accuracy)
            # print(epoch_accuracy,epoch_loss)
            if early_stop(epoch_losses, epoch_accuracies):
                print("early_stop")
                break
    except KeyboardInterrupt:
        pass
    return epoch_losses, epoch_accuracies


losses, accuracies = train_model()

print("-" * 17)
print("train losses:")
print(losses)
print("-" * 17)
print("train accuracies:")
print(accuracies)
print("-" * 17)

plt.figure(figsize=(8, 8))
fig, ax1 = plt.subplots()
ax1.plot(list(range(len(losses))), losses, color="green", label="loss")
ax1.set_xlabel("epoch")
ax1.set_ylabel("loss")
ax2 = ax1.twinx()
ax2.plot(list(range(len(accuracies))), accuracies, color="blue", label="acc")
ax2.set_ylabel("acc")
fig.legend(loc="upper right")

plt.title("train loss & acc of {}".format(model.__class__.__name__))
plt.tight_layout()
plt.savefig("logs/statistic_{}.png".format(model.__class__.__name__))
plt.show()

torch.save(model.state_dict(),
           "models/dl_{}.pth".format(model.__class__.__name__))
# model.load_state_dict(torch.load(path))

final_predict = test_ids
model.eval()
preds = []
for step, data in enumerate(eval_loader):
    x, _, _ = data
    x = x.to(device)
    y_pred = model(x)
    y_pred = to_numpy(y_pred)
    pred = y_pred[:, 1].reshape(-1).tolist()
    # print(pred)
    preds += pred

final_predict["TARGET"] = preds
final_predict.drop(columns=["Unnamed: 0"], inplace=True)
final_predict.to_csv("./result/resultkaggle_{}.csv".format(
    model.__class__.__name__),
                     index=None)
