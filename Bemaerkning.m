function [handles,datatogo] = Bemaerkning(handles, datatogo)

%GUITilfoejBemaerkning(datatogo)
%Henter alle filnavne i handles.Velfaerdsteknologi, første kolonne
%indeholder den valgte teknologi og derfor udvælges denne. 
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

Antalfravalgtdato = 0;

if isfield(handles.Velfaerdsteknologi,'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    Valuefromlistbox = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
   
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
              handles.Velfaerdsteknologi.ValgtTidspunkt = get(handles.etDatoTilfoejBemaerkning, 'String');
              tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
              tidspunkt.Format = 'dd-MMM-yyyy';
              tidspunkt = string(tidspunkt);
            if handles.Velfaerdsteknologi.ValgtTidspunkt == tidspunkt 
                  Antalfravalgtdato = Antalfravalgtdato+1;
                  if Antalfravalgtdato == Valuefromlistbox
%                       bemaerkningsFil = fopen('bemarkningsFil.txt', 'r');
%                       format = '%s %s %s %s\n';
%                       datafraBemaerkningsfil = textscan(bemaerkningsFil, 'string');
%                       fclose(bemaerkningsFil);
                        bF = importdata('bemarkningsFil.txt');
                        
                      
                      tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                    if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning')
                        idx=1; 
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt= get(handles.txtValgtTidspunkt,'String');
                        %handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(1).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                    else
                        idx = length(handles.Velfaerdsteknologi.(teknologi)(ii).(Sensornavn).TilfoejBemaerkning.Bemaerkning);
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx+1).dato = get(handles.etDatoTilfoejBemaerkning,'String');
                        %handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx+1).tidspunkt = get(get(handles.bgTidspunktTilfoejBemaerkning,'SelectedObject'),'String');
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx+1).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                        idx = idx+1;
                    end
                  end
            end
          end
          
       end
    end
       

    
else
    msgbox('Vælg venligst en dato.');
end

%Henter kommentar fra andet feltet
if strcmp(getfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx),'bemaerkning'),'Andet') == 1
    handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning(idx).Bemaerkning.bemaerkning =  get(handles.etAndetTilfoejBemaerkning,'String');
end

if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning')
    if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning,'Bemaerkning')
    msgbox('Vælg venligst dato, tidspunkt og type af bemærkning');
    return 
    end
end 


% if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn).TilfoejBemaerkning.Bemaerkning, 'bemaerkning')
%     msgbox('Vælg venligst en bemærkning');
%     return;
% end

if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning,'Bemaerkning')
    % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
    spoergsmaal=sprintf('Ønsker du at tilføje bemærkningen: %s %s ?',...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
    svar=questdlg(spoergsmaal,'Tilføj bemærkning',...
        'Gem', 'Annuller', 'Gem'); %den sidste gem er default værdien
    switch svar
        case 'Gem'
            disp([svar ' gemt'])
            GemBemaerkningiFil(handles);
            datatogo = handles.Velfaerdsteknologi;
            GUISensordataoverblik(datatogo);
            %close(GUITilfoejBemaerkning);
            d=1;
        case 'Annuller'
            disp([svar ' annulleret'])
             
    end 
end

%OpdaterListboxmedBemaerkning(handles);


   
 





