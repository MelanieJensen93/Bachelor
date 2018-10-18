function handles = Velfaerdsteknologi(handles)
%HENTDATAFRASENSORDATAFIL Summary of this function goes here
%   Detailed explanation goes here

SensorDataFil = importfile('SensorDataFil.xlsx','Ark1');

CntRowCarendo=1;
CntRowLuna=1;
%handles.Velfaerdsteknologi.Carendo = VelfaerdsteknologiIndeling(SensorDataFil,"Carendo");
%handles.Velfaerdsteknologi.Luna = VelfaerdsteknologiIndeling(SensorDataFil,"Luna");
d=1; 
for CntRow = 1:size(SensorDataFil,1)
    %id = ['Sensor' num2str(ii)];
    %for velfaerdsteknologi = {'Carendo','Luna'
    if strcmp(SensorDataFil.Velfaerdsteknologi(CntRow),"Carendo")==1
        %[uniqvalue,~, ~] = unique([SensorDataFil.ID(CntRow)]);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).ID=SensorDataFil.ID(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Tidspunkt=SensorDataFil.Tidspunkt(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Omsorgsfunktion=SensorDataFil.Omsorgsfunktion(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Komfortfunktion=SensorDataFil.Komfortfunktion(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Haevesaenkefunktion=SensorDataFil.Haevesaenkefunktion(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Varighed=SensorDataFil.Varighed(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).LunaMedCarendo=SensorDataFil.LunaMedCarendo(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Arbejdsgang=SensorDataFil.Arbejdsgang(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Medarbejdere=SensorDataFil.Medarbejdere(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Tidmedborger=SensorDataFil.Tidmedborger(CntRow);
        handles.Velfaerdsteknologi.Carendo(CntRowCarendo).Personalefaglighed=SensorDataFil.Personalefaglighed(CntRow);
        CntRowCarendo= CntRowCarendo+1; 

    end
    if strcmp(SensorDataFil.Velfaerdsteknologi(CntRow),"Luna")==1
        handles.Velfaerdsteknologi.Luna(CntRowLuna).ID=SensorDataFil.ID(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Tidspunkt=SensorDataFil.Tidspunkt(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Varighed=SensorDataFil.Varighed(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).LunaMedCarendo=SensorDataFil.LunaMedCarendo(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Arbejdsgang=SensorDataFil.Arbejdsgang(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Medarbejdere=SensorDataFil.Medarbejdere(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Tidmedborger=SensorDataFil.Tidmedborger(CntRow);
        handles.Velfaerdsteknologi.Luna(CntRowLuna).Personalefaglighed=SensorDataFil.Personalefaglighed(CntRow);
        CntRowLuna=CntRowLuna+1; 
    end
  d=1;
end
d=1;
end


% d=1; 
% if isfield(handles.Velfaerdsteknologi,'Carendo')
%    [uniqvalue,~, ~] = unique([handles.Velfaerdsteknologi.Carendo.ID]);
%    
%    CntRowSensor = 1; 
%    for ii = 1:max(uniqvalue)
%         for CntRow = 1:length(handles.Velfaerdsteknologi.Carendo)
%        
%            id = ['Sensor' num2str(ii)];
%            if handles.Velfaerdsteknologi.Carendo(CntRow).ID == ii 
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).ID = handles.Velfaerdsteknologi.Carendo(CntRow).ID;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Omsorgsfunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Omsorgsfunktion; 
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Komfortfunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Komfortfunktion;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Haevesaenkefunktion = handles.Velfaerdsteknologi.Carendo(CntRow).Haevesaenkefunktion;
%                 handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidspunkt = handles.Velfaerdsteknologi.Carendo(CntRow).Tidspunkt;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Varighed = handles.Velfaerdsteknologi.Carendo(CntRow).Varighed;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).LunaMedCarendo = handles.Velfaerdsteknologi.Carendo(CntRow).LunaMedCarendo;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Arbejdsgang = handles.Velfaerdsteknologi.Carendo(CntRow).Arbejdsgang;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Medarbejdere= handles.Velfaerdsteknologi.Carendo(CntRow).Medarbejdere;
%                handles.Velfaerdsteknologi.Sensorer.(id)(CntRowSensor).Tidmedborger = handles.Velfaerdsteknologi.Carendo(CntRow).Tidmedborger;
%               CntRowSensor = CntRowSensor +1; 
%            end
%             
%         end
%        CntRowSensor = 1; 
%    end
               

