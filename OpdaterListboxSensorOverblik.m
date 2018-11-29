function OpdaterListboxSensorOverblik(handles)
%Udskriver sensorer for valgt teknologi
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));
Sensorer = string(fieldnames(handles.Velfaerdsteknologi.(teknologi)));
   for ii=1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))   
       udskrift = sprintf(Sensorer(ii));
       str_part = udskrift; 
       old_str = get(handles.lbSensorliste,'String'); 
       new_str=strvcat(char(old_str),char(str_part));
       set(handles.lbSensorliste,'String',new_str);
   end        
end 