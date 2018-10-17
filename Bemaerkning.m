function [handles,datatogo] = Bemaerkning(handles)

GUITilfoejBemaerkning(handles);

if ~isfield(handles,'TB')
    idx=1; 
    handles.TB.B(idx).dato= get(handles.etDatoTilfoejBemaerkning,'String');
    handles.TB.B(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
    handles.TB.B(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
else
    idx = length(handles.TB.B);
    handles.TB.B(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
    handles.TB.B(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
    handles.TB.B(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
end 

if strcmp(getfield(handles.TB.B(idx),'bemaerkning'),'Andet') == 1
    handles.TB(idx).B.bemaerkning =  get(handles.etAndetTilfoejBemaerkning,'String');
end

if ~isfield(handles,'TB')
    if ~isfield(handles,'B')
    msgbox('Vælg venligst dato, tidspunkt og type af bemærkning');
    return 
    end
end 

if ~isfield(handles.TB.B, 'dato')
    msgbox('Vælg venligst en dato"');
    return;
end

if ~isfield(handles.TB.B, 'tidspunkt')
    msgbox('Vælg venligst et tidspunkt');
    return;
end

if ~isfield(handles.TB.B, 'bemaerkning')
    msgbox('Vælg venligst en bemærkning');
    return;
end

if isfield(handles.TB,'B')
    % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
    spoergsmaal=sprintf('Ønsker du at tilgøje bemærkningen: %s %s %s ?',handles.TB.B(idx).bemaerkning, handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt);
    svar=questdlg(spoergsmaal,'Tilføj bemærkning',...
        'Gem', 'Annuller', 'Gem'); %den sidste gem er default værdien
    switch svar
        case 'Gem'
            disp([svar ' gemt'])
            datatogo = handles.TB;
            GUISensordataoverblik(datatogo);
            close(GUITilfoejBemaerkning);
        case 'Annuller'
            disp([svar ' annulleret'])
             
    end 
end

%OpdaterListboxmedBemaerkning(handles);

bemarkningsFil = fopen('bemarkningsFil.txt','w');
for i = 1:length(handles.TB)
    % strjoin: for at vi kan få værdien ud fra cellen: celleværdien
    % laves om til en string
    %str1 = strjoin(handles.TB.B.dato);
    %str2 = strjoin(handles.TB.B.tidspunkt);
    %str3 = strjoin(handles.TB.B.bemaerkning);    
    
    fprintf(bemarkningsFil, '%s %s %s', handles.TB.B.dato, handles.TB.B.tidspunkt, handles.TB.B.bemaerkning);
end

fclose(bemarkningsFil);
   
 





