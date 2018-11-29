function handles = GemBemaerkningiFil(handles)
%GEMBEMAERKNINGIFIL Funktionen GemBemaerkningifil læser først
%   bemærkningsfilen, og indlæser data i handles. Det gøres for at den nye 
%   bemærkning der er ved at blive tilføjet, også kan blive tilføjet i
%   handles, som den sidste bemærkning i listen over bemærkninger i handles.
%   Efterfølgende oprettes en tabel med alle bemærkningerne fra handles,
%   sammen med oplysninger om hvilken sensor, dato og tidspunkt bemærkningen
%   tilhører. Til sidste gemmes tablen i "'Bemærknings-filen". 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   
%   OUTPUT: 
%   handles = handle til elementer i GUI. 

teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

Antalfravalgtdato = 0;
%if ~exist('BemaerkningsFilEfterInstall.xlsx','File')
    DatafraBemaerkningsFil = readtable('BemaerkningsFil.xlsx');
%else
 %   DatafraBemaerkningsFil = readtable('BemaerkningsFilEfterInstall.xlsx');
%end

handles.Velfaerdsteknologi.BemaerkningsFilLaengde = height(DatafraBemaerkningsFil);

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
                     for iii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning) 
                         T = table(teknologi, Sensornavn,handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt ,...
                             handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning(iii).Bemaerkning().bemaerkning);
                         laengdeafBemaerkningsfil = handles.Velfaerdsteknologi.BemaerkningsFilLaengde+2;
                         udskrift = sprintf('A%1.f:D%1.f', laengdeafBemaerkningsfil, laengdeafBemaerkningsfil);
                        writetable(T, 'BemaerkningsFil.xlsx', 'Sheet', 1,'Range', udskrift, 'WriteVariableNames', false);            
                     end
                  end
            end
          end
        end
    end
end
end

