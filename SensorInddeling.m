function handles = SensorInddeling(handles)

teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

if isfield(handles.Velfaerdsteknologi,teknologi)
   [uniqvalue,~, ~] = unique([handles.Velfaerdsteknologi.(teknologi).ID]);   
   
   CntRowSensor = 1; 
   
   teknologisensor = teknologi + 'Sensor';
   for ii = 1:max(uniqvalue)
        for CntRow = 1:length(handles.Velfaerdsteknologi.(teknologi))
       
           id = ['Sensor' num2str(ii)];
           
           %idx=1;
           %udskrift = sprintf("Sensor nr. %s", id);
            
           
           if  handles.Velfaerdsteknologi.(teknologi)(CntRow).ID == ii           

               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).ID = handles.Velfaerdsteknologi.(teknologi)(CntRow).ID;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Omsorgsfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Omsorgsfunktion; 
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Komfortfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Komfortfunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Haevesaenkefunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Haevesaenkefunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidspunkt = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidspunkt;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighedforarbejdsgang = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighedforarbejdsgang;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighedm2medarbejdere = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighedm2medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighedm1medarbejdere = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighedm1medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighedm0medarbejdere = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighedm0medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).LunaMedCarendo = handles.Velfaerdsteknologi.(teknologi)(CntRow).LunaMedCarendo;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Arbejdsgang = handles.Velfaerdsteknologi.(teknologi)(CntRow).Arbejdsgang;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Medarbejdere= handles.Velfaerdsteknologi.(teknologi)(CntRow).Medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidmedborger = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidmedborger;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Superbruger = handles.Velfaerdsteknologi.(teknologi)(CntRow).Superbruger;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Almindeligtpersonale = handles.Velfaerdsteknologi.(teknologi)(CntRow).Almindeligtpersonale;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Afloeser = handles.Velfaerdsteknologi.(teknologi)(CntRow).Afloeser;
               
               
               

              
               
               CntRowSensor = CntRowSensor +1; 
           end
            
        end
       CntRowSensor = 1; 
       
        
   end
   %Udskriver sensorer for valgt teknologi
   for ii=1:length(uniqvalue)
       idx=1;       
       udskrift = sprintf("Sensor nr. %s", num2str(uniqvalue(ii)));
       str_part = udskrift; 
       old_str = get(handles.lbSensorliste,'String'); 
       new_str=strvcat(char(old_str),char(str_part));
       set(handles.lbSensorliste,'String',new_str);
       set(handles.lbSensorliste, 'Value', idx+1);
   end        
       
end
%Sletter feltet Carendo eller Luna nu hvor det er oprettet CarendoSensor
%eller LunaSensor
handles.Velfaerdsteknologi.(teknologi) = []; 
handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,teknologi); 

               
end
