function handles = IndlaesVelfaerdsteknologi(handles,fil)
%INDLAESVELFAERSTEKNOLOGI indl�ser data fra filen og inddeler data i
%velf�rdsteknologier, og gemmer dette i handles. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   fil = angiver om SammenlignMedPlejecentre skal l�ses. 
%
%   OUTPUT: 
%   handles = handle til elementer i GUI.  
if nargin ==1
    % L�ser data ind i "SensorDataFil" varibel i en struct. 
    SensorDataFil = indlaesSensorData('SensorDataFilVers1.xlsx','Ark1');
end

if nargin ==2
    % L�ser data ind i "SensorDataFil" varibel i en struct. 
    SensorDataFil = indlaesSensorData('SensorDataSammenlignFil.xlsx','Ark1');
end

% Data inddeles i de to mulige teknologier.
handles.Velfaerdsteknologi.Carendo = VelfaerdsteknologiIndeling(SensorDataFil,"Carendo");
handles.Velfaerdsteknologi.Luna = VelfaerdsteknologiIndeling(SensorDataFil,"Luna");
 
end

