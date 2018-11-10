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

% Last Modified by GUIDE v2.5 10-Nov-2018 10:25:16

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

AarhusKommuneLogo = imread('AarhusKommuneLogo.jpg');
axes(handles.axAarhusLogo);
imshow(AarhusKommuneLogo);

handles.TeknologiOverblik = varargin{1};
handles.teknologi = fieldnames(handles.TeknologiOverblik);
%guidata(hObject, handles);
% Update handles structure
guidata(hObject, handles);

handles = IndlaesVelfaerdsteknologi(handles, 'Plejecentre');
guidata(hObject,handles);

teknologi = string(handles.teknologi);
D = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
D = duration(D,'InputFormat',infmt); 
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],handles.axMedarbejderePlejecentre,'Plejecentre');
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],D,handles.axVarighedPlejecentre,'Plejecentre');

axes(handles.axMedarbejderePlejecentre)
ylabel('Antal medarbejdere')
axes(handles.axVarighedPlejecentre)
ylabel('Varighed i minutter')
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
set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1])


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
D = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
D = duration(D,'InputFormat',infmt); 

VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],handles.axMedarbejderePlejecentre,'Plejecentre');
hold on 
VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],[handles.TeknologiOverblik.(teknologi).Medarbejdere],handles.axMedarbejderePlejecentre,'Plejecentre');

VisData(handles,[handles.TeknologiOverblik.(teknologi).Tidspunkt],D,handles.axVarighedPlejecentre,'Plejecentre');


axes(handles.axMedarbejderePlejecentre)
ylabel('Antal medarbejdere')
axes(handles.axVarighedPlejecentre)
ylabel('Varighed i minutter')

% --- Executes when selected object is changed in btngroupRedigergrafPlejecentre.
function btngroupRedigergrafPlejecentre_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigergrafPlejecentre 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
teknologi = string(handles.teknologi);
D = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
D = duration(D,'InputFormat',infmt); 
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],[handles.Velfaerdsteknologi.(teknologi).Medarbejdere],handles.axMedarbejderePlejecentre,'Plejecentre');
VisData(handles,[handles.Velfaerdsteknologi.(teknologi).Tidspunkt],D,handles.axVarighedPlejecentre,'Plejecentre');

axes(handles.axMedarbejderePlejecentre)
ylabel('Antal medarbejdere')
axes(handles.axVarighedPlejecentre)
ylabel('Varighed i minutter')


% --- Executes on button press in btnTilbageSammenlignmedandreplejecentre.
function btnTilbageSammenlignmedandreplejecentre_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbageSammenlignmedandreplejecentre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when btngroupRedigergrafPlejecentre is resized.
function btngroupRedigergrafPlejecentre_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to btngroupRedigergrafPlejecentre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
