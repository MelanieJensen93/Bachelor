function handles = SensorInddeling(handles)
%SENSORINDDELING finder de unikke sensorer, som der er data for, og sorterer data i de enkelte sensorer, således at en sensor har en tabel af data. Disse gemmes i handles, som den modtager som input. De opdaterede handles sendes som output.
%   INPUT: 
%   handles = handle til elementer i GUI. 
%
%   OUTPUT: 
%   handles = handle til elementer i GUI.  

teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

if isfield(handles.Velfaerdsteknologi,teknologi)
    % Finder de unikke værdier i ID i den valgte teknologi. 
   [uniqvalue,~, ~] = unique([handles.Velfaerdsteknologi.(teknologi).ID]);   
   
   CntRowSensor = 1; 
   
   teknologisensor = teknologi + 'Sensor';
   for ii = 1:max(uniqvalue)
        for CntRow = 1:length(handles.Velfaerdsteknologi.(teknologi))
           %Under denne variabel skal et struct gemmes med de rækker fra teknologi, der
           %tilhører den pågældende sensor. 
           id = ['Sensor' num2str(ii)];            
           
           if  handles.Velfaerdsteknologi.(teknologi)(CntRow).ID == ii           
               %handles gemmes i denne sensor. 
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).ID = handles.Velfaerdsteknologi.(teknologi)(CntRow).ID;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Omsorgsfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Omsorgsfunktion; 
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Komfortfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Komfortfunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Haevesaenkefunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Haevesaenkefunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidspunkt = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidspunkt;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighedforarbejdsgang = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighedforarbejdsgang;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).LunaMedCarendo = handles.Velfaerdsteknologi.(teknologi)(CntRow).LunaMedCarendo;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Medarbejdere= handles.Velfaerdsteknologi.(teknologi)(CntRow).Medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidmedborger = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidmedborger;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Superbruger = handles.Velfaerdsteknologi.(teknologi)(CntRow).Superbruger;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Almindeligtpersonale = handles.Velfaerdsteknologi.(teknologi)(CntRow).Almindeligtpersonale;
               %Herefter kan handles for den næste sensor findes. 
               CntRowSensor = CntRowSensor +1; 
           end
            
        end
       CntRowSensor = 1; 
       
        
   end
   %Udskriver sensorer for valgt teknologi på Sensor Liste Skærm 
   for ii=1:length(uniqvalue)
       idx=1;  
       %Udskriver følgende tekst.
       udskrift = sprintf("Sensor nr. %s", num2str(uniqvalue(ii)));
       str_part = udskrift; 
       % Henter de eksisterende udskrifter
       gml_str = get(handles.lbSensorliste,'String'); 
       ny_str=strvcat(char(gml_str),char(str_part));
       set(handles.lbSensorliste,'String',ny_str);
       
   end        
       
end
%Sletter feltet Carendo eller Luna nu hvor det er oprettet CarendoSensor
%eller LunaSensor
handles.Velfaerdsteknologi.(teknologi) = []; 
handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,teknologi); 

               
end
