function handles = ValgAfDatapunkt(handles,datatogo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ValgtDato = get(handles.etDatoTilfoejBemaerkning, 'String');
ValgtDatoDatetime = datetime(ValgtDato, 'InputFormat', 'dd-MM-yyyy');

%Vi skal bruge navnet på den valgte teknologi og det står i række 1
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

if isfield(handles.Velfaerdsteknologi,teknologi)
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi))
          Sensornavn = string(Sensor(i));
        for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
            tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
            tidspunkt.Format = 'dd-MMM-yyyy'; 
            tidspunkt = string(tidspunkt);
            if tidspunkt == ValgtDatoDatetime
               
                GUIDatafravalgtdato(datatogo, handles);
                udskrift= sprintf("%s", handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt);
                str_part = udskrift; 
                old_str = get(handles.lbDataforvalgtdag,'String'); 
                new_str=strvcat(char(old_str),char(str_part));
                set(handles.lbDataforvalgtdag,'String',new_str);
                set(handles.lbDataforvalgtdag, 'Value', idx+1);
                
            end 
            d=1;
        end
        end
    end
end

