clear;
close all;
load("HW5-3.mat");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-a
map=zeros(16,5);
i=1;
for n1=0:1
    for n2=0:1
        for n3=0:1
            for n4=0:1
                xbar=[power(-1,n1),power(-1,n2),power(-1,n3),power(-1,n4)]';
                tmp=y-Hmatrix*xbar;
                Cost=tmp(1,:)^2+tmp(2,:)^2+tmp(3,:)^2+tmp(4,:)^2;
                map(i,:)=[xbar',Cost];
                i=i+1;
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-b
[Q,R]=qr(Hmatrix);
Q
R
z=Q'*y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Question 3-c
best6=zeros(6,4);
best6(1,:)=[0 0 0 1];
best6(2,:)=[0 0 0 -1];

PED6=zeros(6,1);
PED6(1,:)=Compute_T(z,R,best6(1,:),4);
PED6(2,:)=Compute_T(z,R,best6(2,:),4);

Search_node=[];
for i=1:6
    if abs(best6(i,4))==1
        a=[best6(i,:) PED6(i,:)];
        Search_node=[Search_node;a];
    end
end

for k=1:3
    Serial_tmp=zeros(12,4);
    T_tmp=inf(12,1);
    i=4-k;
    for j=1:6
        if abs(best6(j,4))==1
            Serial_tmp(2*j-1,:)=best6(j,:);
            Serial_tmp(2*j,:)=best6(j,:);
            Serial_tmp(2*j-1,i)=1;
            Serial_tmp(2*j,i)=-1;

            T_tmp(2*j-1,:)=PED6(j,:)+Compute_T(z,R,Serial_tmp(2*j-1,:),i);
            T_tmp(2*j,:)=PED6(j,:)+Compute_T(z,R,Serial_tmp(2*j,:),i);
        end
    end

    merge=[Serial_tmp T_tmp];
    merge=sortrows(merge,5);
    

    best6=merge(1:6,1:4);
    PED6=merge(1:6,5);

    for i=1:6
        if abs(best6(i,4))==1
            a=[best6(i,:) PED6(i,:)];
            Search_node=[Search_node;a];
        end
    end
end

best=best6(1,:)
ED=PED6(1,:)

function T=Compute_T(z,r,x,i)
    T=abs(z(i,:)-r(i,:)*x')^2;
end