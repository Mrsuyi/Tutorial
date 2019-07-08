#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize
from scipy.special import expit
from sklearn.preprocessing import PolynomialFeatures

def draw_data(axe, X, Y):
    pos = Y == 1
    neg = Y == 0
    axe.scatter(X[pos, 0], X[pos, 1], marker='o', c='b', label='positive')
    axe.scatter(X[neg, 0], X[neg, 1], marker='x', c='r', label='negative')
    axe.set_xlabel('Feature1/Exam 1 score')
    axe.set_ylabel('Feature2/Exam 2 score')
    axe.legend(frameon= True, fancybox = True)

# def cost(theta, X, Y):
def cost(theta, reg, X, Y):
    m = X.shape[0]
    h = expit(X.dot(theta))
    # J = -1.0 * (1.0 / m) * (np.log(h).T.dot(Y) + np.log(1 - h).T.dot(1 - Y))
    J = -1.0 * (1.0 / m) * (np.log(h).T.dot(Y) + np.log(1 - h).T.dot(1 - Y)) + (reg / (2.0 * m)) * np.sum(np.square(theta[1:]))
    if np.isnan(J):
        return np.inf
    return J

# def grad(theta, X, Y):
def grad(theta, reg, X, Y):
    m = X.shape[0]
    h = expit(X.dot(theta))
    # grad = (1.0 / m) * X.T.dot(h - Y)
    grad = (1.0 / m) * X.T.dot(h - Y) + np.r_[[0], ((reg / m) * theta[1:])]
    return grad

def predict(theta, X, threshold=0.5):
    p = expit(X.dot(theta)) >= threshold
    return p.astype('int')

def draw_line(axe, X, theta):
    x1_min, x1_max = X[:,0].min(), X[:,0].max(),
    x2_min, x2_max = X[:,1].min(), X[:,1].max(),
    x1, x2 = np.meshgrid(np.linspace(x1_min, x1_max), np.linspace(x2_min, x2_max))
    fx1, fx2 = x1.ravel(), x2.ravel()
    h = expit(PolynomialFeatures(6).fit_transform(np.c_[fx1, fx2]).dot(theta))
    h = h.reshape(x1.shape)
    axe.contour(x1, x2, h, [0.5], linewidths=1, colors='b');

#load the dataset
data = np.loadtxt('data2.txt', delimiter=',')
X = data[:, 0:2]
Y = data[:, 2]
eX = PolynomialFeatures(6).fit_transform(X)
theta = np.zeros(eX.shape[1])
fig, axes = plt.subplots(1, 3, sharey=True, figsize=(17,5))

for i, reg in enumerate([0, 1, 10]):
    # Add more features
    res = minimize(cost, theta, args=(reg, eX, Y), jac=grad, options={'maxiter':4000})
    theta = res.x.T

    accuracy = 100.0 * np.sum(predict(theta, eX) == Y) / Y.size

    draw_data(axes[i], X, Y)
    draw_line(axes[i], X, theta)
    axes[i].set_title('Regularization Lambda: {},  Accuracy: {}%'.format(reg, np.round(accuracy, decimals = 2)))

plt.show()
