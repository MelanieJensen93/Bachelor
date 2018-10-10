function handles = Brugermanual(handles)
%BRUGERMANUAL Summary of this function goes here
%   Detailed explanation goes here

if isfield(handles.Velfaerdsteknologi,'Carendo')
    myString = sprintf('Test');
    set(handles.txtValgtteknologiBrugermanualvindue,'String', myString); 
end
if isfield(handles.Velfaerdsteknologi,'Luna')
    txtValgtteknologiBrugermanualvindue('Luna loftlift'); 
    msgbox('Det er i øjeblikket ingen brugermanual til ', 'modal', 'error');
end

