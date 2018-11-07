function handles = OpdaterListboxmedBemaerkning(handles, datatogo)
%OPDATERLISTBOXMEDBEMAERKNING Summary of this function goes here
%   Detailed explanation goes here

% gemtDataBemaerkningsfil = load(fullfile('C:\Users\Bruger\Documents\Sundhedsteknologi\7. Semester\Bachelor\MatLab',...
%     'BemaerkningsFil.mat'));
% 
% handles.Velfaerdsteknologi = gemtDataBemaerkningsfil.Velfaerdsteknologi;

handles.lbBemaerkning.String = [];
%set(handles.lbBemaerkning, 'Value',[]);
drawnow;       

DatafraBemaerkningsFil = readtable('BemaerkningsFil.xlsx');
handles.Velfaerdsteknologi.BemaerkningsFilLaengde = height(DatafraBemaerkningsFil);

teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

if isfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
     for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
            if Sensornr == i 
              Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
              Sensornavn = string(Sensor(i));
              for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
                  
                  tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                  
                  for iii = 1:height(DatafraBemaerkningsFil)
                    if teknologi == DatafraBemaerkningsFil.Teknologi(iii)
                        if Sensornavn == DatafraBemaerkningsFil.Sensornavn(iii)
                            if tidspunkt == DatafraBemaerkningsFil.DatoOgTidspunkt(iii)

                                if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning') || isempty(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning)
                                        idx=1; 
                                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt= DatafraBemaerkningsFil.DatoOgTidspunkt(iii);
                                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = DatafraBemaerkningsFil.Bemaerkning(iii);
                                    else
                                        idx = length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning);
                                        idx = idx+1;
                                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt = DatafraBemaerkningsFil.DatoOgTidspunkt(iii);
                                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = DatafraBemaerkningsFil.Bemaerkning(iii);
                                        
                                end
                                
                                 if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii), 'TilfoejBemaerkning')
                                    %handles.lbBemaerkning.String = []; 
                                    for iiii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning)
                                     %Pr�allokere et categorical array med tidspunkterp�dagen
                                      TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
                                      %Tiden bliver placeret indenfor de bestemte intervaller. 
                                        if hour(tidspunkt)>=5 && hour(tidspunkt)< 9
                                            TidspunktPaaDagen_Data=TidspunktPaaDagen(1);
                                        elseif hour(tidspunkt)>=9 && hour(tidspunkt)<11
                                                TidspunktPaaDagen_Data= TidspunktPaaDagen(2);
                                        elseif hour(tidspunkt)>=11 && hour(tidspunkt)<14
                                                TidspunktPaaDagen_Data= TidspunktPaaDagen(3);
                                        elseif hour(tidspunkt)>=14 && hour(tidspunkt)<17
                                                TidspunktPaaDagen_Data= TidspunktPaaDagen(4);
                                        elseif hour(tidspunkt)>=17 && hour(tidspunkt)<23 
                                                TidspunktPaaDagen_Data= TidspunktPaaDagen(5);
                                        else 
                                                TidspunktPaaDagen_Data= TidspunktPaaDagen(6);
                                        end
                                        tidspunktKunDato = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                                        tidspunktKunDato.Format = 'dd-MMM-yyyy';
                                        tidspunktKunDato = string(tidspunktKunDato);
                                        udskrift= sprintf("%s %s %s %s", Sensornavn, tidspunktKunDato, TidspunktPaaDagen_Data, ...
                                            string(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(iiii).bemaerkning));
                                        str_part = udskrift; 
                                        old_str = get(handles.lbBemaerkning,'String'); 
                                        new_str=strvcat(char(old_str),char(str_part));
                                        set(handles.lbBemaerkning,'String',new_str);
                                        set(handles.lbBemaerkning, 'Value', iii);                                      
                                    end
                                 end
                            end
                        end
                    end
                  end
              end
            end
     end
end

