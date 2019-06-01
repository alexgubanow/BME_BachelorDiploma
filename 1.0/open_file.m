function [Y t FS]=open_file(FullName)
global my_choice_fin
Y=[];
t=[];
FS=[];
F=[];
[F,FS]=audioread(FullName);
t=0:1/FS:(length(F)-1)/FS;
number_of_columns=size(F, 2);
if  number_of_columns==1
    Y=F(:,1);
else
    if exist(strcat(choice, '.fig'))
       openfig(choice, 'reuse')
    end
    uiwait(choice);
    if my_choice_fin==2
        Y=F(:,1);
    end
    if my_choice_fin==3
        Y=F(:,2);
    end
end

