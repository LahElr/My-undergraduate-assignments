import numpy as np
import torch
import torch.nn as nn
from torch.optim import Adam
from Models import LR, LLR, LLR_noise
from Data.Datasets import get_mnist_train, get_mnist_test
from opacus import PrivacyEngine


train_loader = get_mnist_train()
test_loader = get_mnist_test()


# Train model
# model = LR(784, 10)
model = LLR(784, 10)
# model = LLR_noise(784, 10)
optimizer = Adam(model.parameters())
loss_func = nn.MSELoss()
device = torch.device('cuda:0')

model = model.to(device)

# privacy_engine = PrivacyEngine(
#     model,
#     sample_rate=0.01,
#     alphas=[1, 10, 100],
#     noise_multiplier=1.3,
#     max_grad_norm=1.0,
# )
# privacy_engine.attach(optimizer)

def to_tensor(x: np.ndarray):
    return torch.from_numpy(x).to(device)


def to_numpy(x: torch.Tensor):
    return x.cpu().detach().numpy()


def train(n_iters: int = 100000, batch_size: int = 64, test_per_iter: int = 100):
    for i in range(n_iters):
        if i % test_per_iter == 0:
            xs, ys = test_loader.get_batch_xy(5000)
            pred_ys = to_numpy(model(to_tensor(xs)))
            acc = np.mean(np.argmax(ys, axis=1) == np.argmax(pred_ys, axis=1))
            print(f"Iteration {i:7d}, accuracy {acc:.4f}")
        xs, ys = train_loader.get_batch_xy(batch_size)
        loss = loss_func(model(to_tensor(xs)), to_tensor(ys))
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()


if __name__ == '__main__':
    train()
