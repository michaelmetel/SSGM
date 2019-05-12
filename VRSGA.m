function output=VRSGA(n,d,ka,e,fn)

%Algorithm 2: Stochastic variance reduced gradient algorithm

load(fn(1,:))%X
load(fn(2,:))%y
Ngc=e*n;

m=ceil(n^(1/3));
b=m^2;
N=ceil(Ngc/(n/m+b));
S=ceil(N/m);
w=zeros(d,1+S*m);
lambda=(S*m)^(-1/3);

%%%Calculate smoothness parameters
Lr=2*max(sum(X.^2,2));
LEr=Lr+1/lambda;
gam=1/(6*LEr);

TT=zeros(1,S*m+1);
rng(0,'twister');%set seed for reproducibility and fair testing
tic
for k=1:S
    arg=y.*X*w(:,1+m*(k-1));
    Gd=(y.*X.*(2*(arg<=1).*(arg-1)./(1+(arg-1).^2)))';%Gradient decomposed
    G=sum(Gd,2)/n;
    for t=1:m
        I=randi(n,[b,1]);
        arg=y(I).*X(I,:)*w(:,t+m*(k-1));
        vrg=(y(I).*X(I,:))'*(2*(arg<=1).*(arg-1)./(1+(arg-1).^2))/b-sum(Gd(:,I),2)/b+MEsubp(w(:,t+m*(k-1)),ka,lambda)+G;
        w(:,t+1+m*(k-1))=w(:,t+m*(k-1))-gam*vrg;
        TT(t+1+m*(k-1))=toc;
    end
end

output=[w;TT];


