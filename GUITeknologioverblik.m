function varargout = GUITeknologioverblik(varargin)
% GUITEKNOLOGIOVERBLIK MATLAB code for GUITeknologioverblik.fig
%      GUITEKNOLOGIOVERBLIK, by itself, creates a new GUITEKNOLOGIOVERBLIK or raises the existing
%      singleton*.
%
%      H = GUITEKNOLOGIOVERBLIK returns the handle to a new GUITEKNOLOGIOVERBLIK or the handle to
%      the existing singleton*.
%
%      GUITEKNOLOGIOVERBLIK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEKNOLOGIOVERBLIK.M with the given input arguments.
%
%      GUITEKNOLOGIOVERBLIK('Property','Value',...) creates a new GUITEKNOLOGIOVERBLIK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUITeknologioverblik_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUITeknologioverblik_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUITeknologioverblik

% Last Modified by GUIDE v2.5 22-Oct-2018 09:11:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUITeknologioverblik_OpeningFcn, ...
                   'gui_OutputFcn',  @GUITeknologioverblik_OutputFcn, ...
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


% --- Executes just before GUITeknologioverblik is made visible.
function GUITeknologioverblik_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUITeknologioverblik (see VARARGIN)

% Choose default command line output for GUITeknologioverblik
handles.output = hObject;
handles.Velfaerdsteknologi = varargin{1}; %henter handles fra GUIValgafteknologi


% Update handles structure
guidata(hObject, handles);
%handles = SortereTid(handles);
teknologi = fieldnames(handles.Velfaerdsteknologi);
d=1; 
teknologi = string(teknologi);

set(handles.txtValgtteknologiOverblik,'String',teknologi); 
set(handles.txtAntalGangeTeknologioverblik,'String',num2str(handles.Velfaerdsteknologi.(teknologi)(1).Medarbejdere))
 



% UIWAIT makes GUITeknologioverblik wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUITeknologioverblik_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'Units', 'normal', 'Position', [0 0 1 1])
%set(gcf, 'Toolbar', 'none', 'Menu', 'none');


% --- Executes on button press in btnTilbage.
function btnTilbage_Callback(hObject, eventdata, handles)
% hObject    handle to btnTilbage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnListoversensorerTeknologioverblik.
function btnListoversensorerTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnListoversensorerTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d=1; 

datatogo = handles.Velfaerdsteknologi;
GUISensorliste(datatogo);
close(GUITeknologioverblik);


% --- Executes on button press in btnYderligeredataTeknologioverblik.
function btnYderligeredataTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnYderligeredataTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnBrugermanualTeknologioverblik.
function btnBrugermanualTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrugermanualTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnSammenlignmedandreplejecentreTeknologioverblik.
function btnSammenlignmedandreplejecentreTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnSammenlignmedandreplejecentreTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnVaelgDatoTeknologioverblik.
function btnVaelgDatoTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to btnVaelgDatoTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uicalendar('Weekend',[1 0 0 0 0 0 1], ...  
'SelectionType', 1, ...  
'DestinationUI', handles.stDatoTeknologiOverblik);


% --- Executes when selected object is changed in btngroupRedigerGrafTeknologioverblik.
function btngroupRedigerGrafTeknologioverblik_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btngroupRedigerGrafTeknologioverblik 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = SortereTid(handles);
d=1; 

% --- Executes on button press in rbAarTeknologioverblik.
function rbAarTeknologioverblik_Callback(hObject, eventdata, handles)
% hObject    handle to rbAarTeknologioverblik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbAarTeknologioverblik
