function handles = OpdaterListboxmedBemaerkning(handles, datatogo)
%OPDATERLISTBOXMEDBEMAERKNING Summary of this function goes here
%   Detailed explanation goes here

% gemtDataBemaerkningsfil = load(fullfile('C:\Users\Bruger\Documents\Sundhedsteknologi\7. Semester\Bachelor\MatLab',...
%     'BemaerkningsFil.mat'));
% 
% handles.Velfaerdsteknologi = gemtDataBemaerkningsfil.Velfaerdsteknologi;

handles.lbBemaerkning.String = [];
drawnow;       

DatafraBemaerkningsFil = readtable('BemaerkningsFil.xlsx');
handles.Velfaerdsteknologi.BemaerkningsFilLaengde = height(DatafraBemaerkningsFil);

teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

if isfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor')
    Sensornrfralistbox = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
     for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
            if Sensornrfralistbox == i 
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
                                 [handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode] = [];
                                 if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii), 'TilfoejBemaerkning')
                                    for iiii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning)
                                        
                                     %Præallokere et categorical array med tidspunkterpådagen
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
                                        
                                        startDato = handles.Velfaerdsteknologi.VisData.startDato; 
                                        slutDato = handles.Velfaerdsteknologi.VisData.slutDato;
                                        
                                        if ischar(slutDato)==1
                                            slutDato = datetime(slutDato);
                                        end
                                        slutDato = slutDato + '23:59:59';
                                        %tidspunktPeriode = handles.Velfaerdsteknologi.VisData.TidsBegraensning;
                                        %handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode = []; 
                                        %for iiiii = 1:length(tidspunktPeriode)
                                         tidspunktBemaerkning = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(iiii).tidspunkt;
                                         
                                         periode = get(get(handles.btngroupRedigerGrafSensoroverblik,'SelectedObject'),'String');
                                         if strcmp(periode,'Dag')==1
                                             tidspunktBemaerkning.Format = 'dd-MMM-yyyy';
                                             tidspunktBemaerkning = string(tidspunktBemaerkning);
                                             slutDato.Format = 'dd-MMM-yyyy';
                                             slutDato = string(slutDato);
                                             if tidspunktBemaerkning == slutDato
                                                 handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode = 1; 
                                             end 
                                         else 
                                            if tidspunktBemaerkning >= startDato && tidspunktBemaerkning <slutDato
                                                handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode = 1; 
                                            end
                                         end 
%                                                 = 'dd-MMM-yyyy';
%                                             formatTidspunktBemaerkning = string(tidspunktBemaerkning);
%                                             formatTidspunktPeriode = string(tidspunktPeriode(iiiii));
%                                             if formatTidspunktBemaerkning == formatTidspunktPeriode
%                                                 handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode = 1; 
%                              
%                                             end
                                        end
                                                                             
                                    end
                                    
                                
                                    if handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).tidspunktPeriode ==1 
                                        tidspunktKunDato = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                                        tidspunktKunDato.Format = 'dd-MMM-yyyy';
                                        tidspunktKunDato = string(tidspunktKunDato);
                                        udskrift= sprintf("%s %s %s %s", Sensornavn, tidspunktKunDato, TidspunktPaaDagen_Data, ...
                                            string(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning));
                                        str_part = udskrift; 
                                        old_str = get(handles.lbBemaerkning,'String'); 
                                        new_str=strvcat(char(old_str),char(str_part));
                                        set(handles.lbBemaerkning,'String',new_str);
                                        %set(handles.lbBemaerkning, 'Value', iii); 
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

