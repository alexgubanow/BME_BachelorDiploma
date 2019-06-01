function varargout = main_ru(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_ru_OpeningFcn, ...
                   'gui_OutputFcn',  @main_ru_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function main_ru_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);


function varargout = main_ru_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function uipushtool1_ClickedCallback(hObject, eventdata, handles)
global Y t TotalP MeanP MedF MeanF PeakF settings lastdir FS y_temp t_temp my_choice_fin dMedFfirst dMedFend frate
set(handles.fullname, 'String', '--');
set(handles.edit1, 'String', '--');
set(handles.edit2, 'String', '--');
set(handles.edit3, 'String', '--');
set(handles.edit4, 'String', '--');
set(handles.edit5, 'String', '--');
axes(handles.axes1);
cla;
axes(handles.axes2);
cla;
clc;
fid = fopen('lastdir.ini','r');
lastdir=fscanf(fid,'%s');
fclose(fid);
path= uigetdir(lastdir, 'Открытие папки');
if ~ isequal(path, 0)
    currentdir=path;
    currentdir(end)=[];
    fid = fopen('lastdir.ini','w');
    fprintf(fid,'%s\r\n',currentdir);
    fclose(fid);
end

list=dir(strcat(path,'\','*.wav*'));
for i=1:length(list)
    set(handles.edit1, 'String', '--');
    set(handles.edit2, 'String', '--');
    set(handles.edit3, 'String', '--');
    set(handles.edit4, 'String', '--');
    set(handles.edit5, 'String', '--');
    FullName=strcat(path,'\',list(i).name);
    set(handles.fullname, 'String', FullName);
    [Y t FS]=open_file(FullName);
    y_temp=Y;
    t_temp=t;
    [P z]=spm(y_temp, FS);
    [TotalP MeanP MedF MeanF PeakF]=parametrs(P,z);
    axes(handles.axes1);
    cla
    plot(t_temp,y_temp);
    ylabel('Амплитуда');
    xlabel('Время, сек');
    title('Исходный сигнал миограммы');
    axes(handles.axes2);
    cla
    plot(z,P,'red');
    axis([0.2 500 0 1]);
    ylabel('Амплитуда');
    xlabel('Частота, Гц');
    title('СПМ');
    set(handles.edit5, 'String', TotalP)
    set(handles.edit4, 'String', MeanP)
    set(handles.edit1, 'String', MedF)
    set(handles.edit2, 'String', MeanF)
    set(handles.edit3, 'String', PeakF)
    step=FS;

l=1;
i=1;

while i+step<=length(y_temp)
    [Pp,zp]=pwelch(y_temp(i:i+step),[],[],[],FS);
    TotalPp=sum(Pp);
    HTotalPp=TotalPp/2;
    CSPp=cumsum(Pp);
    for j=2:length(CSPp)
        if CSPp(j)>HTotalPp
            k=j-1;
            dMedF(l)=zp(k);
            break
        end
    end
    l=l+1;
    i=i+round(step/2);
end

a=polyfit(1:length(dMedF),dMedF,1);
frate=a(1);
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);
    

if settings(1,1)==1
    if exist(strcat(add_to_base, '.fig'))
        openfig(add_to_base, 'reuse')
    end
    uiwait(add_to_base);
elseif settings(1,1)==2
    if exist(strcat(add_to_base_sitenko, '.fig'))
        openfig(add_to_base_sitenko, 'reuse')
    end
    uiwait(add_to_base_sitenko);
end
end





function uipushtool7_ClickedCallback(hObject, eventdata, handles)
if exist(strcat(calc, '.fig'))
    openfig(calc, 'reuse')
end

function uipushtool10_ClickedCallback(hObject, eventdata, handles)
close(main_ru)
if exist(strcat(launc, '.fig'))
    openfig(launc, 'reuse')
end



function uipushtool2_ClickedCallback(hObject, eventdata, handles)
global settings TotalP MeanP MedF MeanF PeakF

if settings(1,1)==1
    if exist(strcat(add_to_base, '.fig'))
        openfig(add_to_base, 'reuse')
    end
    uiwait(add_to_base);
elseif settings(1,1)==2
    if exist(strcat(add_to_base_sitenko, '.fig'))
        openfig(add_to_base_sitenko, 'reuse')
    end
    uiwait(add_to_base_sitenko);
end




function uipushtool8_ClickedCallback(hObject, eventdata, handles)
global t_temp y_temp FS y_resize t_resize TotalP MeanP MedF MeanF PeakF
if exist(strcat(resize, '.fig'))
    openfig(resize, 'reuse')
end
uiwait(resize);

[P z]=spm(y_resize, FS);
[TotalP MeanP MedF MeanF PeakF]=parametrs(P,z);
axes(handles.axes1);
cla
plot(t_resize,y_resize);
ylabel('Амплитуда');
xlabel('Время, сек');
title('Исходный сигнал миограммы');
axes(handles.axes2);
cla
plot(z,P,'red');
axis([0.2 500 0 1]);
ylabel('Амплитуда');
xlabel('Частота, Гц');
title('СПМ');
set(handles.edit5, 'String', TotalP)
set(handles.edit4, 'String', MeanP)
set(handles.edit1, 'String', MedF)
set(handles.edit2, 'String', MeanF)
set(handles.edit3, 'String', PeakF)

function uipushtool9_ClickedCallback(hObject, eventdata, handles)
global t_temp P my_choice_fin FS y_temp Y t TotalP MeanP MedF MeanF PeakF dMedFfirst dMedFend frate
set(handles.fullname, 'String', '--');
set(handles.edit1, 'String', '--');
set(handles.edit2, 'String', '--');
set(handles.edit3, 'String', '--');
set(handles.edit4, 'String', '--');
set(handles.edit5, 'String', '--');
axes(handles.axes1);
cla;
axes(handles.axes2);
cla;
clc;
Filter={'*.wav', 'Файл ЕМГ (*.wav)'};
fid = fopen('lastdir.ini','r');
lastdir=fscanf(fid,'%s');
fclose(fid);
[FName, PName] = uigetfile(Filter, 'Открытие файла ЕМГ',lastdir);
if ~ isequal(FName, 0)
    FullName = strcat(PName, FName);
    currentdir=PName;
    currentdir(end)=[];
    fid = fopen('lastdir.ini','w');
    fprintf(fid,'%s\r\n',currentdir);
    fclose(fid);
end

set(handles.fullname, 'String', FullName);

[Y t FS]=open_file(FullName);
y_temp=Y;
t_temp=t;
[P z]=spm(y_temp, FS);
[TotalP MeanP MedF MeanF PeakF]=parametrs(P,z);
axes(handles.axes1);
plot(t_temp,y_temp);
ylabel('Амплитуда');
xlabel('Время, сек');
title('Исходный сигнал миограммы');
axes(handles.axes2);
plot(z,P,'red');
axis([0.2 500 0 1]);
ylabel('Амплитуда');
xlabel('Частота, Гц');
title('СПМ');
set(handles.edit5, 'String', TotalP)
set(handles.edit4, 'String', MeanP)
set(handles.edit1, 'String', MedF)
set(handles.edit2, 'String', MeanF)
set(handles.edit3, 'String', PeakF)
step=FS;

l=1;
i=1;

while i+step<=length(y_temp)
    [Pp,zp]=pwelch(y_temp(i:i+step),[],[],[],FS);
    TotalPp=sum(Pp);
    HTotalPp=TotalPp/2;
    CSPp=cumsum(Pp);
    for j=2:length(CSPp)
        if CSPp(j)>HTotalPp
            k=j-1;
            dMedF(l)=zp(k);
            break
        end
    end
    l=l+1;
    i=i+round(step/2);
end

a=polyfit(1:length(dMedF),dMedF,1);
frate=a(1);
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);


