function [sub,p]=MEsubp(w,ka,lambda)

%This function returns the subgradient and proximal operator of the Moreau
%envelope of the regularizer. The calculation follows (Gong & Zhang, 2013). 
%v=1
p=zeros(length(w),1);

for i=1:length(w)
if ((abs(w(i))-1)/lambda)^2-4*(ka-abs(w(i))/lambda)/lambda>0
   C=0;
   C1=0.5*(abs(w(i))-1);  
   C2=0.5*lambda*sqrt(((abs(w(i))-1)/lambda)^2-4*(ka-abs(w(i))/lambda)/lambda);
   C(2)=max(0,C1+C2);   
   C(3)=max(0,C1-C2);    
   [~,ind]=min(0.5*(C-abs(w(i))).^2+ka*lambda*log(1+C));
   ep=C(ind);   
else    
    ep=0;       
end    
p(i)=sign(w(i))*ep;
end

sub=(w-p)/lambda;