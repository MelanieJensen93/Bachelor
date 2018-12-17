function OpdaterBemaerkningSensorOverblik(handles,startDato,slutDato)
%OpdaterBemaerkningSensorOverblik udskriver bemærkninger for den valgte
%periode og dato i listen i "Sensor Overblik Skærm". 
%   INPUT: 
%   startDato = fra denne dato skal bemærkninger vises. 
%   slutDato = til denne dato skal bemærkninger vises. 
%   handles = handle til elementer i GUI. 
 
%Indlæs bemærkningsfil 
DatafraBemaerkningsFil = readtable('BemaerkningsFil.xlsx');
handles.Velfaerdsteknologi.Bemaerkninger = DatafraBemaerkningsFil;
%Finder teknologien og den afkrydsede periode
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
periode = get(get(handles.btngroupRedigerGrafSensoroverblik,'SelectedObject'),'String');

% Sletter indholdet i listen
handles.lbBemaerkning.String = [];
drawnow; 

% Finder sensornavn 
if isfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor')
    Sensornrfralistbox = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
     for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornrfralistbox == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
        end
     end
end

% Opretter en ny tabel med kun 1 sensor
raekker = DatafraBemaerkningsFil.Teknologi==teknologi & DatafraBemaerkningsFil.Sensornavn == Sensornavn;
variabler = {'Sensornavn','DatoOgTidspunkt','Bemaerkning'};
SensorBemaerkning = DatafraBemaerkningsFil(raekker,variabler);

% Kører over alle bemærkninger
for i=1:height(SensorBemaerkning)
    tidspunktBemaerkning=SensorBemaerkning.DatoOgTidspunkt(i);
    % Præallokere et categorical array med tidspunkterpådagen
    TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
    % Tiden bliver placeret indenfor de bestemte intervaller. 
    if hour(tidspunktBemaerkning)>=5 && hour(tidspunktBemaerkning)< 9
        TidspunktPaaDagen_Data=TidspunktPaaDagen(1);
    elseif hour(tidspunktBemaerkning)>=9 && hour(tidspunktBemaerkning)<11
        TidspunktPaaDagen_Data= TidspunktPaaDagen(2);
    elseif hour(tidspunktBemaerkning)>=11 && hour(tidspunktBemaerkning)<14
        TidspunktPaaDagen_Data= TidspunktPaaDagen(3);
    elseif hour(tidspunktBemaerkning)>=14 && hour(tidspunktBemaerkning)<17
        TidspunktPaaDagen_Data= TidspunktPaaDagen(4);
    elseif hour(tidspunktBemaerkning)>=17 && hour(tidspunktBemaerkning)<23 
        TidspunktPaaDagen_Data= TidspunktPaaDagen(5);
    else 
        TidspunktPaaDagen_Data= TidspunktPaaDagen(6);
    end
    
    tidspunktBemaerkning = datetime(datestr(tidspunktBemaerkning,'dd-mm-yyyy'));
    % udskriv = 0, hvis ikke den skal udskrives for den givne periode
    udskriv =0;
    
    
    % Hvis dag er afkrydset 
    if strcmp(periode,'Dag')==1
         if tidspunktBemaerkning == datetime(slutDato)
            udskriv = 1; 
         end 
    else % Hvis uge, måned eller år er afkrydset tjekkes om tidspunktet er inden for perioden
        if tidspunktBemaerkning >= startDato && tidspunktBemaerkning <= datetime(slutDato)
            udskriv = 1; 
        end
    end
    
    % Hvis der skal udskrives 
    if udskriv ==1 
        % Stammer fra: https://www.youtube.com/watch?v=TBegsdnwJbA 
        % Følgende tekst skal udskrives 
        ny_udskrift= sprintf("%s %s %s %s", Sensornavn, tidspunktBemaerkning, TidspunktPaaDagen_Data, ...
        string(SensorBemaerkning.Bemaerkning(i))); 
        % Henter de eksisterende udskrifter
        gml_udskrift = get(handles.lbBemaerkning,'String'); 
        ny_str=strvcat(char(gml_udskrift ),char(ny_udskrift));
        set(handles.lbBemaerkning,'String',ny_str);
    end  
end