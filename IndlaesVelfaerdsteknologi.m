function handles = IndlaesVelfaerdsteknologi(handles)
%HENTDATAFRASENSORDATAFIL Summary of this function goes here
%   Detailed explanation goes here

%SensorDataFil = importfile('SensorDataFil.xlsx','Ark1');
SensorDataFil = LoadFile('SensorDataFil.xlsx','Ark1');
d=1; 

handles.Velfaerdsteknologi.Carendo = VelfaerdsteknologiIndeling(SensorDataFil,"Carendo");
handles.Velfaerdsteknologi.Luna = VelfaerdsteknologiIndeling(SensorDataFil,"Luna");
 
end

