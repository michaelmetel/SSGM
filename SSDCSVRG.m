function output=SSDCSVRG(n,d,ka,e,fn)

load(fn(1,:))%X
load(fn(2,:))%y
Ngc=e*n;
L=(2+0.25)*max(sum(X.^2,2));%Xu et al pg 15
eta=0.05/L;%Xu et al pg 16

T=2*n;%As recommended in Xiao & Zhang 2014
gam=200*L/T;%T=ceil(max(2,200*L/gam)) Xu et al pg 16, 
R=0;%actual number of gradient calls used, which is close to and >= N
k=0;
while R<Ngc
    k=k+1;
    R=R+ceil(log2(k))*(n+T);    
end  
K=k;

mu=1/(K^(0.25));%K=O(1/eps^4) Xu et al pg 20
NI=T*sum(ceil(log2(1:K))); %number of iterations
w=zeros(d,NI+1);    
gca=n/T;
TT=zeros(1,NI+1);
rng(0,'twister');%set seed for reproducibility and fair testing
tic
wbar=w(:,1);
for k=1:K %Algorithm 1 loop
Sk=ceil(log2(k));%Xu et al page 16    
Sks=sum(ceil(log2(1:k-1)));
w1=wbar;
[~,p]=MEsubp(w1,ka,mu);
subh=0.25*(y.*X)'*(y.*X*w1)/n+p/mu;
for s=1:Sk
arg=y.*X*wbar;
gbargrad=(y.*X.*((2*(arg<=1).*(arg-1)./(1+(arg-1).^2))+0.25*(arg)))';
gbar=sum(gbargrad,2)/n-subh;
for t=1:T
wkt=w(:,t+T*(Sks+s-1));
I=randi(n,1);
arg=y(I).*X(I,:)*wkt;
Del=(y(I).*X(I,:))'*(2*(arg<=1).*(arg-1)./(1+(arg-1).^2)+0.25*arg)-gbargrad(:,I)+gbar;
w(:,t+1+T*(Sks+s-1))=(gam*w1+wkt/eta-Del)/(1/mu+gam+1/eta);
TT(t+1+T*(Sks+s-1))=toc;
end
wbar=sum(w(:,2+T*(Sks+s-1):T+1+T*(Sks+s-1)),2)/T;
w(:,T+1+T*(Sks+s-1))=wbar;
TT(T+1+T*(Sks+s-1))=toc;
end
end

output=[w;TT];
