function [tout,lh]=reduceLength(t,h,MaxL)

L=length(h);

if L>2*MaxL
I=floor(L/MaxL);
LI=floor(L/I);
tout=zeros(LI+1,1);
lh=zeros(LI+1,1);
lh(1)=log(h(1));
for j=1:LI-1
    tout(j+1)=mean(t(2+I*(j-1):1+I*j));
    lh(j+1)=mean(log(h(2+I*(j-1):1+I*j)));    
end
tout(LI+1)=mean(t(2+I*(LI-1):end));
lh(LI+1)=mean(log(h(2+I*(LI-1):end))); 

else
tout=t;
lh=log(h);
end
