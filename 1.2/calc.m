function varargout = calc(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calc_OpeningFcn, ...
                   'gui_OutputFcn',  @calc_OutputFcn, ...
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

function calc_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
global FS y_temp t_temp step frate dMedFfirst dMedFend
step=FS;
set(handles.edit4,'string',num2str(step/FS));

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
set(handles.edit13, 'String', frate);
set(handles.edit11, 'String', dMedF(1));
set(handles.edit12, 'String', dMedF(end));
t_dMedF=1:1:length(dMedF);
axes(handles.axes3);
plot(t_dMedF,dMedF);
xlabel('Время, сек')
ylabel('Частота, Гц')
title('Зависимость медианной частоты от времени')
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);

function varargout = calc_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
global FS y_temp t_temp step frate dMedFfirst dMedFend
step=step-1000;
set(handles.edit4,'string',num2str(step/FS));

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
set(handles.edit13, 'String', frate);
set(handles.edit11, 'String', dMedF(1));
set(handles.edit12, 'String', dMedF(end));
t_dMedF=1:1:length(dMedF);
axes(handles.axes3);
cla
plot(t_dMedF,dMedF);
xlabel('Время, сек')
ylabel('Частота, Гц')
title('Зависимость медианной частоты от времени')
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);

function pushbutton2_Callback(hObject, eventdata, handles)
global FS y_temp t_temp step frate dMedFfirst dMedFend
step=step+1000;
set(handles.edit4,'string',num2str(step/FS));
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
set(handles.edit13, 'String', frate);
set(handles.edit11, 'String', dMedF(1));
set(handles.edit12, 'String', dMedF(end));
t_dMedF=1:1:length(dMedF);
axes(handles.axes3);
cla
plot(t_dMedF,dMedF);
xlabel('Время, сек')
ylabel('Частота, Гц')
title('Зависимость медианной частоты от времени')
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);

function edit4_Callback(hObject, eventdata, handles)
global FS y_temp t_temp step frate dMedFfirst dMedFend
step=FS*(str2num(get(handles.edit4,'string')));

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
set(handles.edit13, 'String', frate);
set(handles.edit11, 'String', dMedF(1));
set(handles.edit12, 'String', dMedF(end));
t_dMedF=1:1:length(dMedF);
axes(handles.axes3);
cla
plot(t_dMedF,dMedF);
xlabel('Время, сек')
ylabel('Частота, Гц')
title('Зависимость медианной частоты от времени')
dMedFfirst=dMedF(1);
dMedFend=dMedF(end);
