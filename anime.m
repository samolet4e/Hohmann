clear;

global ER mu;
ER = 6378137.; % m
%mu = 3.986004418E+14; % m^3.s^-2
mu = 3.986004418E+5; % km^3.s^-2

X = dlmread('data.csv');
%X = csvread('data.csv');

[hj] = paintSatellite(X(:,1:6));

