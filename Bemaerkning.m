function [handles,datatogo] = Bemaerkning(handles, datatogo)

%GUITilfoejBemaerkning(datatogo)
%Henter alle filnavne i handles.Velfaerdsteknologi, første kolonne
%indeholder den valgte teknologi og derfor udvælges denne. 
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

if isfield(handles.Velfaerdsteknologi,'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    ValgtTidspunkt = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
   
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
            if ValgtTidspunkt == ii
                if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning')
                    idx=1; 
                    handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(1).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt= get(handles.txtValgtTidspunkt,'String');
                    %handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(1).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
                    handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(1).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                else
                    idx = length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning);
                    handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
                    %handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
                    handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                    idx = idx+1;
                end
            end
          end
        end
       
    end
    
else
    msgbox('Vælg venligst en dato.');
end

%Henter kommentar fra andet feltet
% if strcmp(getfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx),'bemaerkning'),'Andet') == 1
%     handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning(idx).Bemaerkning.bemaerkning =  get(handles.etAndetTilfoejBemaerkning,'String');
% end

if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning')
    if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning,'Bemaerkning')
    msgbox('Vælg venligst dato, tidspunkt og type af bemærkning');
    return 
    end
end 


% if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning, 'bemaerkning')
%     msgbox('Vælg venligst en bemærkning');
%     return;
% end

if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning,'Bemaerkning')
    % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
    spoergsmaal=sprintf('Ønsker du at tilføje bemærkningen: %s %s ?',...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
    svar=questdlg(spoergsmaal,'Tilføj bemærkning',...
        'Gem', 'Annuller', 'Gem'); %den sidste gem er default værdien
    switch svar
        case 'Gem'
            disp([svar ' gemt'])
            datatogo = handles.Velfaerdsteknologi;
            GUISensordataoverblik(datatogo)
            %close(GUITilfoejBemaerkning);
            d=1;
        case 'Annuller'
            disp([svar ' annulleret'])
             
    end 
end

%idx=1;
% udskrift= sprintf("%s %s %s"+handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
%     handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato,...
%     handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
% str_part = udskrift; 
% old_str = get(handles.lbBemaerkning,'String'); 
% new_str=strvcat(char(old_str),char(str_part));
% set(handles.lbBemaerkning,'String',new_str);
% set(handles.lbBemaerkning, 'Value', idx+1);
%OpdaterListboxmedBemaerkning(handles);

% A står for Append, og stemmer fra linket her
% https://se.mathworks.com/help/symbolic/mupad_ref/fopen.html
bemarkningsFil = fopen('bemarkningsFil.txt', 'A');
for i = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning)  
    
    fprintf(bemarkningsFil, '%s %s %s \n',...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato,...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt,...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning);
end

fclose(bemarkningsFil);
   
 





