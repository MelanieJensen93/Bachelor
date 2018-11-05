function varargout = GUISensordataoverblik(varargin)
% GUISENSORDATAOVERBLIK MATLAB code for GUISensordataoverblik.fig
%      GUISENSORDATAOVERBLIK, by itself, creates a new GUISENSORDATAOVERBLIK or raises the existing
%      singleton*.
%
%      H = GUISENSORDATAOVERBLIK returns the handle to a new GUISENSORDATAOVERBLIK or the handle to
%      the existing singleton*.
%
%      GUISENSORDATAOVERBLIK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISENSORDATAOVERBLIK.M with the given input arguments.
%
%      GUISENSORDATAOVERBLIK('Property','Value',...) creates a new GUISENSORDATAOVERBLIK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUISensordataoverblik_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUISensordataoverblik_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUISensordataoverblik

% Last Modified by GUIDE v2.5 02-Nov-2018 13:38:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUISensordataoverblik_OpeningFcn, ...
                   'gui_OutputFcn',  @GUISensordataoverblik_OutputFcn, ...
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


% --- Executes just before GUISensordataoverblik is made visible.
function GUISensordataoverblik_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUISensordataoverblik (see VARARGIN)


% Choose default command line output for GUISensordataoverblik
handles.output = hObject;
if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    handles.Velfaerdsteknologi = varargin{1};
    ValgtSensor = handles.Velfaerdsteknologi.BrugerValgtSensor;
    if isfield(handles.Velfaerdsteknologi, 'LunaSensor')
        f = fieldnames(handles.Velfaerdsteknologi.LunaSensor);
        sensor = f(ValgtSensor);
        set(handles.txtValgtteknologiSensorOverblik, 'String', sensor);
        
        set(handles.lbBemaerkning, 'Value',[]);
        drawnow;
        
        handles=OpdaterListboxmedBemaerkning(handles);
        guidata(hObject, handles);
    end 

    if isfield(handles.Velfaerdsteknologi, 'CarendoSensor')
        f = fieldnames(handles.Velfaerdsteknologi.CarendoSensor);
        sensor = f(ValgtSensor);
        d=1;
        set(handles.txtValgtteknologiSensorOverblik, 'String', sensor);
        Varighed = [handles.Velfaerdsteknologi.CarendoSensor.(string(sensor)).Varighedforarbejdsgang];
        %Idet at det er en tid så skal det skrives ud i typen duration med
        %følgende format. 
        infmt = 'mm:ss';
        Varighed = duration(Varighed,'InputFormat',infmt); 
        handles = SortereTid(handles,[handles.Velfaerdsteknologi.CarendoSensor.(string(sensor)).Tidspunkt],[handles.Velfaerdsteknologi.CarendoSensor.(string(sensor)).Medarbejdere],handles.axesMedarbejderSensorDataVindue,'Sensor');
        handles = SortereTid(handles,[handles.Velfaerdsteknologi.CarendoSensor.(string(sensor)).Tidspunkt],Varighed,handles.axesVarighedSensorDataVindue,'Sensor');
    end
    guidata(hObject, handles);
end
    

% UIWAIT makes GUISensordataoverblik wait for user response (see UIRESUME)
% uiwait(handles.GUISensorDataOverbliksVindue);


% --- Outputs from this function are returned to the command line.
function varargout = GUISensordataoverblik_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnTilojbemaerkningSensordatavindue.
function btnTilojbemaerkningSensordatavindue_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilojbemaerkningSensordatavindue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

datatogo = handles.Velfaerdsteknologi;
GUITilfoejBemaerkning(datatogo);
%Bemaerkning(datatogo);



% --- Executes on selection change in lbBemaerkning.
function lbBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to lbBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbBemaerkning contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbBemaerkning


% --- Executes during object creation, after setting all properties.
function lbBemaerkning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnVaelgDatoSensorDataOverblik.
function btnVaelgDatoSensorDataOverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnVaelgDatoSensorDataOverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.stDatoSensorOverblik);

waitfor(handles.stDatoSensorOverblik,'String');
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
d=1;
sensorer=fieldnames(handles.Velfaerdsteknologi.(teknologi));
sensor = string(sensorer(handles.Velfaerdsteknologi.BrugerValgtSensor));
Varighed = [handles.Velfaerdsteknologi.(teknologi).(sensor).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
Varighed = duration(Varighed,'InputFormat',infmt); 
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).(sensor).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).(sensor).Medarbejdere],handles.axesMedarbejderSensorDataVindue,'Sensor');
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).(sensor).Tidspunkt],Varighed,handles.axesVarighedSensorDataVindue,'Sensor');



% --- Executes on button press in etDatoSensor.
function etDatoSensor_Callback(hObject, eventdata, handles)
% hObject    handle to etDatoSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of etDatoSensor


% --- Executes during object creation, after setting all properties.
function etDatoSensor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etDatoSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when selected object is changed in btngroupRedigerGrafSensoroverblik.
function btngroupRedigerGrafSensoroverblik_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigerGrafSensoroverblik 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
d=1;
sensorer=fieldnames(handles.Velfaerdsteknologi.(teknologi));
sensor = string(sensorer(handles.Velfaerdsteknologi.BrugerValgtSensor));
Varighed = [handles.Velfaerdsteknologi.(teknologi).(sensor).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
Varighed = duration(Varighed,'InputFormat',infmt); 
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).(sensor).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).(sensor).Medarbejdere],handles.axesMedarbejderSensorDataVindue,'Sensor');
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).(sensor).Tidspunkt],Varighed,handles.axesVarighedSensorDataVindue,'Sensor');

% --- Executes on button press in btnTilbageSensorDataoverblik.
function btnTilbageSensorDataoverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbageSensorDataoverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUISensordataoverblik_OpeningFcn(hObject, eventdata, handles, 'exit');
 % --- Executes when user attempts to close GUISensorDataOverbliksVindue.
 
function GUISensorDataOverbliksVindue_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to GUISensorDataOverbliksVindue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 % Hint: delete(hObject) closes the figure
delete(hObject);