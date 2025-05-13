clear;
close all;
load("HW4.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-a
figure(1)
m=1:1:640;
R=32;
L=128;

PhiDC=zeros(length(m),1);
for n=1:640;
    tmp=0;
    for r=0:R-1
        if n-r<1
            z1=0;
        else
            z1=OFDMTx(:,n-r);
        end
    
        if n-r-L<1
            z2=0;
        else
            z2=OFDMTx(:,n-r-L);
        end
        tmp=tmp+z1*conj(z2);
    
    end
    PhiDC(n,:)=abs(tmp);
end


stem(m,PhiDC,'filled');
title('3-(a) \Phi_D_C(m)');
axis([0,640,0,2.5]);
axis normal;
xlabel('m');
ylabel('\Phi_D_C(m)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-c
figure(2)

R=96;
L=32;

PhiDC2=zeros(length(m),1);
for n=1:640;
    tmp=0;
    for r=0:R-1
        if n-r<1
            z1=0;
        else
            z1=OFDMTx(:,n-r);
        end
    
        if n-r-L<1
            z2=0;
        else
            z2=OFDMTx(:,n-r-L);
        end
        tmp=tmp+z1*conj(z2);
    
    end
    PhiDC2(n,:)=abs(tmp);
end


stem(m,PhiDC2,'filled');
title('3-(c) \Phi_D_C(m)');
axis([0,640,0,6.5]);
axis normal;
xlabel('m');
ylabel('\Phi_D_C(m)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 2-g
figure(3)

OFDMTxNEW=OFDMTx(161:640);

m=1:1:480;
R=32;
L=128;

PhiDC3=zeros(length(m),1);
for n=1:480;
    tmp=0;
    for r=0:R-1
        if n-r<1
            z1=0;
        else
            z1=OFDMTxNEW(:,n-r);
        end
    
        if n-r-L<1
            z2=0;
        else
            z2=OFDMTxNEW(:,n-r-L);
        end
        tmp=tmp+z1*conj(z2);
    
    end
    PhiDC3(n,:)=abs(tmp);
end

PhiNM=zeros(length(m),1);
for n=1:480;
    tmp=0;
    tmp1=0;
    for r=0:R-1
        if n-r<1
            z1=0;
        else
            z1=OFDMTxNEW(:,n-r);
        end
    
        if n-r-L<1
            z2=0;
        else
            z2=OFDMTxNEW(:,n-r-L);
        end
        tmp=tmp+z1*conj(z2);
        tmp1=tmp1+abs(z1)*abs(z1);
    end
    PhiNM(n,:)=abs(tmp)*abs(tmp)/abs(tmp1)/abs(tmp1);
end

subplot(2,1,1);
stem(m,PhiNM,'filled');
title('\Phi_N_M(m)');
axis([0,480,0,1.5]);
axis normal;
xlabel('m');
ylabel('\Phi_N_M(m)');

subplot(2,1,2);
stem(m,PhiDC3,'filled');
title('\Phi_D_C(m)');
axis([0,480,0,0.5]);
axis normal;
xlabel('m');
ylabel('\Phi_D_C(m)');

sgtitle('3-(g) \Phi_N_M(m) & \Phi_D_C(m)');