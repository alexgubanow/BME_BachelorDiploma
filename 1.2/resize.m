function varargout = resize(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resize_OpeningFcn, ...
                   'gui_OutputFcn',  @resize_OutputFcn, ...
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

function resize_OpeningFcn(hObject, eventdata, handles, varargin)

global y_temp t_temp t_marker_start t_marker_end t_end t_start y_marker
handles.output = hObject;
guidata(hObject, handles);
axes(handles.axes3);
plot(t_temp,y_temp)
ylabel('Амплитуда')
xlabel('Время, сек')
title('Исходный сигнал миограммы')
hold on
t_start=t_temp(1000);
t_end=t_temp(end-1000);
k=1;
for i=1:length(t_temp)-1
    if (t_start<t_temp(i))&&(t_end>t_temp(i+1))
        y_resize(k)=y_temp(i);
        t_resize(k)=t_temp(i);
        k=k+1;
    end
end
plot(t_resize,y_resize,'red');
y_marker=[max(y_temp) min(y_temp)];
for i=1:2
    t_marker_start(i)=t_start;
end
for i=1:2
    t_marker_end(i)=t_end;
end
plot(t_marker_start,y_marker,'green'); 
plot(t_marker_end,y_marker,'green');
set(handles.axes3, 'XTick', 0:1:t_temp(end));
set(handles.edit1,'string',num2str(t_start));
set(handles.edit2,'string',num2str(t_end));


function varargout = resize_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function start_Callback(hObject, eventdata, handles)
global t_temp y_temp y_marker y_resize t_resize
t_resize=[];
y_resize=[];
axes(handles.axes3);
hold on
t_start=str2num(get(handles.edit1,'string'));
t_end=str2num(get(handles.edit2,'string'));
k=1;
for i=1:length(t_temp)-1
    if (t_start<t_temp(i))&&(t_end>t_temp(i+1))
        y_resize(k)=y_temp(i);
        t_resize(k)=t_temp(i);
        k=k+1;
    end
end
cla
plot(t_temp,y_temp)
plot(t_resize,y_resize,'red');
for i=1:2
    t_marker_start(i)=t_start;
end
for i=1:2
    t_marker_end(i)=t_end;
end
set(handles.axes3, 'XTick', 0:1:t_temp(end));
plot(t_marker_start,y_marker,'green'); 
plot(t_marker_end,y_marker,'green');

function end_Callback(hObject, eventdata, handles)
global t_temp y_temp y_marker y_resize t_resize
t_resize=[];
y_resize=[];
axes(handles.axes3);
hold on
t_start=str2num(get(handles.edit1,'string'));
t_end=str2num(get(handles.edit2,'string'));
k=1;
for i=1:length(t_temp)-1
    if (t_start<t_temp(i))&&(t_end>t_temp(i+1))
        y_resize(k)=y_temp(i);
        t_resize(k)=t_temp(i);
        k=k+1;
    end
end
cla
plot(t_temp,y_temp)
plot(t_resize,y_resize,'red');
for i=1:2
    t_marker_start(i)=t_start;
end
for i=1:2
    t_marker_end(i)=t_end;
end
set(handles.axes3, 'XTick', 0:1:t_temp(end));
plot(t_marker_end,y_marker,'green');
plot(t_marker_start,y_marker,'green');

function pushbutton11_Callback(hObject, eventdata, handles)
close(resize)

function pushbutton1_Callback(hObject, eventdata, handles)
global t_temp y_temp t_resize y_resize

t_temp=t_resize;
y_temp=y_resize;
close(resize)

function pushbutton12_Callback(hObject, eventdata, handles)
global Y t y_temp t_temp t_start t_end

y_temp=Y;
t_temp=t;
axes(handles.axes3);
hold on
cla
t_start=t_temp(1000);
t_end=t_temp(end-1000);
k=1;
for i=1:length(t_temp)-1
    if (t_start<t_temp(i))&&(t_end>t_temp(i+1))
        y_resize(k)=y_temp(i-1);
        t_resize(k)=t_temp(i-1);
        k=k+1;
    end
end
plot(t_resize,y_resize,'red');
y_marker=[0.8 -0.8];
for i=1:2
    t_marker_start(i)=t_start;
end
for i=1:2
    t_marker_end(i)=t_end;
end
plot(t_temp,y_temp)
plot(t_resize,y_resize,'red');
ylabel('Амплитуда')
xlabel('Время, сек')
title('Исходный сигнал миограммы')
plot(t_marker_start,y_marker,'green'); 
plot(t_marker_end,y_marker,'green');
set(handles.axes3, 'XTick', 0:1:t_temp(end));
set(handles.edit1,'string',num2str(t_start));
set(handles.edit2,'string',num2str(t_end));




