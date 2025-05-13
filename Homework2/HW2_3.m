clear;
close all;

N=32;
W32=hadamard(N);
a=9;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(a)
a1=W32(:,a+1);
a2=W32(:,24);

reshape(a1,1,32)
reshape(a2,1,32)

figure(1);

OMEGAa=zeros(1,2*N+1);
for n=-N:N
    for i=1:32
        OMEGAa(:,n+33)=OMEGAa(:,n+33)+W32(i,a+1)*W32(i,24);
    end
end
OMEGAa=OMEGAa/32;

stem(-N:1:N,OMEGAa,'filled');
title('$\frac{1}{32}\Sigma_{n=1}^{32}(W_{32}(j,\alpha+1)W_{32}(j,24))$',"Interpreter","latex");
axis([-35,35,-0.5,0.5]);
axis normal;
xlabel('\alpha');
ylabel('Cross-correlation');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(b)
figure(2);
c1=W32(:,a+1);
c2=W32(:,14);

rng(9);
d=randi([0 1],1,5);
for i=1:5
    d(:,i)=(-1)^d(:,i);
end
y0=zeros(1,164);
y1=zeros(1,164);

for i=1:5
    for j=1:32
        y0(:,(i-1)*32+j)=d(:,i);
        y1(:,(i-1)*32+j)=d(:,i)*c1(j,:);
    end
end

subplot(2,1,1);
stem(0:1:163,y0,'filled');
title('Before spreading');
axis([0,165,-1.5,1.5]);
axis normal;
set(gca,'XTick',[0:32:163]);
xlabel('t');
ylabel('Amplitude');

subplot(2,1,2);
stem(0:1:163,y1,'filled');
title('After spreading');
axis([0,165,-1.5,1.5]);
axis normal;
set(gca,'XTick',[0:32:163]);
xlabel('t');
ylabel('Amplitude');

sgtitle('3-(b) Spreading');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(c)
figure(3);

pc=zeros(1,5);
for i=0:4
    for j=1:32
        pc(:,i+1)=pc(:,i+1)+y1(:,32*i+j+1)*c1(j,:);
    end
end
pc=pc/32;

stem(0:1:4,pc,'filled');
title('3-(d) Perfect synchronization is not achieved');
axis([-1,5,-1,1]);
axis normal;
xlabel('i');
ylabel('p(i)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(d)
figure(4);

pd=zeros(1,5);
for i=0:4
    for j=1:32
        pd(:,i+1)=pd(:,i+1)+y1(:,32*i+j)*c2(j,:);
    end
end
pd=pd/32;

stem(0:1:4,pd,'filled');
title('3-(e) Perfect synchronization is achieved');
axis([-1,5,-1,1]);
axis normal;
xlabel('i');
ylabel('p(i)');