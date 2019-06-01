function varargout = launc(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launc_OpeningFcn, ...
                   'gui_OutputFcn',  @launc_OutputFcn, ...
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

function launc_OpeningFcn(hObject, eventdata, handles, varargin)
global settings
handles.output = hObject;
guidata(hObject, handles);
fid = fopen('settings.ini','r');
settings=fscanf(fid,'%d');
fclose(fid);



% --- Outputs from this function are returned to the command line.
function varargout = launc_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
global settings
settings(1,1)=1;
if settings(2,1)==1
    if settings(3,1)==0
        if exist(strcat(main_ru, '.fig'))
            openfig(main_ru, 'reuse')
        end
    elseif settings(3,1)==1
        if exist(strcat(main_ru_otladka, '.fig'))
            openfig(main_ru_otladka, 'reuse')
        end
    end
end
if settings(2,1)==2
    if settings(3,1)==0
        if exist(strcat(main_en, '.fig'))
            openfig(main_en, 'reuse')
        end
    elseif settings(3,1)==1
        if exist(strcat(main_en_otladka, '.fig'))
            openfig(main_en_otladka, 'reuse')
        end
    end
end
close('launc')



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global settings
settings(1,1)=2;
if settings(2,1)==1
    if settings(3,1)==0
        if exist(strcat(main_ru, '.fig'))
            openfig(main_ru, 'reuse')
        end
    elseif settings(3,1)==1
        if exist(strcat(main_ru_otladka, '.fig'))
            openfig(main_ru_otladka, 'reuse')
        end
    end
    end
if settings(2,1)==2
    if settings(3,1)==0
        if exist(strcat(main_en, '.fig'))
            openfig(main_en, 'reuse')
        end
    elseif settings(3,1)==1
        if exist(strcat(main_en_otladka, '.fig'))
            openfig(main_en_otladka, 'reuse')
        end
    end
end
close('launc')
