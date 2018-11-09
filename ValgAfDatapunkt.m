function handles = ValgAfDatapunkt(handles,datatogo, ValgtDato, ValgtDatoDatetime)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%ValgtDato = get(handles.etDatoTilfoejBemaerkning, 'String');
%ValgtDatoDatetime = datetime(ValgtDato, 'InputFormat', 'dd-MM-yyyy');
handles.Velfaerdsteknologi.ValgtDatoDatetime = ValgtDatoDatetime;
%Vi skal bruge navnet på den valgte teknologi og det står i række 1
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

erdenkommetindiif = 0;

if isfield(handles.Velfaerdsteknologi,teknologi)
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
        for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
            tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
            tidspunkt.Format = 'dd-MMM-yyyy'; 
            strTidspunkt = string(tidspunkt);
            if strTidspunkt == ValgtDatoDatetime
                 
                % Præallokere et categorical array med tidspunkterpådagen
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
                    else %hour(tidspunkt)==23 || hour(tidspunkt)<5
                            TidspunktPaaDagen_Data= TidspunktPaaDagen(6);
                    end
                listboxDataforvalgtdato = GUIDatafravalgtdato(datatogo, handles);
                tidspunktKunDato = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                tidspunktKunDato.Format = 'dd-MMM-yyyy';
                tidspunktKunDato = string(tidspunktKunDato);
                udskrift= sprintf(" %s %s %s", Sensornavn, tidspunktKunDato, TidspunktPaaDagen_Data);
                str_part = udskrift; 
                old_str = get(listboxDataforvalgtdato,'String'); 
                new_str=strvcat(char(old_str),char(str_part));
                set(listboxDataforvalgtdato,'String',new_str);
            
                erdenkommetindiif = erdenkommetindiif+1;
                
               
            end 
            
            
            
        end
        end
    end
    
    if erdenkommetindiif == 0
        uiwait(msgbox('Der er ikke data for den valgte dato, vælg venligst ny dato', 'Error', 'error', 'modal'));
    end
end


