function OpdaterListboxSensorOverblik(handles)
%OPDATERLISTBOXSENSOROVERBLIK udskriver sensornavn for den valgte teknologi i en liste. 
%Udskriver sensorer for valgt teknologi
%   INPUT: 
%   handles = handles til elementer i GUI. 

teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
Sensorer = string(fieldnames(handles.Velfaerdsteknologi.(teknologi)));
    % for hver sensor
   for ii=1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi))) 
       % Stammer fra: https://www.youtube.com/watch?v=TBegsdnwJbA
       % Sensor(ii) skal udskrives
       udskrift = sprintf(Sensorer(ii));
       str_part = udskrift; 
       % Henter de eksisterende udskrifter
       gml_str = get(handles.lbSensorliste,'String'); 
       ny_str=strvcat(char(gml_str),char(str_part));
       set(handles.lbSensorliste,'String',ny_str);
   end        
end 