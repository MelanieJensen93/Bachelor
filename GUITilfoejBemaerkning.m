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

% Last Modified by GUIDE v2.5 08-Oct-2018 09:54:55

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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUITilfoejBemaerkning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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

uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.etDatoTilfoejBemaerkning);



% --- Executes on button press in btnTilfoejBemaerkningTilfoejBemaerkning.
function btnTilfoejBemaerkningTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilfoejBemaerkningTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cbBorgerkraevertopersonalerTilfoejBemaerning.
function cbBorgerkraevertopersonalerTilfoejBemaerning_Callback(hObject, eventdata, handles)
% hObject    handle to cbBorgerkraevertopersonalerTilfoejBemaerning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbBorgerkraevertopersonalerTilfoejBemaerning


% --- Executes on button press in cbEkstrapersonaletilstedeTilfoejBemaerkning.
function cbEkstrapersonaletilstedeTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbEkstrapersonaletilstedeTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbEkstrapersonaletilstedeTilfoejBemaerkning


% --- Executes on button press in cbAndetTilfoejBemaerkning.
function cbAndetTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbAndetTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbAndetTilfoejBemaerkning



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


% --- Executes on button press in cbMorgenTilfoejBemaerkning.
function cbMorgenTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbMorgenTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbMorgenTilfoejBemaerkning


% --- Executes on button press in cbFormiddagTilfoejBemaerkning.
function cbFormiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbFormiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbFormiddagTilfoejBemaerkning


% --- Executes on button press in cbMiddagTilfoejBemaerkning.
function cbMiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbMiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbMiddagTilfoejBemaerkning


% --- Executes on button press in cbAftenTilfoejBemaerkning.
function cbAftenTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbAftenTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbAftenTilfoejBemaerkning


% --- Executes on button press in cbNatTilfoejBemaerkning.
function cbNatTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbNatTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbNatTilfoejBemaerkning


% --- Executes on button press in cbEftermiddagTilfoejBemaerkning.
function cbEftermiddagTilfoejBemaerkning_Callback(hObject, eventdata, handles)
% hObject    handle to cbEftermiddagTilfoejBemaerkning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbEftermiddagTilfoejBemaerkning



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


