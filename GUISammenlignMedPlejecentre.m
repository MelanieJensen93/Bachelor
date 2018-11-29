function varargout = GUISammenlignMedPlejecentre(varargin)
% GUISAMMENLIGNMEDPLEJECENTRE MATLAB code for GUISammenlignMedPlejecentre.fig
%      GUISAMMENLIGNMEDPLEJECENTRE, by itself, creates a new GUISAMMENLIGNMEDPLEJECENTRE or raises the existing
%      singleton*.
%
%      H = GUISAMMENLIGNMEDPLEJECENTRE returns the handle to a new GUISAMMENLIGNMEDPLEJECENTRE or the handle to
%      the existing singleton*.
%
%      GUISAMMENLIGNMEDPLEJECENTRE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUISAMMENLIGNMEDPLEJECENTRE.M with the given input arguments.
%
%      GUISAMMENLIGNMEDPLEJECENTRE('Property','Value',...) creates a new GUISAMMENLIGNMEDPLEJECENTRE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUISammenlignMedPlejecentre_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUISammenlignMedPlejecentre_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUISammenlignMedPlejecentre

% Last Modified by GUIDE v2.5 12-Nov-2018 19:11:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUISammenlignMedPlejecentre_OpeningFcn, ...
                   'gui_OutputFcn',  @GUISammenlignMedPlejecentre_OutputFcn, ...
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


% --- Executes just before GUISammenlignMedPlejecentre is made visible.
function GUISammenlignMedPlejecentre_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUISammenlignMedPlejecentre (see VARARGIN)

% Choose default command line output for GUISammenlignMedPlejecentre
handles.output = hObject;
set(gcf, 'WindowState', 'fullscreen');
if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
    axes(handles.axAarhusLogo);
    imshow(AarhusKommuneLogo);

    handles.TeknologiOverblik = varargin{1};
    handles.teknologi = fieldnames(handles.TeknologiOverblik);
    %guidata(hObject, handles);
    set(handles.txtValgtTeknologiSammenlignmedandreplejecentre, 'String',handles.teknologi)
    % Update handles structure
    
    guidata(hObject, handles);

    handles = IndlaesVelfaerdsteknologi(handles, 'Plejecentre');
    guidata(hObject,handles);

    teknologi = string(handles.teknologi);
    if handles.TeknologiOverblik.(teknologi)(1).Tidspunkt<handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt
        handles.StringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
    else 
        handles.StringDato = handles.TeknologiOverblik.(teknologi)(1).Tidspunkt;
    end
    
    VarighedPlejecenter = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
    VarighedTeknologi = [handles.TeknologiOverblik.(teknologi).Varighedforarbejdsgang];
    %Idet at det er en tid så skal det skrives ud i typen duration med
    %følgende format. 
    infmt = 'mm:ss';
    VarighedPlejecenter = duration(VarighedPlejecenter,'InputFormat',infmt); 
    VarighedTeknologi = duration(VarighedTeknologi,'InputFormat',infmt); 
    axMedarbejdere = handles.axMedarbejderePlejecentre;
    VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre');
    hold on 
    VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],[handles.TeknologiOverblik.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre',1);
    hold off 
    axes(handles.axMedarbejderePlejecentre)
    ylabel('Antal medarbejdere')
    title('Gennemsnittet af antal medarbejdere ved en arbejdsgang')
    legend('Ensøgård','Havkær');

    [~,~,DataEksisterer2]=VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],VarighedPlejecenter,handles.axVarighedPlejecentre,'Plejecentre');
    hold on 
    [~,slutDato,DataEksisterer1]=VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],VarighedTeknologi,handles.axVarighedPlejecentre,'Plejecentre',1);
    hold off 
    axes(handles.axVarighedPlejecentre)
    ylabel('Varighed i minutter')
    title('Gennemsnittet af hvor lang tid en arbejdsgang tager')
    legend('Ensøgård','Havkær');
    
    stringDato = string(slutDato);
    set(handles.stDatoPlejecentre, 'String', stringDato)
    
    if DataEksisterer1 == 1 && DataEksisterer2 ==2 
        msgbox('Der er ikke data for den valgte periode');
    end
    
end
% UIWAIT makes GUISammenlignMedPlejecentre wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUISammenlignMedPlejecentre_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(gcf, 'WindowState', 'fullscreen');
% set(gcf, 'Position', get(0,'Screensize'));
% set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1])


% --- Executes on button press in btnVaelgDatoPlejecentre.
function btnVaelgDatoPlejecentre_Callback(hObject, eventdata, handles)
% hObject    handle to btnVaelgDatoPlejecentre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.stDatoPlejecentre);

waitfor(handles.stDatoPlejecentre,'String');

teknologi = string(handles.teknologi);
VarighedPlejecenter = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
VarighedTeknologi = [handles.TeknologiOverblik.(teknologi).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedPlejecenter = duration(VarighedPlejecenter,'InputFormat',infmt); 
VarighedTeknologi = duration(VarighedTeknologi,'InputFormat',infmt);

axMedarbejdere = handles.axMedarbejderePlejecentre;
[~,~,DataEksisterer2]=VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre');
hold on 
[~,~,DataEksisterer1]=VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],[handles.TeknologiOverblik.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre',1);
hold off 
axes(handles.axMedarbejderePlejecentre)
ylabel('Antal medarbejdere')
title('Gennemsnittet af antal medarbejdere ved en arbejdsgang')
legend('Ensøgård','Havkær');

VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],VarighedPlejecenter,handles.axVarighedPlejecentre,'Plejecentre');
hold on 
VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],VarighedTeknologi,handles.axVarighedPlejecentre,'Plejecentre',1);
hold off 
axes(handles.axVarighedPlejecentre)
ylabel('Varighed i minutter')
title('Gennemsnittet af hvor lang tid en arbejdsgang tager')
legend('Ensøgård','Havkær');

if DataEksisterer1 == 1 && DataEksisterer2==1
   msgbox('Der er ikke data for den valgte periode');
end

% --- Executes when selected object is changed in btngroupRedigergrafPlejecentre.
function btngroupRedigergrafPlejecentre_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigergrafPlejecentre 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teknologi = string(handles.teknologi);
VarighedPlejecenter = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
VarighedTeknologi = [handles.TeknologiOverblik.(teknologi).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
VarighedPlejecenter = duration(VarighedPlejecenter,'InputFormat',infmt); 
VarighedTeknologi = duration(VarighedTeknologi,'InputFormat',infmt);
axMedarbejdere = handles.axMedarbejderePlejecentre;
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre');
hold on 
VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],[handles.TeknologiOverblik.(teknologi).Medarbejdere],axMedarbejdere,'Plejecentre',1);
hold off 
axes(handles.axMedarbejderePlejecentre)
ylabel('Antal medarbejdere')
title('Gennemsnittet af antal medarbejdere ved en arbejdsgang')
legend('Ensøgård','Havkær');
[~,~,DataEksisterer2]=VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],VarighedPlejecenter,handles.axVarighedPlejecentre,'Plejecentre');
hold on 
[~,~,DataEksisterer1]=VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],VarighedTeknologi,handles.axVarighedPlejecentre,'Plejecentre',1);
hold off 
axes(handles.axVarighedPlejecentre)
ylabel('Varighed i minutter')
title('Gennemsnittet af hvor lang tid en arbejdsgang tager')
legend('Ensøgård','Havkær');
if DataEksisterer1 == 1 && DataEksisterer2 == 1
   msgbox('Der er ikke data for den valgte periode');
end

% --- Executes on button press in btnTilbageSammenlignmedandreplejecentre.
function btnTilbageSammenlignmedandreplejecentre_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbageSammenlignmedandreplejecentre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUISammenlignMedPlejecentre_OpeningFcn(hObject, eventdata, handles, 'exit');
 % --- Executes when user attempts to close GUISensorDataOverbliksVindue.
handles.TilbageKnap = 'Plejecentre'; 
GUITeknologioverblik(handles.TeknologiOverblik); 

% --- Executes when btngroupRedigergrafPlejecentre is resized.
function btngroupRedigergrafPlejecentre_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to btngroupRedigergrafPlejecentre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnAfslutSystem.
function btnAfslutSystem_Callback(hObject, eventdata, handles)
% hObject    handle to btnAfslutSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spoergsmaal=sprintf('Ønsker du at afslutte programmet?');
svar=questdlg(spoergsmaal,'Afslut',...
'Ja', 'Nej', 'Nej'); %den sidste gem er default værdien
switch svar
    case 'Ja'
        GUISammenlignMedPlejecentre_OpeningFcn(hObject, eventdata, handles, 'exit');
end
