% v=1;%regularizer parameter
filenames=['aX.mat';'ay.mat';'mX.mat';'my.mat'];%a9a and mnist datasets
MaxL=1000; %Used to reduce output lengths for publication by averaging iterations

for ds=1:2

fn=[filenames(1+2*(ds-1),:);filenames(2+2*(ds-1),:)];    
    
load(fn(1,:))%X
d=size(X,2);
n=size(X,1);

ka=1/d;%kappa regularizer parameter

if ds==1 
    
e=3.9;%Number of passes over the data.  
SSDCSPGoutput=SSDCSPG(n,d,ka,e,fn);
save('SSDCSPGoutput.mat','SSDCSPGoutput','-v7.3')
hSSDCSPG=h(SSDCSPGoutput(1:d,:),ka,fn);
save('hSSDCSPG.mat','hSSDCSPG','-v7.3')

e=15;
SSDCSVRGoutput=SSDCSVRG(n,d,ka,e,fn);
save('SSDCSVRGoutput.mat','SSDCSVRGoutput','-v7.3')
hSSDCSVRG=h(SSDCSVRGoutput(1:d,:),ka,fn);
save('hSSDCSVRG.mat','hSSDCSVRG','-v7.3')
 
e=1.4;
MBSGAoutput=MBSGA(n,d,ka,e,fn);
save('MBSGAoutput.mat','MBSGAoutput','-v7.3')
hMBSGA=h(MBSGAoutput(1:d,:),ka,fn);
save('hMBSGA.mat','hMBSGA','-v7.3')

e=62;
VRSGAoutput=VRSGA(n,d,ka,e,fn);
save('VRSGAoutput.mat','VRSGAoutput','-v7.3')
hVRSGA=h(VRSGAoutput(1:d,:),ka,fn);
save('hVRSGA.mat','hVRSGA','-v7.3')


[tSSDCSPG,lhSSDCSPG]=reduceLength(SSDCSPGoutput(d+1,:),hSSDCSPG,MaxL);    
save('tSSDCSPG.mat','tSSDCSPG')
save('lhSSDCSPG.mat','lhSSDCSPG')    

[tSSDCSVRG,lhSSDCSVRG]=reduceLength(SSDCSVRGoutput(d+1,:),hSSDCSVRG,MaxL);    
save('tSSDCSVRG.mat','tSSDCSVRG')
save('lhSSDCSVRG.mat','lhSSDCSVRG')  

[tMBSGA,lhMBSGA]=reduceLength(MBSGAoutput(d+1,:),hMBSGA,MaxL);    
save('tMBSGA.mat','tMBSGA')
save('lhMBSGA.mat','lhMBSGA')  

[tVRSGA,lhVRSGA]=reduceLength(VRSGAoutput(d+1,:),hVRSGA,MaxL);    
save('tVRSGA.mat','tVRSGA')
save('lhVRSGA.mat','lhVRSGA')  


else
    
e=1;
SSDCSPGoutput=SSDCSPG(n,d,ka,e,fn);
save('SSDCSPGoutput2.mat','SSDCSPGoutput','-v7.3')
hSSDCSPG=h(SSDCSPGoutput(1:d,:),ka,fn);
save('hSSDCSPG2.mat','hSSDCSPG','-v7.3')

e=9;
SSDCSVRGoutput=SSDCSVRG(n,d,ka,e,fn);
save('SSDCSVRGoutput2.mat','SSDCSVRGoutput','-v7.3')
hSSDCSVRG=h(SSDCSVRGoutput(1:d,:),ka,fn);
save('hSSDCSVRG2.mat','hSSDCSVRG','-v7.3')

e=0.75;
MBSGAoutput=MBSGA(n,d,ka,e,fn);
save('MBSGAoutput2.mat','MBSGAoutput','-v7.3')
hMBSGA=h(MBSGAoutput(1:d,:),ka,fn);
save('hMBSGA2.mat','hMBSGA','-v7.3')

e=25;
VRSGAoutput=VRSGA(n,d,ka,e,fn);
save('VRSGAoutput2.mat','VRSGAoutput','-v7.3')
hVRSGA=h(VRSGAoutput(1:d,:),ka,fn);
save('hVRSGA2.mat','hVRSGA','-v7.3')


[tSSDCSPG,lhSSDCSPG]=reduceLength(SSDCSPGoutput(d+1,:),hSSDCSPG,MaxL);    
save('tSSDCSPG2.mat','tSSDCSPG')
save('lhSSDCSPG2.mat','lhSSDCSPG')    

[tSSDCSVRG,lhSSDCSVRG]=reduceLength(SSDCSVRGoutput(d+1,:),hSSDCSVRG,MaxL);    
save('tSSDCSVRG2.mat','tSSDCSVRG')
save('lhSSDCSVRG2.mat','lhSSDCSVRG')  

[tMBSGA,lhMBSGA]=reduceLength(MBSGAoutput(d+1,:),hMBSGA,MaxL);    
save('tMBSGA2.mat','tMBSGA')
save('lhMBSGA2.mat','lhMBSGA')  

[tVRSGA,lhVRSGA]=reduceLength(VRSGAoutput(d+1,:),hVRSGA,MaxL);    
save('tVRSGA2.mat','tVRSGA')
save('lhVRSGA2.mat','lhVRSGA') 

end


figure
%log of objective versus time
plot(SSDCSPGoutput(d+1,:),log(hSSDCSPG),'red',SSDCSVRGoutput(d+1,:),log(hSSDCSVRG),'blue',MBSGAoutput(d+1,:),log(hMBSGA),'black',VRSGAoutput(d+1,:),log(hVRSGA),'green')

figure
%log of objective versus time reduced length
plot(tSSDCSPG,lhSSDCSPG,'red',tSSDCSVRG,lhSSDCSVRG,'blue',tMBSGA,lhMBSGA,'black',tVRSGA,lhVRSGA,'green')

end