clear;
close all;
load("HW6-3.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-a
Signal1=OFDMRx1(1,17:80);
Signal2=OFDMRx2(1,17:80);

Y1=fft(Signal1);
Y2=fft(Signal2);
f=0:1:63;

figure(1);
subplot(2,1,1);
stem(f,real(Y1),'filled');
title('Real Part');
axis([0,65,-6,6]);
axis normal;
xlabel('Subcarrier N');
ylabel('magnitude');

subplot(2,1,2);
stem(f,imag(Y1),'filled');
title('Image Part');
axis([0,65,-6,6]);
axis normal;
xlabel('Subcarrier N');
ylabel('magnitude');

sgtitle('3-(a) Frequency domain of OFDMRx1');


figure(2);
subplot(2,1,1);
stem(f,real(Y2),'filled');
title('Real Part');
axis([0,65,-6,6]);
axis normal;
xlabel('Subcarrier N');
ylabel('magnitude');

subplot(2,1,2);
stem(f,imag(Y2),'filled');
title('Image Part');
axis([0,65,-6,6]);
axis normal;
xlabel('Subcarrier N');
ylabel('magnitude');

sgtitle('3-(a) Frequency domain of OFDMRx2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-b
X1=zeros(1,64);

for i=1:64
    if mod(i-1,2)==0
        X1(1,i)=-1-3*j;
    else
        X1(1,i)=3+1*j;
    end
end

Hk1=Y1./X1;

figure(3);
stem(f,abs(Hk1),'filled');
axis([0,65,0,2]);
axis normal;
xlabel('k');
ylabel('magnitude');

sgtitle('3-(b) Magnitude of channel frequency response |H_k^(^1^)|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-c
X2=zeros(1,64);

for i=1:64
    if mod(i-1,2)==0
        X2(1,i)=0;
    elseif mod(i-1,4)==1
        X2(1,i)=-1-3*j;
    else
        X2(1,i)=3+1*j;
    end
    
end

Hk2=Y2./X2;

for i=1:31
    j=2*i+1;
    Hk2(1,j)=(Hk2(1,j-1)+Hk2(1,j+1))/2;
end

figure(4);
stem(f,abs(Hk2),'filled');
axis([0,65,0,2]);
axis normal;
xlabel('k');
ylabel('magnitude');

sgtitle('3-(c) Magnitude of channel frequency response |H_k^(^2^)|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-d
H=Hk1-Hk2;

figure(5);
stem(f,abs(H),'filled');
axis([0,65,0,0.1]);
axis normal;
xlabel('k');
ylabel('magnitude');

sgtitle('3-(d) Compare difference |H_k^(^1^)-H_k^(^2^)|');