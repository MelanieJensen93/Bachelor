function output = VelfaerdsteknologiIndeling(SensorDataFil,teknologi)
%VELFAERDSTEKNOLOGIINDELING inddeler data i velf�rdsteknologier. 
%   INPUT: 
%   SensorDataFil = Data, som indeholder data for teknologier. 
%   teknologi = Den teknologi, der �nskes at sorteres for. 
%  
%   OUTPUT: 
%   handles = handle til data for en teknologi  
CntRowTeknologi = 1; 

%L�ber alle r�kker i filens data igennem 
for CntRow = 1:size(SensorDataFil,1)
    % Hvis r�kken er lig med teknologiens navn vil den gemme r�kken i
    % handles. 
    if strcmp(SensorDataFil.Velfaerdsteknologi(CntRow),teknologi)==1
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).ID=SensorDataFil.ID(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Tidspunkt=SensorDataFil.Tidspunkt(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Omsorgsfunktion=SensorDataFil.Omsorgsfunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Komfortfunktion=SensorDataFil.Komfortfunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Haevesaenkefunktion=SensorDataFil.Haevesaenkefunktion(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).LunaMedCarendo=SensorDataFil.LunaMedCarendo(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Varighedforarbejdsgang=SensorDataFil.Varighedforarbejdsgang(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Medarbejdere=SensorDataFil.Medarbejdere(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Tidmedborger=SensorDataFil.Tidmedborger(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Superbruger=SensorDataFil.Superbruger(CntRow);
        handles.Velfaerdsteknologi.(teknologi)(CntRowTeknologi).Almindeligtpersonale=SensorDataFil.Almindeligtpersonale(CntRow);
        CntRowTeknologi= CntRowTeknologi+1; 

    end
end
% output er et struct af data for den teknologi der er sendt med som input.

output = handles.Velfaerdsteknologi.(teknologi);
end

