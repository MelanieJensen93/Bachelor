function handles = Sensor(handles)
d=1; 
if isfield(handles.Velfaerdsteknologi,'Carendo')
   [uniqvalue,~, ~] = unique([handles.Velfaerdsteknologi.Carendo.ID]);
   
   CntRowSensor = 1; 
   for ii = 1:max(uniqvalue)
        for CntRow = 1:length(handles.Velfaerdsteknologi.Carendo)
       
           id = ['Sensor' num2str(ii)];
           if handles.Velfaerdsteknologi.Carendo(CntRow).ID == ii 
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).ID = handles.Velfaerdsteknologi.Carendo(CntRow).ID;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Omsorgsfunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Omsorgsfunktion; 
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Komfortfunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Komfortfunktion;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Haevesaenkefunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Haevesaenkefunktion;
                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidspunkt = handles.Velfaerdsteknologi.Carendo(CntRow).Tidspunkt;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Varighed = handles.Velfaerdsteknologi.Carendo(CntRow).Varighed;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).LunaMedCarendo = handles.Velfaerdsteknologi.Carendo(CntRow).LunaMedCarendo;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Arbejdsgang = handles.Velfaerdsteknologi.Carendo(CntRow).Arbejdsgang;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Medarbejdere= handles.Velfaerdsteknologi.Carendo(CntRow).Medarbejdere;
               handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidmedborger = handles.Velfaerdsteknologi.Carendo(CntRow).Tidmedborger;
              CntRowSensor = CntRowSensor +1; 
           end
            
        end
       CntRowSensor = 1; 
   end
   
   d=1;              
end
end