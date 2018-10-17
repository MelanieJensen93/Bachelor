function handles = SensorSortering(handles)
%HENTDATAFRASENSORDATAFIL Summary of this function goes here
%   Detailed explanation goes here

SensorDataFil = importfile('SensorDataFil.xlsx','Ark1');

%CntRowCarendo=1;
%CntRowLuna=1;
[uniqvalue,~, ~] = unique([SensorDataFil.ID]);
CntRowSensor = 1;
for ii = 1:max(uniqvalue)
    for CntRow = 1:size(SensorDataFil,1)
    d=1; 
         id = ['Sensor' num2str(ii)];
         if SensorDataFil.ID(CntRow)==ii
             D=1; 
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).ID = SensorDataFil.ID(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Velfaerdsteknologi = SensorDataFil.Velfaerdsteknologi(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidspunkt = SensorDataFil.Tidspunkt(CntRow); 
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Omsorgsfunktion=SensorDataFil.Omsorgsfunktion(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Komfortfunktion = SensorDataFil.Komfortfunktion(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Haevesaenkefunktion =SensorDataFil.Haevesaenkefunktion(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Varighed = SensorDataFil.Varighed(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).LunaMedCarendo = SensorDataFil.LunaMedCarendo(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Arbejdsgang =SensorDataFil.Arbejdsgang(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Medarbejdere= SensorDataFil.Medarbejdere(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidmedborger=SensorDataFil.Tidmedborger(CntRow);
             handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Personalefaglighed = SensorDataFil.Personalefaglighed(CntRow);
             CntRowSensor = CntRowSensor +1;
         end
    end
    CntRowSensor = 1; 
end
d=1; 
end

