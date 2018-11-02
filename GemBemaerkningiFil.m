function handles = GemBemaerkningiFil(handles,inputArg2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
                    % A st�r for Append, og stemmer fra linket her
                    % https://se.mathworks.com/help/symbolic/mupad_ref/fopen.html
                    bemaerkningsFil = fopen('bemarkningsFil.txt', 'A');
                    for iii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning)  

                        fprintf(bemaerkningsFil, '%s %s %s %s\n',...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning(iii).Bemaerkning().tidspunkt,...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning(iii).Bemaerkning().bemaerkning,...
                            teknologi, handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt);
                    end

                    fclose(bemaerkningsFil);
                  end
            end
          end
        end
    end
end
end

