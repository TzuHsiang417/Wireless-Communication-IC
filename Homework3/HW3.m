clear;
close all;
rng(20);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Quation 1
figure(1);
P=[0 -3 -5 -8 -15];
D=[0 20 60 80 100];

Pout=10.^(P/10)
D

plot(D(:,1),Pout(:,1),'r*',D(:,2),Pout(:,2),'r*',D(:,3),Pout(:,3),'r*',D(:,4),Pout(:,4),'r*',D(:,5),Pout(:,5),'r*');
title('1-(a) The power ratio of 5 taps');
axis([0,100,0,1]);
axis normal;
yticks(0:0.1:1);
xlabel('delay \tau_i(ns)');
ylabel('Pout / Pin');
hold on;

Psum=Pout(:,1)+Pout(:,2)+Pout(:,3)+Pout(:,4)+Pout(:,5);
Pnorm=zeros(1,5);
for i=1:5
    Pnorm(:,i)=Pout(:,i)/Psum;
end

Tmean=(Pout(:,1)*D(:,1)+Pout(:,2)*D(:,2)+Pout(:,3)*D(:,3)+Pout(:,4)*D(:,4)+Pout(:,5)*D(:,5))/Psum

T2mean=(Pout(:,1)*D(:,1).^2+Pout(:,2)*D(:,2).^2+Pout(:,3)*D(:,3).^2+Pout(:,4)*D(:,4).^2+Pout(:,5)*D(:,5).^2)/Psum;

Trms=sqrt(T2mean-Tmean.^2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Quation 2
variance=1;

P=[0 -3 -5 -8 -15];
D=[0 20 60 80 100];
Pout=10.^(P/10);

r=sqrt(variance/2)*(randn(1,5)+j*randn(1,5))
r=(r-mean(r))/sqrt(var(r));

rx=(real(r)-mean(real(r)))/sqrt(var(real(r))*2);
ry=(imag(r)-mean(imag(r)))/sqrt(var(imag(r))*2);
r=rx+j*ry


rmean=mean(r)
rvar=var(r)
rxvar=var(real(r))
ryvar=var(imag(r))

g=r.*Pout
k=1/sqrt(sum(abs(g).^2))
h=k*g
hi2sum=(abs(h(:,1))).^2+(abs(h(:,2))).^2+(abs(h(:,3))).^2+(abs(h(:,4))).^2+(abs(h(:,5))).^2

f50=50*10^6;
f=-f50:f50/5000:f50;
X=zeros(1,length(f));

for i=1:5
    X=X+h(:,i)*exp(-j*2*pi*f*D(:,i)*10^(-9));
end

figure(2);
subplot(2,1,1);
plot(f,abs(X));
title('Magnitude of channel frequency responce');
axis([-f50,f50,-1,2]);
axis normal;
xlabel('frequency(Hz)');
ylabel('magnitude');

subplot(2,1,2);
plot(f,angle(X));
title('Phase of channel frequency responce');
axis([-f50,f50,-pi,pi]);
axis normal;
yticks(-pi:pi:pi);
set(gca,'YTickLabel',{'-\pi','0','\pi'})
xlabel('frequency(Hz)');
ylabel('phase');

sgtitle('2-(c) Plot the magnitude and phase of channel frequency responce');

Bc=1/(6*Trms*10^(-9))
N=ceil(50*10^6/Bc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Quation 3
Ts=20;
r8bits = randi([0 1],1,8)

dn=zeros(8,6);

for i=1:8
    if r8bits(:,i)==0
        dn(i,:)=[1 1 1 1 1 1];
    else
        dn(i,:)=[-1 -1 -1 -1 -1 -1];
    end
end

dn=reshape(dn',48,1);
n=0:1:47;

figure(3);
stem(n,dn,'filled');
title(['3-(a) Transmitter output signal']);
axis([0,50,-1.5,1.5]);
axis normal;
xticks(0:6:48);
xlabel('n');
ylabel('Amplifier(V)');

figure(4);

zn=zeros(48,1);
for m=0:47
    for i=1:5
        tmp=m-D(:,i)/Ts;
        if tmp<0
            zn(m+1,:)=zn(m+1,:)+0;
        elseif tmp>47
            zn(m+1,:)=zn(m+1,:)+0;
        else
            zn(m+1,:)=zn(m+1,:)+h(:,i)*dn(tmp+1,:);
        end
    end
end

subplot(2,1,1);
stem(n,real(zn),'filled');
title(['Real signals of Z_n']);
axis([0,50,-1,1]);
axis normal;
xticks(0:6:48);
xlabel('n');
ylabel('Real(Z_n)');

subplot(2,1,2);
stem(n,imag(zn),'filled');
title(['Image signals of Z_n']);
axis([0,50,-2,2]);
axis normal;
xticks(0:6:48);
xlabel('n');
ylabel('Imag(Z_n)');

sgtitle('3-(b) Signal Z_n');