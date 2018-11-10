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

% Last Modified by GUIDE v2.5 09-Nov-2018 16:35:31

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

if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    handles.Velfaerdsteknologi = varargin{1}; %henter handles fra GUIValgafteknologi
    handles = YderligereData(handles);
    guidata(hObject,handles);
    
    AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
    axes(handles.axAarhusLogo);
    imshow(AarhusKommuneLogo);

    teknologi = fieldnames(handles.Velfaerdsteknologi);
    handles.teknologi = string(teknologi);

        if strcmp(handles.teknologi,'Carendo')==1
           set(handles.txtLunaMedCarendoYderligere, 'Visible', 'off');
           set(handles.txtValgtTeknologiYderligereData, 'String', 'Carendo');
        end
        if strcmp(teknologi,'Luna')==1
            set(handles.txtVariabel, 'String', 'Anvendelse af Luna med Carendo'); 
            set(handles.txtStringKomfort, 'Visible', 'off');
            set(handles.txtStringHaeveSaenke, 'Visible', 'off');
            set(handles.txtOmsorgsfunktionYderligere, 'Visible', 'off');
            set(handles.txtKomfortfunktionYderligere, 'Visible', 'off');
            set(handles.txtHaeveSaenkefunktionYderligere, 'Visible', 'off');
            set(handles.txtValgtTeknologiYderligereData, 'String', 'Luna loftlift');
        end
    
    handles.Velfaerdsteknologi.Yderligere.Dato = handles.Velfaerdsteknologi.(handles.teknologi)(1).Tidspunkt;
    guidata(hObject,handles);
    VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
    VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
    DirekteTid = [handles.Velfaerdsteknologi.(handles.teknologi).Tidmedborger];
    %Idet at det er en tid så skal det skrives ud i typen duration med
    %følgende format. 
    infmt = 'mm:ss';
    VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
    VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt);
    DirekteTid = duration(DirekteTid,'InputFormat',infmt);

    VisData(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
    VisData(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
    VisData(handles,[handles.Velfaerdsteknologi.(handles.teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

    axes(handles.axSuperBrugerYderligereData)
    ylabel('Varighed i minutter')
    axes(handles.axAlmindeligYderligereData)
    ylabel('Varighed i minutter')
    axes(handles.axDirekteTidYderligereData)
    ylabel('Varighed i minutter')
    
    % Update handles structure
    guidata(hObject, handles);
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
set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


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
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi(1));
VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
DirekteTid = [handles.Velfaerdsteknologi.(teknologi).Tidmedborger];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt);
DirekteTid = duration(DirekteTid,'InputFormat',infmt);

VisData(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
VisData(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

axes(handles.axSuperBrugerYderligereData)
ylabel('Varighed i minutter')
axes(handles.axAlmindeligYderligereData)
ylabel('Varighed i minutter')
axes(handles.axDirekteTidYderligereData)
ylabel('Varighed i minutter')

% --- Executes when selected object is changed in btngroupRedigergrafYderligere.
function btngroupRedigergrafYderligere_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigergrafYderligere 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi(1));
VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
DirekteTid = [handles.Velfaerdsteknologi.(teknologi).Tidmedborger];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt); 
DirekteTid = duration(DirekteTid,'InputFormat',infmt); 
VisData(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
VisData(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

axes(handles.axSuperBrugerYderligereData)
ylabel('Varighed i minutter')
axes(handles.axAlmindeligYderligereData)
ylabel('Varighed i minutter')
axes(handles.axDirekteTidYderligereData)
ylabel('Varighed i minutter')


% --- Executes on button press in bntTilbageYderligerData.
function bntTilbageYderligerData_Callback(hObject, eventdata, handles)
% hObject    handle to bntTilbageYderligerData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUIYderligereData_OpeningFcn(hObject, eventdata, handles, 'exit')
GUITeknologioverblik(handles); 
