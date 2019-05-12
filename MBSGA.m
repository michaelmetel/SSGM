function output=MBSGA(n,d,ka,e,fn)
%Algorithm 1: Mini-batch stochastic gradient algorithm

alpha=0.25;
theta=0.25;
Ngc=e*n;
load(fn(1,:))%X
load(fn(2,:))%y

N=ceil(Ngc^(1/(1+alpha))+1);
M=ceil(N^alpha);
gc=((0:N-1)*M/n)';%Number of gradient calls/n to calculate each iteration.
[N,~]=find(gc>=e,1,'first');
N=max(N,ceil((M-1+1E-6)^(1/alpha)));
M=ceil(N^alpha);
w=zeros(d,N);
lambda=N^(-theta);
TT=zeros(1,N);
%%%Calculate smoothness parameters
L=2*sum(sum(X.^2))/n;
LE=L+1/lambda;

Nsig=50;
rng(1,'twister');%Use different random variables to estimate variance
sigma=MBSGASigEst(n,d,ka,M,lambda,LE,Nsig,fn);%Estimate sigma parameter
gam=min(1/LE,1/(sigma*sqrt(N)));

rng(0,'twister');%set seed for reproducibility and fair testing
tic
for k=1:N-1
    I=randi(n,[M,1]);
    arg=y(I).*X(I,:)*w(:,k);
    A=(y(I).*X(I,:))'*(2*(arg<=1).*(arg-1)./(1+(arg-1).^2))/M+MEsubp(w(:,k),ka,lambda);    
    w(:,k+1)=w(:,k)-gam*A;
    TT(k+1)=toc;
end

output=[w;TT];




