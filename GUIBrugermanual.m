function varargout = GUIBrugermanual(varargin)
% GUIBRUGERMANUAL MATLAB code for GUIBrugermanual.fig
%      GUIBRUGERMANUAL, by itself, creates a new GUIBRUGERMANUAL or raises the existing
%      singleton*.
%
%      H = GUIBRUGERMANUAL returns the handle to a new GUIBRUGERMANUAL or the handle to
%      the existing singleton*.
%
%      GUIBRUGERMANUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIBRUGERMANUAL.M with the given input arguments.
%
%      GUIBRUGERMANUAL('Property','Value',...) creates a new GUIBRUGERMANUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIBrugermanual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIBrugermanual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIBrugermanual

% Last Modified by GUIDE v2.5 04-Oct-2018 13:19:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIBrugermanual_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIBrugermanual_OutputFcn, ...
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


% --- Executes just before GUIBrugermanual is made visible.
function GUIBrugermanual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIBrugermanual (see VARARGIN)

% Choose default command line output for GUIBrugermanual
handles.output = hObject;
handles.Velfaerdsteknologi = varargin{1}; %henter handles fra GUIValgafteknologi
guidata(hObject, handles);
handles = Brugermanual(handles); 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIBrugermanual wait for user response (see UIRESUME)
% uiwait(handles.BrugermanualVindue);


% --- Outputs from this function are returned to the command line.
function varargout = GUIBrugermanual_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;