%________________________________________________________________
%The code implements the proposed DTMVC.
% X_v is the v-th view；
% F_v is the discriminative features of the v-th view；
% C_v is the feature anchor graph of the v-th view；
% A_v is the instance anchors of the v-th view；
% G_v is the instance anchor graph of the v-th view；
% Q   is a tensor concatenated by F_v,
% S   is a tensor concatenated by G_v,
% Delta_1 and Delta_2 are the Lagrange multipliers,
% gamma, mu_1, and mu_2 are the hyperparameters.
% _______________________________________________________________
% Parameter setting
% MSRC:        m=3k, r = 2*k, gamma=1.2, mu1 = 0.1, mu2 = 0.1;
% NUS:         m=3k, r = 5*k, gamma=1.2, mu1 = 0.1, mu2 = 0.1;
% Scene-15:    m=5k, r = 2*k, gamma=1.5, mu1 = 0.1, mu2 = 0.1; 
% CCV:         m=3k, r = 1*k, gamma=1.4, mu1 = 0.1, mu2 = 0.1;
% PIE:         m=2k, r = 3*k, gamma=1.4, mu1 = 0.1, mu2 = 0.1;
% cifar-10:    m=3k, r = 2*k, gamma=1.5, mu1 = 0.1, mu2 = 0.1;
% _______________________________________________________________
clear; close all; clc;
addpath(genpath('./'));
datadir='./datasets/';
load('Cifar_10.mat');

%% pre-process, all algs do so
nv = length(X);
k = length(unique(Y));
m = 3*k;
r = 2*k;
gamma = 1.5;

% Normalization
for v = 1:nv
    X{v} = X{v}';
    X{v} = X{v}./(sqrt(sum(X{v}.*X{v},1))+eps);
end

tic;
[G,vo,C] = DTMVC(X, m, r, gamma);
ts = toc;

[Results] = per_eva(G,k,Y);
fprintf('\n Results: ACC: %.4f, NMI: %.4f, F: %.4f, ARI: %.4f', Results(1), Results(2), Results(3), Results(4));



