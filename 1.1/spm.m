function [P z]=spm(y_temp, FS)
P=[];
z=[];
[P,z]=pwelch(y_temp,[],[],[],FS);
P=P./max(P);
