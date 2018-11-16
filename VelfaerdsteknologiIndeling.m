function output = VelfaerdsteknologiIndeling(SensorDataFil,teknologi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
CntRowTeknologi = 1; 

for CntRow = 1:size(SensorDataFil,1)
    if strcmp(SensorDataFil.Velfaerdsteknologi(CntRow),teknologi)==1
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).ID=SensorDataFil.ID(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Tidspunkt=SensorDataFil.Tidspunkt(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Omsorgsfunktion=SensorDataFil.Omsorgsfunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Komfortfunktion=SensorDataFil.Komfortfunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Haevesaenkefunktion=SensorDataFil.Haevesaenkefunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).LunaMedCarendo=SensorDataFil.LunaMedCarendo(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Varighedforarbejdsgang=SensorDataFil.Varighedforarbejdsgang(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Varighedm2medarbejdere=SensorDataFil.Varighedm2medarbejdere(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Varighedm1medarbejdere=SensorDataFil.Varighedm1medarbejder(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Varighedm0medarbejdere=SensorDataFil.Varighedm0medarbejder(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Arbejdsgang=SensorDataFil.Arbejdsgang(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Medarbejdere=SensorDataFil.Medarbejdere(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Tidmedborger=SensorDataFil.Tidmedborger(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Superbruger=SensorDataFil.Superbruger(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Almindeligtpersonale=SensorDataFil.Almindeligtpersonale(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Afloeser=SensorDataFil.Afloeser(CntRow);
        CntRowTeknologi= CntRowTeknologi+1; 

    end
end

output = handles.Velfaerdsteknologi.(teknologi);
end

