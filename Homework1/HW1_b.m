clear;
close all;
rng(19);
r = randi([0 1],1,8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(b)
figure(1);     
A=1;            %振幅
Ts=100*10^-9;   %sampling interval
N=8;            %amounts of subcarrier

fsub=1/(N*Ts);
Xk=zeros(8,1);

for i=1:8
    if r(i)==1
        Xk(i,:)=1;
    else
        Xk(i,:)=-1;
    end
end

t=0:Ts/10000:8*Ts;
Xk_wave=pulstran(t-Ts/2,Xk,'rectpuls',Ts);

%subcarrier=exp(j*2*pi*k*fsub*t);

x_subcarrier=zeros(8,length(t));

for k=0:7
    x_subcarrier(k+1,:)=Xk(k+1)*exp(j*2*pi*k*fsub*t);
end

for i=1:8
    subplot(4,2,i);
    plot(t,real(x_subcarrier(i,:)));
    title(['Subcarrier ',num2str(i),' waveform']);
    axis([0,N*Ts,-2,2]);
    axis normal;
    xlabel('time(s)');
    ylabel('Amplifier(V)');
end
sgtitle('3-(b) Real part of the signals at eight subcarriers');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(c)
figure(2)
y=zeros(1,length(t));

for i=1:8
    y(1,:)=y(1,:)+x_subcarrier(i,:);
end

subplot(2,1,1);
plot(t,real(y));
title(['Real part waveform of 8 subcarriers']);
axis([0,N*Ts,-5,5]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

subplot(2,1,2);
plot(t,imag(y));
title(['Image part waveform of 8 subcarriers']);
axis([0,N*Ts,-5,5]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

sgtitle('3-(c) Sum of eight subcarriers');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(d)
figure(3);

y_ifft=8*ifft(Xk',8);

nTs=0:Ts:7*Ts;
xn_subcarrier=zeros(8,length(nTs));
for k=0:7
    xn_subcarrier(k+1,:)=Xk(k+1)*exp(j*2*pi*k*fsub*(nTs));
end
y_discrete=zeros(1,length(nTs));
for i=1:8
    y_discrete(1,:)=y_discrete(1,:)+xn_subcarrier(i,:);
end

subplot(2,1,1);
stem(nTs,real(y_ifft),'filled');
title(['Real part waveform of 8 subcarriers']);
axis([0,N*Ts,-5,5]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

subplot(2,1,2);
stem(nTs,imag(y_ifft),'filled');
title(['Image part waveform of 8 subcarriers']);
axis([0,N*Ts,-5,5]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

sgtitle('3-(d) Discrete real part and image part');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-(e)
figure(4);

y_scale=y/8;

nTs=0:Ts:8*Ts;
x_stem=zeros(8,length(nTs));
for k=0:7
    x_stem(k+1,:)=Xk(k+1)*exp(j*2*pi*k*fsub*(nTs))/8;
end
y_stem=zeros(1,length(nTs));
for i=1:8
    y_stem(1,:)=y_stem(1,:)+x_stem(i,:);
end

subplot(2,1,1);
plot(t,real(y_scale));
hold on;
stem(nTs,real(y_stem),'filled');
title(['Real part waveform of 8 subcarriers']);
axis([0,N*Ts,-5/8,5/8]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

subplot(2,1,2);
plot(t,imag(y_scale));
hold on;
stem(nTs,imag(y_stem),'filled');
title(['Image part waveform of 8 subcarriers']);
axis([0,N*Ts,-5/8,5/8]);
axis normal;
xlabel('time(s)');
ylabel('Amplifier(V)');

sgtitle('3-(e) Scaling curve');
