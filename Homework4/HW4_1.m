clear;
close all;
rng(20);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1-a
r1=-pi/2+pi*rand(1,1)
t1=-pi/2+pi*rand(1,1)

aULAr1=zeros(128,1);
aULAt1=zeros(1,1);

for i=1:128
    aULAr1(i,:)=exp(j*(i-1)*pi*sin(r1));
end

aULAt1=1;

H1=aULAr1*aULAt1;
H1_reshape=reshape(H1,1,128)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1-b
figure(1);
m=-64:1:63;
c=zeros(128:1);

for i=1:128
    c(i,:)=exp(j*2*pi*m*(i-1)/128);
end

combineb=abs((c')*H1);

stem(m,combineb,'filled');
title('1-(b) |c(m)^HH_1| versus m');
axis([-65,65,0,100]);
axis normal;
xlabel('m');
ylabel('|c(m)^HH_1|');

figure(2);
ww=asin(2*m/128);
polar(ww',combineb);
title('1-(b) |c(m)^HH_1| versus m wind rose chart');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1-c
figure(3)
L=2;
a1=0.8;
a2=0.2;

r2=r1+0.25;
t2=t1;

aULAr2=zeros(128,1);
for i=1:128
    aULAr2(i,:)=exp(j*(i-1)*pi*sin(r2));
end

aULAt2=aULAt1;

H2=zeros(128,1);
H2(:,1)=(a1*aULAr1*aULAt1+a2*aULAr2*aULAt2)/sqrt(2);
H2_reshape=reshape(H2,1,128)

combineb2=abs((c')*H2);

stem(m,combineb2,'filled');
title('1-(c) |c(m)^HH_2| versus m');
axis([-65,65,0,100]);
axis normal;
xlabel('m');
ylabel('|c(m)^HH_2|');

figure(4);
ww=asin(2*m/128);
polar(ww',combineb2);
title('1-(c) |c(m)^HH_2| versus m wind rose chart');