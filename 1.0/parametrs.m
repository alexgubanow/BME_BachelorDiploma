function [TotalP MeanP MedF MeanF PeakF]=parametrs(P,z)
TotalP=[];
MeanP=[];
MedF=[];
MeanF=[];
PeakF=[];
TotalP=sum(P);
MeanP=mean(P);
CumSum=cumsum(P);
halfPower=TotalP/2;
for i=1:length(P)-1
    if CumSum(i)>=halfPower
        MedF=z(i-1);
break
    end
end
MeanF=sum(z.*P)/sum(P);
PeakF_P=max(P);
for i=1:length(P)
    if PeakF_P==P(i)
        PeakF=z(i);
    end
end