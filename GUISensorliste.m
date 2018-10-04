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

% Last Modified by GUIDE v2.5 04-Oct-2018 11:23:03

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

% Update handles structure
guidata(hObject, handles);

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


% --- Executes on button press in btnTilbageSensorliste.
function btnTilbageSensorliste_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbageSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listboxSensorliste.
function listboxSensorliste_Callback(hObject, eventdata, handles)
% hObject    handle to listboxSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxSensorliste contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxSensorliste


% --- Executes during object creation, after setting all properties.
function listboxSensorliste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxSensorliste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
