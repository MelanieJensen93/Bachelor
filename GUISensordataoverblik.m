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

% Last Modified by GUIDE v2.5 12-Oct-2018 12:49:04

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

handles.Velfaerdsteknologi = varargin{1};
guidata(hObject, handles);



if ~isempty(varargin)
    d=1;
    handles.TB = varargin{1}; %henter handles fra GUIBemaerkning
    %guidata(hObject, handles);
end

guidata(hObject, handles);

%OpdaterListboxmedBemaerkning(handles);
% idx=1;
% a= sprintf("%s %s %s"+handles.TB.B(idx).bemaerkning,handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt);
% str_part = a; 
% old_str = get(handles.lbBemaerkning,'String'); 
% new_str=strvcat(char(old_str),char(str_part));
% set(handles.lbBemaerkning,'String',new_str);
% set(handles.lbBemaerkning, 'Value', idx+1);


% Update handles structure
guidata(hObject, handles);


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

%datatogo = handles.lbBemaerkning;
%GUITilfoejBemaerkning(handles);
handles.vv = 'kk';
datatogo = handles.vv;
Bemaerkning(datatogo);



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
