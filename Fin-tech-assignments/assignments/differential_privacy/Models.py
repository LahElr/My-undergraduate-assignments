import torch
import torch.nn as nn
import numpy as np
from torch.optim import Adam
from Data.Datasets import eps


# 最简单的逻辑回归模型
class LR(nn.Module):
    def __init__(self, input_dim: int, output_dim: int):
        super(LR, self).__init__()
        self.linear = nn.Linear(input_dim, output_dim)

    def forward(self, x):
        return torch.sigmoid(self.linear(x))


class LLR(nn.Module):
    def __init__(self, input_dim: int, output_dim: int):
        super(LLR, self).__init__()
        self.linear_1 = nn.Linear(input_dim, int((output_dim + input_dim) / 2))
        self.linear_2 = nn.Linear(int((output_dim + input_dim) / 2), output_dim)

    def forward(self, x):
        x = torch.sigmoid(self.linear_1(x))
        x = torch.sigmoid(self.linear_2(x))
        return x


class LLR_noise(nn.Module):
    def __init__(self, input_dim: int, output_dim: int):
        super(LLR_noise, self).__init__()
        self.linear_1 = nn.Linear(input_dim, int((output_dim + input_dim) / 2))
        self.linear_2 = nn.Linear(int((output_dim + input_dim) / 2), output_dim)
        self.sampler = torch.distributions.laplace.Laplace(0.0,(1.0/eps))

    def forward(self, x):
        x = torch.sigmoid(self.linear_1(x))
        # noise = np.random.laplace(loc=0,scale=(1.0/eps),size=xs.shape)
        noise = self.sampler.sample(sample_shape=x.shape)
        x = torch.sigmoid(self.linear_2(x))
        return x
