clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 1
s=[1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 1 -1 1];

k=-26:1:26;
Phi=zeros(length(k),1);
for m=-26:26
    k1=m+26;
    for n=0:15
        if n+m>15
            s2=0;
        elseif n+m<0
            s2=0;
        else
            s2=s(:,n+m+1);
        end
        Phi(k1+1,:)=s(:,n+1)*s(:,mod(n+m,16)+1)/16+Phi(k1+1,:);
    end
end

stem(k,Phi,'filled');
title('Question1 \Phi(k)');
axis([-30,30,-0.6,1.2]);
axis normal;
xlabel('k');
ylabel('\Phi(k)');