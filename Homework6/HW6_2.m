clear;
close all;
load("HW6-2.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-b
%%58+R ~ 84
%%j=58+6~84
%%si  i=5~20
%%h0  j=64~79
%%h1  j=65~80


N=16;
s=[1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 1 -1 1];

k=1:1:110;
qm=zeros(length(k),1);
for m=1:length(k)
    for n=5:N+4
        qm(m,:)=GSMRx(:,n+m-5)*s(:,mod(n,16)+1)/(N)+qm(m,:);
    end
end

stem(k,abs(qm),'filled');
title('2-(b) Channel estimation by correlator');
axis([60,70,0,1.2]);
axis normal;
xlabel('m');
ylabel('q_m');