#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize
from scipy.special import expit

def draw_data(X, Y):
    pos = Y == 1
    neg = Y == 0
    plt.scatter(X[pos, 0], X[pos, 1], marker='o', c='b', label='positive')
    plt.scatter(X[neg, 0], X[neg, 1], marker='x', c='r', label='negative')
    plt.xlabel('Feature1/Exam 1 score')
    plt.ylabel('Feature2/Exam 2 score')
    plt.legend(frameon= True, fancybox = True)

def cost(theta, X, Y):
    m = X.shape[0]
    h = expit(X.dot(theta))
    # J = -1.0 * (1.0 / m) * (np.log(h).T.dot(Y) + np.log(1 - h).T.dot(1 - Y))
    J = -1.0 * (np.log(h).T.dot(Y) + np.log(1 - h).T.dot(1 - Y))
    if np.isnan(J):
        return np.inf
    return J

def grad(theta, X, Y):
    m = X.shape[0]
    h = expit(X.dot(theta))
    # grad = (1.0 / m) * X.T.dot(h - Y)
    grad = X.T.dot(h - Y)
    return grad

def predict(theta, x, threshold=0.5):
    p = expit((x / 10.0).dot(theta)) >= 0.5
    return p.astype('int')

def draw_line(X, theta):
    plt.scatter(4.5, 8.5, s=60, c='r', marker='v', label='(45, 85)')
    x1_min, x1_max = X[:,0].min(), X[:,0].max(),
    x2_min, x2_max = X[:,1].min(), X[:,1].max(),
    x1, x2 = np.meshgrid(np.linspace(x1_min, x1_max), np.linspace(x2_min, x2_max))
    fx1, fx2 = x1.ravel(), x2.ravel()
    h = expit(np.c_[np.ones((fx1.shape[0],1)), fx1, fx2].dot(theta))
    h = h.reshape(x1.shape)
    plt.contour(x1, x2, h, [0.5], linewidths=1, colors='b');

#load the dataset
data = np.loadtxt('data1.txt', delimiter=',')
X = data[:, 0:2] / 10.0
Y = data[:, 2]

# preview data
draw_data(X, Y)

eX = np.c_[np.ones((X.shape[0], 1)), X]

theta = np.zeros(eX.shape[1])
co = cost(theta, eX, Y)
gra = grad(theta, eX, Y)
print('Cost: \n', co)
print('Grad: \n', gra)

res = minimize(cost, theta, args=(eX,Y), jac=grad, options={'maxiter':400})
# print(res)
theta = res.x.T

p = expit(np.array([1, 45, 85]) / 10.0).dot(theta)

draw_line(X, theta)
plt.show()
