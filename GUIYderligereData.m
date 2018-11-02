function varargout = GUIYderligereData(varargin)
% GUIYDERLIGEREDATA MATLAB code for GUIYderligereData.fig
%      GUIYDERLIGEREDATA, by itself, creates a new GUIYDERLIGEREDATA or raises the existing
%      singleton*.
%
%      H = GUIYDERLIGEREDATA returns the handle to a new GUIYDERLIGEREDATA or the handle to
%      the existing singleton*.
%
%      GUIYDERLIGEREDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIYDERLIGEREDATA.M with the given input arguments.
%
%      GUIYDERLIGEREDATA('Property','Value',...) creates a new GUIYDERLIGEREDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIYderligereData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIYderligereData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIYderligereData

% Last Modified by GUIDE v2.5 02-Nov-2018 08:56:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIYderligereData_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIYderligereData_OutputFcn, ...
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


% --- Executes just before GUIYderligereData is made visible.
function GUIYderligereData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIYderligereData (see VARARGIN)

% Choose default command line output for GUIYderligereData
handles.output = hObject;
handles.Velfaerdsteknologi = varargin{1}; %henter handles fra GUIValgafteknologi
% Update handles structure
guidata(hObject, handles);
handles = YderligereData(handles);
guidata(hObject,handles);
d=1;
teknologi = fieldnames(handles.Velfaerdsteknologi);
handles.teknologi = string(teknologi);
d=1;
    if strcmp(handles.teknologi,'Carendo')==1
       set(handles.txtLunaMedCarendoYderligere, 'Visible', 'off');
    end
    if strcmp(teknologi,'Luna')==1
        set(handles.txtVariabel, 'String', 'Anvendelse af Luna med Carendo'); 
        set(handles.txtStringKomfort, 'Visible', 'off');
        set(handles.txtStringHaeveSaenke, 'Visible', 'off');
        set(handles.txtOmsorgsfunktionYderligere, 'Visible', 'off');
        set(handles.txtKomfortfunktionYderligere, 'Visible', 'off');
        set(handles.txtHaeveSaenkefunktionYderligere, 'Visible', 'off');
    end

% UIWAIT makes GUIYderligereData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIYderligereData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnVaelgDatoYderligereData.
function btnVaelgDatoYderligereData_Callback(hObject, eventdata, handles)
% hObject    handle to btnVaelgDatoYderligereData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.stDatoYderligere);

waitfor(handles.stDatoYderligere,'String');
d=1;
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
DirekteTid = [handles.Velfaerdsteknologi.(teknologi).Tidmedborger];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt);
DirekteTid = duration(DirekteTid,'InputFormat',infmt);

handles = SortereTid(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
handles = SortereTid(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

% --- Executes when selected object is changed in btngroupRedigergrafYderligere.
function btngroupRedigergrafYderligere_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigergrafYderligere 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
DirekteTid = [handles.Velfaerdsteknologi.(teknologi).Tidmedborger];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt); 
handles = SortereTid(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
handles = SortereTid(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
handles = SortereTid(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');
