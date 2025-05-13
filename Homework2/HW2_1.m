clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-(b)
figure(1);
N=29;
u1=9;
n1=0:1:N-1;

S1=S(n1,u1);

subplot(2,1,1);
stem(n1,real(S1),'filled');
title('Real part');
axis([0,30,-2,2]);
axis normal;
xlabel('n');
ylabel('Re(S(n,u_1))');

subplot(2,1,2);
stem(n1,imag(S1),'filled');
title('Image part');
axis([0,30,-2,2]);
axis normal;
xlabel('n');
ylabel('Im(S(n,u_1))');

sgtitle('1-(b) Sequence of S(n,u_1)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-(c)
figure(2);

k=-N:1:N;
syms n
PHI=symsum(S(n,u1).*conj(S(n-k,u1)),n,0,N-1)/N;

stem(k,abs(PHI),'filled');
title('1-(c) Autocorrelation proterty |\phi_s(k)|');
axis([-30,30,0,1]);
axis normal;
xlabel('k');
ylabel('Auto-correlation |\phi_s(k)|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-(d)
figure(3);

m=-N:1:N;
k=3;
syms n
OMEGA1=symsum(S(n,u1).*conj(S(n-k,u1+m)),n,0,N-1)/N;

stem(m,abs(OMEGA1),'filled');
title('1-(d) Cross-correlation proterty |\Omega_s(m)|');
axis([-30,30,0,0.5]);
axis normal;
xlabel('m');
ylabel('Cross-correlation |\Omega_s(m)|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-(e)
figure(4);

m=3;
k=-N:1:N;
syms n
OMEGA2=symsum(S(n,u1).*conj(S(n-k,u1+m)),n,0,N-1)/N;

stem(k,abs(OMEGA2),'filled');
title('1-(e) Cross-correlation proterty |\Omega_s(k)|');
axis([-30,30,0,0.5]);
axis normal;
xlabel('k');
ylabel('Cross-correlation |\Omega_s(k)|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-(f)
figure(5);

m=1:1:N;
syms n
pm=symsum(y(n+m,u1).*conj(S(n,u1)),n,0,N-1);

pm0=zeros(N,1);
for i=1:N
    for n=0:N-1
        pm0(i,:)=pm0(i,:)+y0(i+n,u1)*conj(S(n,u1));
    end
end
%pm0=symsum(y0(w+m,u1).*conj(S(w,u1)),w,0,N-1);

subplot(2,1,1)
stem(m,abs(pm),'filled');
title('|p(m)| if y(n) will loop');
axis([0,30,0,10]);
axis normal;
xlabel('m');
ylabel('|p(m)|');

subplot(2,1,2)
stem(m,abs(pm0),'filled');
title('|p(m)| if n>33, y(n)=0');
axis([0,30,0,10]);
axis normal;
xlabel('m');
ylabel('|p(m)|');

sgtitle('1-(f) |p(m)|');

function y1=y(n,u)
    N=29;
    
    if n==0
        w=N-2;
    elseif n==1
        w=N-1;
    else
        w=mod(n-2,N);
    end
    
    y1=0.3*S(w,u);
end

function y2=y0(n,u)
    N=29;
    
    if n==0
        w=N-2;
    elseif n==1
        w=N-1;
    else
        w=mod(n-2,N);
    end
    
    if n>33
        y2=0;
    else
        y2=0.3*S(w,u);
    end
end

function s=S(n,u)
    N=29;
    s=exp(j*pi*u*n.*(n+1)/N);
end