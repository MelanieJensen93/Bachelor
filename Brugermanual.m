function handles = Brugermanual(handles)
%BRUGERMANUAL Summary of this function goes here
%   Detailed explanation goes here

if isfield(handles.Velfaerdsteknologi,'Carendo')
    set(handles.txtValgtteknologiBrugermanualvindue,'String', 'Carendo');
    axes(handles.axValgtteknologiBrugermanualVindue)
    imshow('carendobrugermanual.png');

elseif isfield(handles.Velfaerdsteknologi,'Luna')
    set(handles.txtValgtteknologiBrugermanualvindue,'String','Luna loftlift');
    axes(handles.axValgtteknologiBrugermanualVindue)
    imshow('lunaloftliftmanual.png');   

else
    msgbox('Det er i øjeblikket ingen brugermanual ', 'Brugermanul mangler', 'error');
end
