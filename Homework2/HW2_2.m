clear;
close all;

figure(1);
N=7;
k=-N:1:N;

PHI1=zeros(15,1);
for i=-N:N
    for n=0:N-1
        PHI1(i+8,:)=PHI1(i+8,:)+S7(n)*S7(mod(n-i,N));
    end
    PHI1(i+8,:)=PHI1(i+8,:)/N;
end

subplot(3,1,1);
stem(k,PHI1,'filled');
title('N=7');
axis([-10,10,-0.5,1]);
axis normal;
xlabel('k');
ylabel('Auto-correlation');

N=11;
k=-N:1:N;

PHI2=zeros(2*N+1,1);
for i=-N:N
    for n=0:N-1
        PHI2(i+12,:)=PHI2(i+12,:)+S11(n)*S11(mod(n-i,N));
    end
    PHI2(i+12,:)=PHI2(i+12,:)/N;
end


subplot(3,1,2);
stem(k,PHI2,'filled');
title('N=11');
axis([-15,15,-0.5,1]);
axis normal;
xlabel('k');
ylabel('Auto-correlation');

sgtitle('2 Barker code');
hold on;

N=13;
k=-N:1:N;

PHI3=zeros(2*N+1,1);
for i=-N:N
    for n=0:N-1
        PHI3(i+14,:)=PHI3(i+14,:)+S13(n)*S13(mod(n-i,N));
    end
    PHI3(i+14,:)=PHI3(i+14,:)/N;
end

subplot(3,1,3);
stem(k,PHI3,'filled');
title('N=13');
axis([-15,15,-0.5,1]);
axis normal;
xlabel('k');
ylabel('Auto-correlation');

sgtitle('2. Barker code');
hold on;


function s=S7(n)
    switch n
        case{0,1,2,5}
            s=-1;
        case{3,4,6}
            s=1;
    end
end

function s=S11(n)
    switch n
        case{0,1,2,6,9}
            s=-1;
        otherwise
            s=1;
    end
end

function s=S13(n)
    switch n
        case{5,6,9,11}
            s=1;
        otherwise
            s=-1;
    end
end