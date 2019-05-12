function h=h(w,ka,fn)
%objective value (1)

bs=50000;%block size for output with large number of iterations

load(fn(1,:))%X
load(fn(2,:))%y

n=size(X,1);
it=size(w,2);

if it<=bs

arg=y.*X*w;
f=sum((arg<=1).*log(1+(arg-1).^2))/n;
g=ka*sum(log(1+abs(w)));
h=(f+g)';

else

h=zeros(it,1);    
prt=floor(size(w,2)/bs);

for i=1:prt
wp=w(:,bs*(i-1)+1:bs*i);
arg=y.*X*wp;
f=sum((arg<=1).*log(1+(arg-1).^2))/n;
g=ka*sum(log(1+abs(wp)));
h(bs*(i-1)+1:bs*i)=(f+g)';
end

wp=w(:,bs*prt+1:end);
arg=y.*X*wp;
f=sum((arg<=1).*log(1+(arg-1).^2))/n;
g=ka*sum(log(1+abs(wp)));
h(bs*prt+1:end)=(f+g)';
end
    
    

    
    
