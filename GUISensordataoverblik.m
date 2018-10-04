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

% Last Modified by GUIDE v2.5 04-Oct-2018 11:41:19

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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUISensordataoverblik wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
