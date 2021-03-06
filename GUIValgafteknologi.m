function varargout = GUIValgafteknologi(varargin)
% GUIVALGAFTEKNOLOGI MATLAB code for GUIValgafteknologi.fig
%      GUIVALGAFTEKNOLOGI, by itself, creates a new GUIVALGAFTEKNOLOGI or raises the existing
%      singleton*.
%
%      H = GUIVALGAFTEKNOLOGI returns the handle to a new GUIVALGAFTEKNOLOGI or the handle to
%      the existing singleton*.
%
%      GUIVALGAFTEKNOLOGI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIVALGAFTEKNOLOGI.M with the given input arguments.
%
%      GUIVALGAFTEKNOLOGI('Property','Value',...) creates a new GUIVALGAFTEKNOLOGI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIValgafteknologi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIValgafteknologi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIValgafteknologi

% Last Modified by GUIDE v2.5 22-Nov-2018 20:43:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIValgafteknologi_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIValgafteknologi_OutputFcn, ...
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


% --- Executes just before GUIValgafteknologi is made visible.
function GUIValgafteknologi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIValgafteknologi (see VARARGIN)

% Choose default command line output for GUIValgafteknologi
% Stammer fra: https://stackoverflow.com/questions/15286458/automatically-maximize-a-figure
set(gcf, 'WindowState', 'fullscreen');
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Mus bliver til ur
set(gcf,'Pointer','watch');

AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
axes(handles.axAarhusLogo);
imshow(AarhusKommuneLogo);

CarendoBillede = imread('Carendo.png');
axes(handles.axCarendoValgafteknologi);
imshow(CarendoBillede);

LunaBillede = imread('Lunaloftlift.jpg');
axes(handles.axLunaValgafteknologi)
imshow(LunaBillede);

handles = IndlaesVelfaerdsteknologi(handles);
guidata(hObject,handles);

%Mus tilbage til pil 
set(gcf,'Pointer','arrow');
%set(gcf, 'Position', get(0,'Screensize'));
% UIWAIT makes GUIValgafteknologi wait for user response (see UIRESUME)
% uiwait(handles.GUIValgAfTeknologi);


% --- Outputs from this function are returned to the command line.
function varargout = GUIValgafteknologi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% Stammer fra: https://stackoverflow.com/questions/15286458/automatically-maximize-a-figure
set(gcf, 'WindowState', 'fullscreen');
%set(gcf, 'Position', get(0,'Screensize'));
%set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


% --- Executes on button press in btnLunaValgafteknologi.
function btnLunaValgafteknologi_Callback(hObject, eventdata, handles)
% hObject    handle to btnLunaValgafteknologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Sletter det der evt. ligger i handles.Carendo
if isfield(handles.Velfaerdsteknologi ,'Carendo')
   handles.Velfaerdsteknologi.Carendo = []; 
   handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,'Carendo');
end

if isfield(handles.Velfaerdsteknologi ,'Luna')
    datatogo = handles.Velfaerdsteknologi;
    guidata(hObject, handles);
    close(GUIValgafteknologi);
    GUITeknologioverblik(datatogo);
else
    msgbox('Data for den valgte velfærdsteknologi eksisterer ikke');
end


% --- Executes on button press in btnCarendoValgafteknologi.
function btnCarendoValgafteknologi_Callback(hObject, eventdata, handles)
% hObject    handle to btnCarendoValgafteknologi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Sletter det der evt. ligger i handles.Luna
if isfield(handles.Velfaerdsteknologi ,'Luna')
    handles.Velfaerdsteknologi.Luna = []; 
    handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,'Luna');
end

if isfield(handles.Velfaerdsteknologi ,'Carendo')
    datatogo = handles.Velfaerdsteknologi;
    guidata(hObject, handles);
    close(GUIValgafteknologi);
    GUITeknologioverblik(datatogo); 
else
    msgbox('Data for den valgte velfærdsteknologi eksisterer ikke');
end
%close(GUIValgafteknologi);




% --- Executes on button press in btnAfslutSystem.
function btnAfslutSystem_Callback(hObject, eventdata, handles)
% hObject    handle to btnAfslutSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%https://se.mathworks.com/help/matlab/ref/questdlg.html
spoergsmaal=sprintf('Ønsker du at afslutte programmet?');
svar=questdlg(spoergsmaal,'Afslut',...
'Ja', 'Nej', 'Nej'); %den sidste gem er default værdien
switch svar
    case 'Ja'
        close(GUIValgafteknologi);
end
