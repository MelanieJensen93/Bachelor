function handles = OpdaterListboxmedBemaerkning(handles, datatogo)
%OPDATERLISTBOXMEDBEMAERKNING Summary of this function goes here
%   Detailed explanation goes here
idx=1;
% udskrift= sprintf("%s %s %s"+handles.TB.B(idx).bemaerkning,handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt);
% str_part = udskrift; 
% old_str = get(handles.lbBemaerkning,'String'); 
% new_str=strvcat(char(old_str),char(str_part));
% set(handles.lbBemaerkning,'String',new_str);
% set(handles.lbBemaerkning, 'Value', idx+1);

% Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
% for ii = 1:length(handles.Velfaerdsteknologi.LunaSensor)
%     if Sensornr == ii 
%       Sensor = fieldnames(handles.Velfaerdsteknologi.LunaSensor)
%       Sensornavn = string(Sensor(ii));
%       if isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn), 'TilfoejBemaerkning')
%       
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

Antalfravalgtdato = 0;

if isfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    Valuefromlistbox = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
              ValgtTidspunkt = handles.Velfaerdsteknologi.ValgtTidspunkt;
              ValgtTidspunkt = string(ValgtTidspunkt);
              tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
              tidspunkt.Format = 'dd-MMM-yyyy';
              tidspunkt = string(tidspunkt);
            if ValgtTidspunkt == tidspunkt 
                  Antalfravalgtdato = Antalfravalgtdato+1;
                  if Antalfravalgtdato == Valuefromlistbox
                      tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                     % Præallokere et categorical array med tidspunkterpådagen
%                       TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
%                     %Tiden bliver placeret indenfor de bestemte intervaller. 
%                         if hour(tidspunkt)>=5 && hour(tidspunkt)< 9
%                             TidspunktPaaDagen_Data=TidspunktPaaDagen(1);
%                         elseif hour(tidspunkt)>=9 && hour(tidspunkt)<11
%                                 TidspunktPaaDagen_Data= TidspunktPaaDagen(2);
%                         elseif hour(tidspunkt)>=11 && hour(tidspunkt)<14
%                                 TidspunktPaaDagen_Data= TidspunktPaaDagen(3);
%                         elseif hour(tidspunkt)>=14 && hour(tidspunkt)<17
%                                 TidspunktPaaDagen_Data= TidspunktPaaDagen(4);
%                         elseif hour(tidspunkt)>=17 && hour(tidspunkt)<23 
%                                 TidspunktPaaDagen_Data= TidspunktPaaDagen(5);
%                         else 
%                                 TidspunktPaaDagen_Data= TidspunktPaaDagen(6);
%                         end

                        udskrift= sprintf("%s %s", handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
                        str_part = udskrift; 
                        old_str = get(handles.lbBemaerkning,'String'); 
                        new_str=strvcat(char(old_str),char(str_part));
                        set(handles.lbBemaerkning,'String',new_str);
                        set(handles.lbBemaerkning, 'Value', idx+1);
                        
                  end
            end
          end
        end
    end
end
end

     


