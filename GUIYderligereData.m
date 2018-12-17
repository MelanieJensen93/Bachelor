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

% Last Modified by GUIDE v2.5 12-Nov-2018 15:11:38

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
% Stammer fra: https://stackoverflow.com/questions/15286458/automatically-maximize-a-figure
set(gcf, 'WindowState', 'fullscreen');
% Stammer fra: https://se.mathworks.com/matlabcentral/answers/95732-how-can-i-cleanly-exit-from-the-openingfcn-of-a-gui-if-a-certain-condition-is-met
if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    set(gcf,'Pointer','watch');
 
    handles.Velfaerdsteknologi = varargin{1}; %henter handles fra GUIValgafteknologi
    if isempty(handles.Velfaerdsteknologi)
        msgbox('Yderligere data eksisterer ikke for den valgte teknologi'); 
    end
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
    % Kalder VisData for at plotte yderligere data 
    VarighedSuperbruger = [handles.SuperBruger.Varighedforarbejdsgang];
    VarighedAlmindelig = [handles.Almindelig.Varighedforarbejdsgang];
    DirekteTid = [handles.Velfaerdsteknologi.(handles.teknologi).Tidmedborger];
    %Idet at det er en tid så skal det skrives ud i typen duration med
    %følgende format. 
    infmt = 'mm:ss';
    VarighedSuperbruger = duration(VarighedSuperbruger,'InputFormat',infmt); 
    VarighedAlmindelig = duration(VarighedAlmindelig,'InputFormat',infmt);
    DirekteTid = duration(DirekteTid,'InputFormat',infmt);

    [~, stringDato, DataEksisterer] = VisData(handles,[handles.SuperBruger.Tidspunkt],VarighedSuperbruger,handles.axSuperBrugerYderligereData,'Yderligere');
    VisData(handles,[handles.Almindelig.Tidspunkt],VarighedAlmindelig,handles.axAlmindeligYderligereData,'Yderligere');
    VisData(handles,[handles.Velfaerdsteknologi.(handles.teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');
    stringDato.Format = 'dd-MMM-yyyy';
    stringDato = string(stringDato);
    set(handles.stDatoYderligere, 'String', stringDato);
    
    
    
    axes(handles.axSuperBrugerYderligereData)
    ylabel('Varighed i minutter')
    %title('Gennemsnitlig tid af arbejdsgang for superbruger ')
    axes(handles.axAlmindeligYderligereData)
    ylabel('Varighed i minutter')
    %title('Gennemsnitlig tid af arbejdsgang for alment personale')
    axes(handles.axDirekteTidYderligereData)
    ylabel('Varighed i minutter')
    %title('Gennemsnitlig tid med borger')
    
    if DataEksisterer == 1
        msgbox('Der er ikke data for den valgte periode');
    end
    % Update handles structure
    guidata(hObject, handles);
    set(gcf,'Pointer','arrow');
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
% Stammer fra: https://stackoverflow.com/questions/15286458/automatically-maximize-a-figure
set(gcf, 'WindowState', 'fullscreen');
% set(gcf, 'Position', get(0,'Screensize'));
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


% --- Executes on button press in btnVaelgDatoYderligereData.
function btnVaelgDatoYderligereData_Callback(hObject, eventdata, handles)
% hObject    handle to btnVaelgDatoYderligereData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
%https://se.mathworks.com/help/finance/uicalendar.html
uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.stDatoYderligere);

waitfor(handles.stDatoYderligere,'String');
% Kalder VisData for at plotte yderligere data 
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
[~,~,DataEksisterer] = VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

%Definere y-akser
axes(handles.axSuperBrugerYderligereData)
ylabel('Varighed i minutter')

axes(handles.axAlmindeligYderligereData)
ylabel('Varighed i minutter')

axes(handles.axDirekteTidYderligereData)
ylabel('Varighed i minutter')


if DataEksisterer == 1
    msgbox('Der er ikke data for den valgte periode');
end

% --- Executes when selected object is changed in btngroupRedigergrafYderligere.
function btngroupRedigergrafYderligere_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigergrafYderligere 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Kalder VisData for at plotte yderligere data 
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
[~,~,DataEksisterer]=VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],DirekteTid,handles.axDirekteTidYderligereData,'Yderligere');

% Definere y-akser 
axes(handles.axSuperBrugerYderligereData)
ylabel('Varighed i minutter')

axes(handles.axAlmindeligYderligereData)
ylabel('Varighed i minutter')

axes(handles.axDirekteTidYderligereData)
ylabel('Varighed i minutter')


if DataEksisterer == 1
    msgbox('Der er ikke data for den valgte periode');
end


% --- Executes on button press in bntTilbageYderligerData.
function bntTilbageYderligerData_Callback(hObject, eventdata, handles)
% hObject    handle to bntTilbageYderligerData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUIYderligereData_OpeningFcn(hObject, eventdata, handles, 'exit')
handles.Velfaerdsteknologi.Yderligere = []; 
handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,'Yderligere');
datatogo = handles.Velfaerdsteknologi;
GUITeknologioverblik(datatogo); 


% --- Executes on button press in btnAfslutSystem.
function btnAfslutSystem_Callback(hObject, eventdata, handles)
% hObject    handle to btnAfslutSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Spørger om de vil afslutte 
%Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
spoergsmaal=sprintf('Ønsker du at afslutte programmet: ?');
svar=questdlg(spoergsmaal,'Afslut',...
'Ja', 'Nej', 'Nej'); %den sidste gem er default værdien
switch svar
    case 'Ja'
        GUIYderligereData_OpeningFcn(hObject, eventdata, handles, 'exit');
end
