clear;
close all;
load("HW5-2.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-a
G0=inv(Hmatrix);

ROW1=abs(G0(1,1))^2+abs(G0(1,2))^2+abs(G0(1,3))^2
ROW2=abs(G0(2,1))^2+abs(G0(2,2))^2+abs(G0(2,3))^2
ROW3=abs(G0(3,1))^2+abs(G0(3,2))^2+abs(G0(3,3))^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-b
Alpha1=1;

xa1=G0(Alpha1,:)*yprime
xbar=G0*yprime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-c
H1=Hmatrix;
H1(:,Alpha1)=[]
G1=inv(H1'*H1)*H1';

y1=yprime-Hmatrix(:,Alpha1)*(-1+3*j)
x1=G1*y1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-d
ROW1=abs(G1(1,1))^2+abs(G1(1,2))^2+abs(G1(1,3))^2
ROW2=abs(G1(2,1))^2+abs(G1(2,2))^2+abs(G1(2,3))^2

Alpha2=2;
xa2=G1(Alpha2-1,:)*y1

H2=H1;
H2(:,Alpha2-1)=[]
G2=inv(H2'*H2)*H2';

y2=y1-H1(:,Alpha2-1)*(-3+1*j)
x2=G2*y2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-e
Alpha3=3;
xa3=G2(Alpha3-2,:)*y2