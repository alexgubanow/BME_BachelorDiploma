function varargout = add_to_base_sitenko(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @add_to_base_sitenko_OpeningFcn, ...
                   'gui_OutputFcn',  @add_to_base_sitenko_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before add_to_base is made visible.
function add_to_base_sitenko_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
set(handles.popupmenu1, 'Value', 1);
set(handles.popupmenu2, 'Value', 1);
set(handles.popupmenu3, 'Value', 1);
set(handles.popupmenu4, 'Value', 1);

% --- Outputs from this function are returned to the command line.
function varargout = add_to_base_sitenko_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TotalP MeanP MedF MeanF PeakF my_choice_fin dMedFfirst dMedFend frate
zero_time=datestr(now);
f = get(handles.edit1,'String');
i = get(handles.edit2,'String');
o = get(handles.edit3,'String');
age = str2num(get(handles.edit1,'String'));
sex = get(handles.popupmenu1,'Value');
muscle = get(handles.popupmenu2,'Value');
diagnosis = get(handles.popupmenu4,'Value');
infa=get(handles.edit5,'String');

if get(handles.popupmenu4,'Value')==1
    channel = my_choice_fin;
else
    channel = get(handles.popupmenu3,'Value');
end
fid = fopen('base_sitenko.txt','a');
fprintf(fid, '\r\n%s\t%s\t%s\t%s\t%3.0f\t%d\t%d\t%d\t%d\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%s\r\n',zero_time,f,i,o,age,sex,muscle,channel, diagnosis, TotalP, MeanP, MedF, MeanF,dMedFfirst,dMedFend,frate,infa);
fclose(fid);
    if exist(strcat(dialog, '.fig'))
        openfig(dialog, 'reuse')
    end
    uiwait(dialog)












