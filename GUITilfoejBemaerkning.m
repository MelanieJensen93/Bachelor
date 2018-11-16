function varargout = GUITilfoejBemaerkning(varargin)
% GUITILFOEJBEMAERKNING MATLAB code for GUITilfoejBemaerkning.fig
%      GUITILFOEJBEMAERKNING, by itself, creates a new GUITILFOEJBEMAERKNING or raises the existing
%      singleton*.
%
%      H = GUITILFOEJBEMAERKNING returns the handle to a new GUITILFOEJBEMAERKNING or the handle to
%      the existing singleton*.
%
%      GUITILFOEJBEMAERKNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITILFOEJBEMAERKNING.M with the given input arguments.
%
%      GUITILFOEJBEMAERKNING('Property','Value',...) creates a new GUITILFOEJBEMAERKNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUITilfoejBemaerkning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUITilfoejBemaerkning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUITilfoejBemaerkning

% Last Modified by GUIDE v2.5 31-Oct-2018 10:50:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUITilfoejBemaerkning_OpeningFcn, ...
                   'gui_OutputFcn',  @GUITilfoejBemaerkning_OutputFcn, ...
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


% --- Executes just before GUITilfoejBemaerkning is made visible.
function GUITilfoejBemaerkning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUITilfoejBemaerkning (see VARARGIN)

% Choose default command line output for GUITilfoejBemaerkning
handles.output = hObject;
if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    set(gcf,'Pointer','watch');
    handles.Velfaerdsteknologi = varargin{1}; 

    AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
    axes(handles.axAarhusLogo);
    imshow(AarhusKommuneLogo);

    if isfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato')
        ValgtafTidspunkt(handles);
    end
    
    ValgtSensor = handles.Velfaerdsteknologi.BrugerValgtSensor;
    if isfield(handles.Velfaerdsteknologi, 'LunaSensor')
        Sensornavn = fieldnames(handles.Velfaerdsteknologi.LunaSensor);
        sensor = Sensornavn(ValgtSensor);
        udskrift = sprintf('Luna loftlift %s', string(sensor));
        set(handles.txtValgtTeknologiTilfoejbemaerkning, 'String', udskrift);
    end
    
    if isfield(handles.Velfaerdsteknologi, 'CarendoSensor')
        Sensornavn = fieldnames(handles.Velfaerdsteknologi.CarendoSensor);
        handles.field = 'CarendoSensor'; 
        sensor = Sensornavn(ValgtSensor);
        udskrift = sprintf('Carendo %s', string(sensor));
        set(handles.txtValgtTeknologiTilfoejbemaerkning, 'String', udskrift);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    set(gcf,'Pointer','arrow');
end
% UIWAIT makes GUITilfoejBemaerkning wait for user response (see UIRESUME)
% uiwait(handles.GUITilfoejBemaerkning);

% --- Outputs from this function are returned to the command line.
function varargout = GUITilfoejBemaerkning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnVealgDatoTilfoejBemearkning.
function btnVealgDatoTilfoejBemearkning_Callback(hObject, eventdata, handles)
% hObject    handle to btnVealgDatoTilfoejBemearkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Laver en kalender 
% https://se.mathworks.com/help/finance/uicalendar-graphical-user-interface.html
 waitfor(uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.etDatoTilfoejBemaerkning));

ValgtDato = get(handles.etDatoTilfoejBemaerkning, 'String');
ValgtDatoDatetime = datetime(ValgtDato, 'InputFormat', 'dd-MM-yyyy');

datatogo = handles.Velfaerdsteknologi;
ValgAfDatapunkt(handles,datatogo, ValgtDato, ValgtDatoDatetime);

% --- Executes on button press in rbMiddagTilfoejBemaerkning.
%function rbMiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbMiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbMiddagTilfoejBemaerkning


% --- Executes on button press in rbNatTilfoejBemaerkning.
%function rbNatTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbNatTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbNatTilfoejBemaerkning

function etDatoTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to etDatoTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of etDatoTilfoejBemaerkning as text
%        str2double(get(hObject,'String')) returns contents of etDatoTilfoejBemaerkning as a double

% --- Executes during object creation, after setting all properties.
function etDatoTilfoejBemaerkning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etDatoTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in rbMorgenTilfoejBemearkning.
%function rbMorgenTilfoejBemearkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbMorgenTilfoejBemearkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbMorgenTilfoejBemearkning

% --- Executes on button press in rbEftermiddagTilfoejBemaerkning.
%function rbEftermiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbEftermiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbEftermiddagTilfoejBemaerkning

% --- Executes on button press in rbFormiddagTilfoejBemaerkning.
%function rbFormiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbFormiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbFormiddagTilfoejBemaerkning

% --- Executes on button press in rbAftenTilfoejBemaerkning.
%function rbAftenTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbAftenTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbAftenTilfoejBemaerkning

% --- Executes when selected object is changed in bgTidspunktTilfoejBemaerkning.
function bgTidspunktTilfoejBemaerkning_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bgTidspunktTilfoejBemaerkning 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.TB(1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String')

% --- Executes when selected object is changed in bgBemaerkningTilfoejBemaerkning.
function bgBemaerkningTilfoejBemaerkning_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bgBemaerkningTilfoejBemaerkning 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.TB(1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');

% --- Executes on button press in rbBorgerKraeverToPersonalerTilfoejBemaerkning.
function rbBorgerKraeverToPersonalerTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbBorgerKraeverToPersonalerTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of rbBorgerKraeverToPersonalerTilfoejBemaerkning
set(handles.rbBorgerKraeverToPersonalerTilfoejBemaerkning, 'ForegroundColor', [0.69 0.49 0])
set(handles.rbEkstraPersonaleTilstedeTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])
set(handles.rbAndetTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])

% --- Executes on button press in rbEkstraPersonaleTilstedeTilfoejBemaerkning.
function rbEkstraPersonaleTilstedeTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbEkstraPersonaleTilstedeTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of rbEkstraPersonaleTilstedeTilfoejBemaerkning
set(handles.rbBorgerKraeverToPersonalerTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])
set(handles.rbEkstraPersonaleTilstedeTilfoejBemaerkning, 'ForegroundColor', [0.69 0.49 0])
set(handles.rbAndetTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])

% --- Executes on button press in rbAndetTilfoejBemaerkning.
function rbAndetTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to rbAndetTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of rbAndetTilfoejBemaerkning
set(handles.rbBorgerKraeverToPersonalerTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])
set(handles.rbEkstraPersonaleTilstedeTilfoejBemaerkning, 'ForegroundColor', [0 0.55 0.69])
set(handles.rbAndetTilfoejBemaerkning, 'ForegroundColor', [0.69 0.49 0])
% --- Executes on button press in btnTilfoejBemaerkningTilfoejBemaerkning.
function btnTilfoejBemaerkningTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilfoejBemaerkningTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ValgtDato = get(handles.etDatoTilfoejBemaerkning, 'String');

rbEkstraPersonaleTilstede = get(handles.rbEkstraPersonaleTilstedeTilfoejBemaerkning, 'Value');
rbBorgerKraeverToPersonaler = get(handles.rbBorgerKraeverToPersonalerTilfoejBemaerkning, 'Value');
etAndetTilfoejBemaerkning = get(handles.etAndetTilfoejBemaerkning, 'string');

if rbBorgerKraeverToPersonaler==1 || rbEkstraPersonaleTilstede==1 || ~isempty(etAndetTilfoejBemaerkning)==1
    Bemaerkning(handles);
    guidata(hObject, handles);

    GUITilfoejBemaerkning_OpeningFcn(hObject, eventdata, handles, 'exit');
    datatogo = handles.Velfaerdsteknologi;
    GUISensordataoverblik(datatogo);
else
    if isempty(ValgtDato)
        uiwait(msgbox('V�lg venligst et tidspunkt og hvilken bem�rkning du �nsker at tilf�je. Hvis du �nsker at tilf�je en bem�rkning til feltet "Andet" skal du skrive hvad andet d�kker over i feltet til h�jre.', 'Error', 'error', 'modal'));
    else
        uiwait(msgbox('V�lg venligst hvilken bem�rkning du �nsker at tilf�je. Hvis du �nsker at tilf�je en bem�rkning til feltet "Andet" skal du skrive hvad andet d�kker over i feltet til h�jre.', 'Error', 'error', 'modal'));
    end
end


function etAndetTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to etAndetTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etAndetTilfoejBemaerkning as text
%        str2double(get(hObject,'String')) returns contents of etAndetTilfoejBemaerkning as a double


% --- Executes during object creation, after setting all properties.
function etAndetTilfoejBemaerkning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etAndetTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
