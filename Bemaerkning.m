function handles = Bemaerkning(handles)

if ~isfield(handles,'TB')
    idx=1; 
    handles.TB.B(idx).dato= get(handles.etDatoTilfoejBemaerkning,'String');
    handles.TB.B(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
    handles.TB.B(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
    d=1; 
else
    idx = length(handles.TB.B);
    handles.TB.B(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
    handles.TB.B(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
    handles.TB.B(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
    d=1; 
end 
d=1; 



% if ~isfield(handles.TB.B(idx) ,'dato')
%     handles.TB.B(idx).dato= get(handles.etDatoTilfoejBemaerkning,'String');
% else 
%     handles.TB.B(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
% end
% 
% if ~isfield(handles.TB.B(idx),'tidspunkt')
%     handles.TB.B(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
% else 
%     handles.TB.B(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
% end
% 
% if ~isfield(handles.TB.B(idx),'tidspunkt')
%     handles.TB.B(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
% else 
%     handles.TB.B(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
% end
% 
% if ~isfield(handles.TB.B(idx),'bemaerkning')
%     handles.TB.B(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
% else
%     handles.TB.B(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
% end

if strcmp(getfield(handles.TB.B(idx),'bemaerkning'),'Andet') == 1
    handles.TB(idx).B.bemaerkning =  get(handles.etAndetTilfoejBemaerkning,'String');
end

if ~isfield(handles,'TB')
    if ~isfield(handles,'B')
    msgbox('Du mangler alt');
    return 
    end
end 

if ~isfield(handles.TB.B, 'dato')
    msgbox('Vælg venligst en dato"');
    return;
end

if ~isfield(handles.TB.B, 'tidspunkt')
    msgbox('Vælg venligst et tidspunkt!"');
    return;
end

if ~isfield(handles.TB.B, 'bemaerkning')
    msgbox('Vælg venligst en bemærkning!"');
    return;
end

if isfield(handles.TB,'B')
    msgbox(sprintf('Vil du tilføje: %s %s %s ?',handles.TB.B(idx).bemaerkning, handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt));
    return;
end
   
d=1; 

%close(GUITilfoejBemaerkning)
GUISensordataoverblik;


a= sprintf("%s %s %s"+handles.TB.B(idx).bemaerkning,handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt);
str_part = a; 
old_str = get(handles.lbBemaerkning,'String'); 
new_str=strvcat(old_str,str_part);
set(handles.lbBemaerkning,'String',new_str)

