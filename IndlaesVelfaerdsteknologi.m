function handles = IndlaesVelfaerdsteknologi(handles,fil)
%HENTDATAFRASENSORDATAFIL Summary of this function goes here
%   Detailed explanation goes here

%SensorDataFil = importfile('SensorDataFil.xlsx','Ark1');
if nargin ==1
    SensorDataFil = indlaesSensorData('SensorDataFilVers1.xlsx','Ark1');
end

if nargin ==2
    SensorDataFil = indlaesSensorData('Plejecentre.xlsx','Ark1');
end

handles.Velfaerdsteknologi.Carendo = VelfaerdsteknologiIndeling(SensorDataFil,"Carendo");
handles.Velfaerdsteknologi.Luna = VelfaerdsteknologiIndeling(SensorDataFil,"Luna");
 
end

