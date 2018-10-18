function handles = SensorInddeling(handles)

teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

if isfield(handles.Velfaerdsteknologi,teknologi)
   [uniqvalue,~, ~] = unique([handles.Velfaerdsteknologi.(teknologi).ID]);
   
   CntRowSensor = 1; 
   
   teknologisensor = teknologi + 'Sensor';
   d=1; 
   for ii = 1:max(uniqvalue)
        for CntRow = 1:length(handles.Velfaerdsteknologi.(teknologi))
       
           id = ['Sensor' num2str(ii)];
           
           idx=1;
            udskrift = sprintf("Sensor nr. %s", id);
            str_part = udskrift; 
            old_str = get(handles.lbSensorliste,'String'); 
            new_str=strvcat(char(old_str),char(str_part));
            set(handles.lbSensorliste,'String',new_str);
            set(handles.lbSensorliste, 'Value', idx+1);
           
           if  handles.Velfaerdsteknologi.(teknologi)(CntRow).ID == ii           

               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).ID = handles.Velfaerdsteknologi.(teknologi)(CntRow).ID;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Omsorgsfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Omsorgsfunktion; 
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Komfortfunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Komfortfunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Haevesaenkefunktion = handles.Velfaerdsteknologi.(teknologi)(CntRow).Haevesaenkefunktion;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidspunkt = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidspunkt;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Varighed = handles.Velfaerdsteknologi.(teknologi)(CntRow).Varighed;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).LunaMedCarendo = handles.Velfaerdsteknologi.(teknologi)(CntRow).LunaMedCarendo;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Arbejdsgang = handles.Velfaerdsteknologi.(teknologi)(CntRow).Arbejdsgang;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Medarbejdere= handles.Velfaerdsteknologi.(teknologi)(CntRow).Medarbejdere;
               handles.Velfaerdsteknologi.(teknologisensor).(id)(CntRowSensor).Tidmedborger = handles.Velfaerdsteknologi.(teknologi)(CntRow).Tidmedborger;
%                idx=1;
%              
%                 udskrift = sprintf("Sensor nr. %s", num2str(handles.Velfaerdsteknologi.(teknologisensor).(id).ID));
%                 str_part = udskrift; 
%                 old_str = get(handles.lbSensorliste,'String'); 
%                 new_str=strvcat(char(old_str),char(str_part));
%                 set(handles.lbSensorliste,'String',new_str);
%                 d=1;
%                 set(handles.lbSensorliste, 'Value', idx+1);
              
               
               CntRowSensor = CntRowSensor +1; 
           end
            
        end
       CntRowSensor = 1; 
       
        
   end
   
   d=1;              
end
%Sletter feltet Carendo eller Luna nu hvor det er oprettet CarendoSensor
%eller LunaSensor
handles.Velfaerdsteknologi.(teknologi) = []; 
handles.Velfaerdsteknologi=rmfield(handles.Velfaerdsteknologi,teknologi); 

               
end
