function handles = Velfaerdsteknologi(handles)
%HENTDATAFRASENSORDATAFIL Summary of this function goes here
%   Detailed explanation goes here

SensorDataFil = importfile('SensorDataFil.xlsx','Ark1');

CntRowCarendo=1;
CntRowLuna=1;

for CntRow = 1:size(SensorDataFil,1)
    if strcmp(SensorDataFil.Velfaerdsteknologi(CntRow),"Carendo")==1
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

