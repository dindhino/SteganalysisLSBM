close all;
clear;
clc;

load tntn;
load dataset;

dataset2 = dataset(1:200,:);
dataset2 = [dataset2; dataset(tntn,:)];
aaa = [1 2 3 5 6 8 9 12 13 14 15 16 17 19 20 21 22 23 25 26 27 28 29 30 31 32 33 34 35 38 39 40 41 42 43 44 45 46 47 48 50 51 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 74 75];
aaa = aaa+1000;
dataset2 = [dataset2; dataset(aaa,:)];

dataset = dataset2;
% save dataset2 dataset;