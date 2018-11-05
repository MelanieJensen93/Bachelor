function varargout = GUIDatafravalgtdato(varargin)
% GUIDATAFRAVALGTDATO MATLAB code for GUIDatafravalgtdato.fig
%      GUIDATAFRAVALGTDATO, by itself, creates a new GUIDATAFRAVALGTDATO or raises the existing
%      singleton*.
%
%      H = GUIDATAFRAVALGTDATO returns the handle to a new GUIDATAFRAVALGTDATO or the handle to
%      the existing singleton*.
%
%      GUIDATAFRAVALGTDATO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDATAFRAVALGTDATO.M with the given input arguments.
%
%      GUIDATAFRAVALGTDATO('Property','Value',...) creates a new GUIDATAFRAVALGTDATO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIDatafravalgtdato_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIDatafravalgtdato_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIDatafravalgtdato

% Last Modified by GUIDE v2.5 28-Oct-2018 16:36:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIDatafravalgtdato_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIDatafravalgtdato_OutputFcn, ...
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


% --- Executes just before GUIDatafravalgtdato is made visible.
function GUIDatafravalgtdato_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIDatafravalgtdato (see VARARGIN)

% Choose default command line output for GUIDatafravalgtdato
handles.output = hObject;

if ~isempty(varargin) && ischar(varargin{1}) && strcmp(varargin{1},'exit')
    close;
else
    handles.Velfaerdsteknologi = varargin{1};
    guidata(hObject, handles);
end

% Update handles structure
%guidata(hObject, handles);

% UIWAIT makes GUIDatafravalgtdato wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIDatafravalgtdato_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.lbDataforvalgtdag;


% --- Executes on selection change in lbDataforvalgtdag.
function lbDataforvalgtdag_Callback(hObject, eventdata, handles)
% hObject    handle to lbDataforvalgtdag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbDataforvalgtdag contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbDataforvalgtdag

handles.Velfaerdsteknologi.ValgtTidspunktPaaDato = get(hObject, 'value');
datatogo = handles.Velfaerdsteknologi;
guidata(hObject, handles);
% GUITilfoejBemaerkning(datatogo)
%close(GUIDatafravalgtdato);
GUIDatafravalgtdato_OpeningFcn(hObject, eventdata, handles, 'exit');
GUITilfoejBemaerkning(datatogo)

% --- Executes during object creation, after setting all properties.
function lbDataforvalgtdag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbDataforvalgtdag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
