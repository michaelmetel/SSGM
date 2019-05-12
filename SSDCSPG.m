function output=SSDCSPG(n,d,ka,e,fn)

load(fn(1,:))%X
load(fn(2,:))%y
Ngc=e*n;
K=ceil(-0.5+sqrt(1+2*Ngc)/2);
R=2*K*(K+1);%This is the actual number of iterations used, which is close to and >= Ngc.
w=zeros(d,1+R);
mu=1/(K^(0.25));%K=O(1/eps^4) Xu et al pg 20
L=(2+0.25)*sum(sum(X.^2))/n; %Xu et al pg 12
gam=3*L;%Xu et al pg 13
TT=zeros(1,R+1);
rng(0,'twister');%set seed for reproducibility and fair testing
tic
for k=1:K %Algorithm 1 loop
Tk=4*k;%Xu et al pg 14
w1=w(:,1+4*sum(1:k-1));
arg=y.*X*w1;
[~,p]=MEsubp(w1,ka,mu);
for t=1:Tk
    eta=1/(L*(t+1));%Xu et al pg 13
    wkt=w(:,t+4*sum(1:k-1));
    I=randi(n,1);
    subh=0.25*(y(I).*X(I,:))'*arg(I)+p/mu;
    I2=randi(n,1);
    arg2=y(I2).*X(I2,:)*wkt;
    subg=(y(I2).*X(I2,:))'*(2*(arg2<=1).*(arg2-1)./(1+(arg2-1).^2)+0.25*arg2);%subderivative of g using notation of Xu et al
    w(:,t+1+4*sum(1:k-1))=(gam*w1+wkt/eta-subg+subh)/(1/mu+gam+1/eta);
    TT(t+1+4*sum(1:k-1))=toc;
end
w(:,Tk+1+4*sum(1:k-1))=w(:,2+4*sum(1:k-1):Tk+1+4*sum(1:k-1))*(2:Tk+1)'/sum(2:Tk+1);
TT(Tk+1+4*sum(1:k-1))=toc;
end

output=[w;TT];









