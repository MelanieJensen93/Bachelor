function handles = IndlaesVelfaerdsteknologi(handles,fil)
%INDLAESVELFAERSTEKNOLOGI indlæser data fra filen og inddeler data i
%velfærdsteknologier, og gemmer dette i handles. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   fil = angiver om SammenlignMedPlejecentre skal læses. 
%
%   OUTPUT: 
%   handles = handle til elementer i GUI.  
if nargin ==1
    % Læser data ind i "SensorDataFil" varibel i en struct. 
    SensorDataFil = indlaesSensorData('SensorDataFilVers1.xlsx','Ark1');
end

if nargin ==2
    % Læser data ind i "SensorDataFil" varibel i en struct. 
    SensorDataFil = indlaesSensorData('SensorDataSammenlignFil.xlsx','Ark1');
end

% Data inddeles i de to mulige teknologier.
handles.Velfaerdsteknologi.Carendo = VelfaerdsteknologiIndeling(SensorDataFil,"Carendo");
handles.Velfaerdsteknologi.Luna = VelfaerdsteknologiIndeling(SensorDataFil,"Luna");
 
end

