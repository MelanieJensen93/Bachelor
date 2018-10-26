function [handles,datatogo] = Bemaerkning(handles, datatogo)

Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
for ii = 1:length(handles.Velfaerdsteknologi.LunaSensor)
    if Sensornr == ii 
      Sensor = fieldnames(handles.Velfaerdsteknologi.LunaSensor)
      Sensornavn = string(Sensor(ii));
      
        if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn),'TilfoejBemearkning')
        idx=1; 
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato= get(handles.etDatoTilfoejBemaerkning,'String');
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
        else
        idx = length(handles.TB.B);
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
        end
        
    end
end


% if ~isfield(handles.Velfaerdsteknologi,'TB')
%     idx=1; 
%     handles.TB.B(idx).dato= get(handles.etDatoTilfoejBemaerkning,'String');
%     handles.TB.B(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
%     handles.TB.B(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
% else
%     idx = length(handles.TB.B);
%     handles.TB.B(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
%     handles.TB.B(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
%     handles.TB.B(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
% end 

if strcmp(getfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx),'bemaerkning'),'Andet') == 1
    handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning(idx).Bemaerkning.bemaerkning =  get(handles.etAndetTilfoejBemaerkning,'String');
end

if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn),'TB')
    if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning,'Bemaerkning')
    msgbox('Vælg venligst dato, tidspunkt og type af bemærkning');
    return 
    end
end 

if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning, 'dato')
    msgbox('Vælg venligst en dato"');
    return;
end

if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning, 'tidspunkt')
    msgbox('Vælg venligst et tidspunkt');
    return;
end

if ~isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning, 'bemaerkning')
    msgbox('Vælg venligst en bemærkning');
    return;
end

if isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning,'Bemaerkning')
    % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
    spoergsmaal=sprintf('Ønsker du at tilføje bemærkningen: %s %s %s ?',...
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato,...
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
    svar=questdlg(spoergsmaal,'Tilføj bemærkning',...
        'Gem', 'Annuller', 'Gem'); %den sidste gem er default værdien
    switch svar
        case 'Gem'
            disp([svar ' gemt'])
            datatogo = handles.Velfaerdsteknologi;
            GUISensordataoverblik(datatogo);
            close(GUITilfoejBemaerkning);
        case 'Annuller'
            disp([svar ' annulleret'])
             
    end 
end

%idx=1;
udskrift= sprintf("%s %s %s"+handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
    handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato,...
    handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
str_part = udskrift; 
old_str = get(handles.lbBemaerkning,'String'); 
new_str=strvcat(char(old_str),char(str_part));
set(handles.lbBemaerkning,'String',new_str);
set(handles.lbBemaerkning, 'Value', idx+1);
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
   
 





