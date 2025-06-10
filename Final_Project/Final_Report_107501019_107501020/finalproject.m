clear; 
close all;
load FinalProject2.mat;
load test_pattern.mat;

x_solution=dfs(Hmatrix,y);
rng(20);
i=sqrt(-1);
s=1000;

max_db = 10;

for k=1:max_db
    E(k)=2*(10^(-(k-5)/10));
end
n=sqrt(E);

for k=1:max_db
    y_noise=Hmatrix*x_test;
    r=n(k);
    for m=1:s*4
        theta=rand()*2*pi;
        noise=r*(cos(theta)+i*sin(theta));
        y_noise(m)=y_noise(m)+noise;
    end
    
    xml_test=[];
    for m=1:s
        xml_test=[xml_test dfs(Hmatrix,y_noise(:,m))];
    end
    ber(k)=get_BER(x_test,xml_test);
end

figure();
plot([-4:1:max_db-5],ber);
set(gca, 'YScale', 'log');
xlim([-5,max_db-5]);
ylim([0,0.5]);
xlabel('SNR (dB)');
ylabel('BER ');
set(gca,'XTick',[-5:1:5]);
title('bit-error-rate (BER) v.s. signal-to-noise ratio (SNR)');

function ber=get_BER(h1,h2)
%¿é¤J¨â¯x°} ±obit error rate 
%QPSK (1+i,-1+i,-1-i,1-i)=(11,01,00,10)
s1=size(h1);
s2=size(h2);

    if s1(1)~=s2(1) || s1(2)~=s2(2)
        ber=99;
    else
        all_bit=s1(1)*s1(2)*2;
        total_error=0;
        for k=1:s1(1)*s1(2)
            e1=h1(k);
            e2=h2(k);
            if e1~=e2
                if abs(angle(e1/e2))>0.75*pi %
                    total_error=total_error+2;
                else
                    total_error=total_error+1;
                end
            end
        end
        
        ber=total_error/all_bit;
    end
end

function x=dfs(Hm,y)
data=zeros(1,340);
cost=zeros(1,340);
i=sqrt(-1);
limit=Inf;
[Q,R] = qr(Hm);
st=-1; %stack
yc=Q'*y;
    for k=1:340
        data(k)=get_data(k);
    end

cost(1)=tree(yc,R(4,:),[0 ;0; 0 ;1+i],4);
cost(2)=tree(yc,R(4,:),[0; 0; 0; 1-i],4);%%%%layer 4
cost(3)=tree(yc,R(4,:),[0; 0; 0; -1+i],4);
cost(4)=tree(yc,R(4,:),[0; 0; 0 ;-1-i],4);

st=pushStack(st,4);
st=pushStack(st,3);
st=pushStack(st,2);
st=pushStack(st,1);

while(length(st)>1)
    [st,now]=popStack(st);
    layer=getLayer(now);
    xb=get_xbar(now);
    fath=father(now);
    T=tree(yc,R(layer,:),xb,layer);
   
    if fath>0
        cost(now)=cost(fath)+T;
    end
    if(now<=84)%not leaf
        if limit>cost(now) %PED ok
            st=pushStack(st,4*now+4);
            st=pushStack(st,4*now+3);
            st=pushStack(st,4*now+2);
            st=pushStack(st,4*now+1);
        end
    else%leaf
        if limit>cost(now) %PED ok
            limit=cost(now);
            ans_node=now;
        end
    end

end
x=get_xbar(ans_node);

end

function xbar=get_xbar(k)
    if k<=4
        xbar=[0 ;0; 0 ;get_data(k)];
    elseif k<=16+4
        xbar=[0 ;0; get_data(k); get_data(father(k))];
    elseif k<=64+16+4
        gf=father(father(k));%grand father
        xbar=[0; get_data(k) ;get_data(father(k)); get_data(gf)];
    else
        gf=father(father(k));%grand father
        ggf=father(gf);%grand grand father
        xbar=[get_data(k) ;get_data(father(k)); get_data(gf); get_data(ggf)];
    end
end

function dt=get_data(k)
        i=sqrt(-1);
        if mod(k,4)==1 
            dt=1+i;
        elseif mod(k,4)==2
            dt=1-i;
        elseif mod(k,4)==3
            dt=-1+i;
        else% mod(k,4)==0
            dt=-1-i;
        end
end

function fi=father(k)
    if mod(k,4)==1 
        fi=(k-1)/4;
    elseif mod(k,4)==2
        fi=(k-2)/4;
    elseif mod(k,4)==3
        fi=(k-3)/4;
    else % mod(k,4)==0
        fi=(k-4)/4;
    end
end

function la=getLayer(k)
    if k<=4
        la=4;
    elseif k<=20
        la=3;
    elseif k<=4+16+64
        la=2;
    else 
        la=1;
    end
end

function po=tree(yc,rr,xx,ii)
sum=0;
for j=ii:4
    sum=sum+rr(j)*xx(j);
end
po=abs(yc(ii)-sum)^2;
end

function newStack = pushStack(a,newValue)
    newStack = [newValue,a];
end

function [newStack,popedValue] = popStack(a)
    popedValue = a(1);
    newStack = a(2:end);
end