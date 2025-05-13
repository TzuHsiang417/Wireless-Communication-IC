clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1-a
load("HW5-1a.mat");
GZF=inv(Hmatrix)
x1_bar=GZF*y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1-b
load("HW5-1b.mat");
x2prime=GZF*yprime
noise=yprime-y
x2_bar=x2prime-GZF*noise