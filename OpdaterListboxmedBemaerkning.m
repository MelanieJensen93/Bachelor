function handles = OpdaterListboxmedBemaerkning(handles, datatogo)
%OPDATERLISTBOXMEDBEMAERKNING Summary of this function goes here
%   Detailed explanation goes here
idx=1;
% udskrift= sprintf("%s %s %s"+handles.TB.B(idx).bemaerkning,handles.TB.B(idx).dato, handles.TB.B(idx).tidspunkt);
% str_part = udskrift; 
% old_str = get(handles.lbBemaerkning,'String'); 
% new_str=strvcat(char(old_str),char(str_part));
% set(handles.lbBemaerkning,'String',new_str);
% set(handles.lbBemaerkning, 'Value', idx+1);

Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
for ii = 1:length(handles.Velfaerdsteknologi.LunaSensor)
    if Sensornr == ii 
      Sensor = fieldnames(handles.Velfaerdsteknologi.LunaSensor)
      Sensornavn = string(Sensor(ii));
      if isfield(handles.Velfaerdsteknologi.LunaSensor.(Sensornavn), 'TilfoejBemaerkning')
      
        udskrift= sprintf("%s %s %s", handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).dato,...
        handles.Velfaerdsteknologi.LunaSensor.(Sensornavn).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt);
        str_part = udskrift; 
        old_str = get(handles.lbBemaerkning,'String'); 
        new_str=strvcat(char(old_str),char(str_part));
        set(handles.lbBemaerkning,'String',new_str);
        set(handles.lbBemaerkning, 'Value', idx+1);
      end
    end
end
end


