function varargout = GUISensorliste(varargin)
% GUISENSORLISTE MATLAB code for GUISensorliste.fig
%      GUISENSORLISTE, by itself, creates a new GUISENSORLISTE or raises the existing
%      singleton*.
%
%      H = GUISENSORLISTE returns the handle to a new GUISENSORLISTE or the handle to
%      the existing singleton*.
%
%      GUISENSORLISTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISENSORLISTE.M with the given input arguments.
%
%      GUISENSORLISTE('Property','Value',...) creates a new GUISENSORLISTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUISensorliste_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUISensorliste_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUISensorliste

% Last Modified by GUIDE v2.5 12-Nov-2018 15:13:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUISensorliste_OpeningFcn, ...
                   'gui_OutputFcn',  @GUISensorliste_OutputFcn, ...
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


% --- Executes just before GUISensorliste is made visible.
function GUISensorliste_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUISensorliste (see VARARGIN)

% Choose default command line output for GUISensorliste
handles.output = hObject;
set(gcf, 'WindowState', 'fullscreen');
if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    set(gcf,'Pointer','watch');
    if ~isfield(varargin{1,1}, 'TilbageKnap')
        
        handles.Velfaerdsteknologi = varargin{1};
        guidata(hObject, handles);

        handles = SensorInddeling(handles);
    else 
        handles.Velfaerdsteknologi = varargin{1,1}.Velfaerdsteknologi;
        guidata(hObject, handles);
        OpdaterListboxSensorOverblik(handles);
        guidata(hObject, handles);
    end
    
        if isfield(handles.Velfaerdsteknologi, 'CarendoSensor')
           set(handles.txtValgtteknologiSensorliste, 'String', 'Carendo');
           CarendoBilledeMedSensor = imread('CarendoMedSensor.png');
           axes(handles.axTeknologiMedSensorSensorliste);
           imshow(CarendoBilledeMedSensor);
        end
        
        if isfield(handles.Velfaerdsteknologi, 'LunaSensor')
            set(handles.txtValgtteknologiSensorliste, 'String', 'Luna loftlift');
            LunaBilledeMedSensor = imread('LunaMedSensor.png');
            axes(handles.axTeknologiMedSensorSensorliste);
            imshow(LunaBilledeMedSensor);
        end
    
    AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
    axes(handles.axAarhusLogo);
    imshow(AarhusKommuneLogo);
    
    % Update handles structure
    guidata(hObject, handles);
    set(gcf,'Pointer','arrow');
    if ~isfield(varargin{1,1}, 'TilbageKnap')
        GUITeknologioverblik('exit');
    end
    
end
% UIWAIT makes GUISensorliste wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUISensorliste_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(gcf, 'WindowState', 'fullscreen');
% set(gcf, 'Position', get(0,'Screensize'));
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


% --- Executes on button press in btnTilbageSensorliste.
function btnTilbageSensorliste_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbageSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

GUISensorliste_OpeningFcn(hObject, eventdata, handles, 'exit');
%datatogo = handles.Velfaerdsteknologi;
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
sensor=fieldnames(teknologi(1));
%sensor = string(sensorer(handles.Velfaerdsteknologi.BrugerValgtSensor));
GUITeknologioverblik(sensor);


% --- Executes on selection change in lbSensorliste.
function lbSensorliste_Callback(hObject, eventdata, handles)
% hObject    handle to lbSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbSensorliste contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbSensorliste
handles.Velfaerdsteknologi.BrugerValgtSensor = get(hObject, 'Value');
datatogo = handles.Velfaerdsteknologi;
guidata(hObject, handles);
GUISensorliste_OpeningFcn(hObject, eventdata, handles, 'exit');
GUISensordataoverblik(datatogo);

% --- Executes during object creation, after setting all properties.
function lbSensorliste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in btnAfslutSystem.
function btnAfslutSystem_Callback(hObject, eventdata, handles)
% hObject    handle to btnAfslutSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spoergsmaal=sprintf('Ønsker du at afslutte programmet: ?');
svar=questdlg(spoergsmaal,'Afslut',...
'Ja', 'Nej', 'Nej'); %den sidste gem er default værdien
switch svar
    case 'Ja'
        GUISensorliste_OpeningFcn(hObject, eventdata, handles, 'exit');
end





