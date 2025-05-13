clear;
close all;
rng(19);
r = randi([0 1],1,8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-(a)
figure(1);      %2-a
A=1;            %振幅
fc=10*10^6;     %carrier frequency
f1=15*10^6;     %fc of bit 1
f0=5*10^6;      %fc of bit 0

T=400*10^-9;    %symbol time

Ts=0:T/10000:T; %symbol time
t=zeros(8,length(Ts));

for i=1:8
    t(i,:)=Ts+(i-1)*T;
end    

ya=zeros(8,length(Ts)); %store modulated wave

for i=1:8   %modulating r
    ya(i,:)=r(i)*sin(2*pi*f1*t(i,:))+~r(i)*sin(2*pi*f0*t(i,:));
end

t=reshape(t',length(Ts)*8,1);
ya=reshape(ya',length(Ts)*8,1);

plot(t,ya);
title('2-(a) FSK waveform');
axis([0,8*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-(b)
figure(2);
A=1;          %振幅
fc=10*10^6;     %carrier frequency

T=400*10^-9;    %symbol time
I=zeros(4,2);   
Q=zeros(4,2);

for i=1:4
    if r([2*i-1 2*i])==[0 0]            %signal 00
        I(i,:)=[T*(i-1) 1/sqrt(2)];
        Q(i,:)=[T*(i-1) -1/sqrt(2)];
    elseif r([2*i-1 2*i])==[0 1]        %signal 01
        I(i,:)=[T*(i-1) 1/sqrt(2)];
        Q(i,:)=[T*(i-1) 1/sqrt(2)];
    elseif r([2*i-1 2*i])==[1 0]        %signal 10
        I(i,:)=[T*(i-1) -1/sqrt(2)];
        Q(i,:)=[T*(i-1) -1/sqrt(2)];
    elseif r([2*i-1 2*i])==[1 1]        %signal 11
        I(i,:)=[T*(i-1) -1/sqrt(2)];
        Q(i,:)=[T*(i-1) 1/sqrt(2)];
    end
    
end
t=0:T/10000:4*T;
I_wave=pulstran(t-T/2,I,'rectpuls',T);
Q_wave=pulstran(t-T/2,Q,'rectpuls',T);

I_carrier=cos(2*pi*fc*t);
Q_carrier=sin(2*pi*fc*t);

yb=I_wave.*I_carrier-Q_wave.*Q_carrier;
plot(t,yb);
title('2-(b) QPSK waveform');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-(c)
figure(3);
A=1;          %振幅
fc=10*10^6;     %carrier frequency
p=0;            %phase

T=400*10^-9;    %symbol time
I=zeros(4,2);
Q=zeros(4,2);

WhiteBlack=1;   %bit 1 is white, bit 0 is black

for i=1:4
    if WhiteBlack==0
        if r([2*i-1 2*i])==[0 0]        %signal 00       
            I(i,:)=[T*(i-1) 1/sqrt(2)];
            Q(i,:)=[T*(i-1) -1/sqrt(2)];
        elseif r([2*i-1 2*i])==[0 1]    %signal 01
            I(i,:)=[T*(i-1) 1/sqrt(2)];
            Q(i,:)=[T*(i-1) 1/sqrt(2)];
        elseif r([2*i-1 2*i])==[1 0]    %signal 10
            I(i,:)=[T*(i-1) -1/sqrt(2)];
            Q(i,:)=[T*(i-1) -1/sqrt(2)];
        elseif r([2*i-1 2*i])==[1 1]    %signal 11
            I(i,:)=[T*(i-1) -1/sqrt(2)];
            Q(i,:)=[T*(i-1) 1/sqrt(2)];
        end
        WhiteBlack=1;
    else
        if r([2*i-1 2*i])==[0 0]        %signal 00
            I(i,:)=[T*(i-1) 1];
            Q(i,:)=[T*(i-1) 0];
        elseif r([2*i-1 2*i])==[0 1]    %signal 01
            I(i,:)=[T*(i-1) 0];
            Q(i,:)=[T*(i-1) 1];
        elseif r([2*i-1 2*i])==[1 0]    %signal 10
            I(i,:)=[T*(i-1) 0];
            Q(i,:)=[T*(i-1) -1];
        elseif r([2*i-1 2*i])==[1 1]    %signal 11
            I(i,:)=[T*(i-1) -1];
            Q(i,:)=[T*(i-1) 0];
        end
        WhiteBlack=0;
    end
    
end
t=0:T/10000:4*T;
I_wave=pulstran(t-T/2,I,'rectpuls',T);
Q_wave=pulstran(t-T/2,Q,'rectpuls',T);

I_carrier=cos(2*pi*fc*t);
Q_carrier=sin(2*pi*fc*t);

yb=I_wave.*I_carrier-Q_wave.*Q_carrier; %after modulation
plot(t,yb);
title('2-(c) \pi/4-QPSK waveform');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-(d-1)
figure(4);
A=1;          %振幅
fc=10*10^6;     %carrier frequency

T=400*10^-9;    %symbol time
I=zeros(4,2);
Q=zeros(5,2);
Q(1,:)=[-T/2 1/sqrt(2)];    %because of OQPSK

for i=1:4
    if r([2*i-1 2*i])==[0 0]
        I(i,:)=[T*(i-1) 1/sqrt(2)];
        Q(i+1,:)=[T*(i-1)+T/2 -1/sqrt(2)];
    elseif r([2*i-1 2*i])==[0 1]
        I(i,:)=[T*(i-1) 1/sqrt(2)];
        Q(i+1,:)=[T*(i-1)+T/2 1/sqrt(2)];
    elseif r([2*i-1 2*i])==[1 0]
        I(i,:)=[T*(i-1) -1/sqrt(2)];
        Q(i+1,:)=[T*(i-1)+T/2 -1/sqrt(2)];
    elseif r([2*i-1 2*i])==[1 1]
        I(i,:)=[T*(i-1) -1/sqrt(2)];
        Q(i+1,:)=[T*(i-1)+T/2 1/sqrt(2)];
    end
    
end
t=0:T/10000:4*T;
I_wave=pulstran(t-T/2,I,'rectpuls',T);
Q_wave=pulstran(t-T/2,Q,'rectpuls',T);

I_carrier=cos(2*pi*fc*t);
Q_carrier=sin(2*pi*fc*t);

yb=I_wave.*I_carrier-Q_wave.*Q_carrier;     %after modulation

subplot(3,1,1);plot(t,I_wave);
title('OQPSK baseband I');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

subplot(3,1,2);plot(t,Q_wave);
title('OQPSK baseband Q');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

subplot(3,1,3);plot(t,yb);
title('OQPSK waveform');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

sgtitle('2-(d) OQPSK waveform');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-(d-2)
figure(5);
A=1;          %振幅
fc=10*10^6;     %carrier frequency

T=400*10^-9;    %symbol time
I=zeros(4,2);
Q=zeros(4,2);
p=pi/4;         %initail phase

for i=1:4
    if r([2*i-1 2*i])==[0 0]
        p=p+pi/4;
    elseif r([2*i-1 2*i])==[0 1]
        p=p-pi/4;
    elseif r([2*i-1 2*i])==[1 0]
        p=p-3*pi/4;
    elseif r([2*i-1 2*i])==[1 1]
        p=p+3*pi/4;
    end
    I(i,:)=[T*(i-1) real(exp(j*p))];
    Q(i,:)=[T*(i-1) imag(exp(j*p))];    
end
t=0:T/10000:4*T;
I_wave=pulstran(t-T/2,I,'rectpuls',T);
Q_wave=pulstran(t-T/2,Q,'rectpuls',T);

I_carrier=cos(2*pi*fc*t);
Q_carrier=sin(2*pi*fc*t);

yb=I_wave.*I_carrier-Q_wave.*Q_carrier;

subplot(3,1,1);plot(t,I_wave);
title('\pi/4-QPSK baseband I');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

subplot(3,1,2);plot(t,Q_wave);
title('\pi/4-QPSK baseband Q');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

subplot(3,1,3);plot(t,yb);
title('\pi/4-QPSK waveform');
axis([0,4*400*10^-9,-2,2]);
axis normal;
xlabel('time(s)');
ylabel('Amplitude(V)');

sgtitle('2-(d) \pi/4-QPSK waveform');

hold on;