function sigma=MBSGASigEst(n,d,ka,M,lambda,LE,N,fn)

%Algorithm 1: Mini-batch stochastic gradient algorithm sigma estimation

load(fn(1,:))%X
load(fn(2,:))%y

w=zeros(d,N);

gam=1/LE;
sigsq=zeros(N,1);

for k=1:N
    I=randi(n,[M,1]);
    arg2=y(I).*X(I,:)*w(:,k);
    grad=(y(I).*X(I,:).*(2*(arg2<=1).*(arg2-1)./(1+(arg2-1).^2)))';
    A=sum(grad,2)/M+MEsubp(w(:,k),ka,lambda);
    w(:,k+1)=w(:,k)-gam*A;      
    %compute sample variance 
    arg2=y.*X*w(:,k);
    fullgrad=(y.*X)'*(2*(arg2<=1).*(arg2-1)./(1+(arg2-1).^2))/n;
    D=zeros(M,1);
    for i=1:M
        D(i)=sum((grad(:,i)-fullgrad).^2);
    end
    sigsq(k)=(1/(M-1))*sum(D);  
end

sigma=sqrt(max(sigsq));


