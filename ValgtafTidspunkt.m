function handles = ValgtafTidspunkt(handles,datatogo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
if isfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    ValgtTidspunkt = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
            if ValgtTidspunkt == ii
                udskrift = string(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt);
                udskrift = sprintf("%s %s %s", teknologi, Sensornavn, udskrift);
                set(handles.txtValgtTidspunkt, 'String', udskrift);
            end
          end
        end
    end
end
end

