function varargout = GUIstartS(varargin)
% GUISTARTS MATLAB code for GUIstartS.fig
%      GUISTARTS, by itself, creates a new GUISTARTS or raises the existing
%      singleton*.
%
%      H = GUISTARTS returns the handle to a new GUISTARTS or the handle to
%      the existing singleton*.
%
%      GUISTARTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISTARTS.M with the given input arguments.
%
%      GUISTARTS('Property','Value',...) creates a new GUISTARTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIstartS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIstartS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIstartS

% Last Modified by GUIDE v2.5 04-Oct-2018 09:54:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIstartS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIstartS_OutputFcn, ...
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


% --- Executes just before GUIstartS is made visible.
function GUIstartS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIstartS (see VARARGIN)

% Choose default command line output for GUIstartS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIstartS wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUIstartS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnLunaValgafteknologi.
function btnLunaValgafteknologi_Callback(hObject, eventdata, handles)
% hObject    handle to btnLunaValgafteknologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnCarendoValgafteknologi.
function btnCarendoValgafteknologi_Callback(hObject, eventdata, handles)
% hObject    handle to btnCarendoValgafteknologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
