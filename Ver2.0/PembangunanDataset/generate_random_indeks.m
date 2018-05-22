close all;
clear;
clc;

indeks_all = randperm(1000);
indeks_pengamatan = indeks_all(1:800);
indeks_test = indeks_all(801:1000);
% save indeks indeks_pengamatan indeks_test;