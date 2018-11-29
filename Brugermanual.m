function handles = Brugermanual(handles)
%BRUGERMANUAL viser et billede af en brugermanual for henholdsvis "'Carendo"'
%   og "'Luna loftlift"', at efter hvilken teknologi der er valgt. Funktionen
%   tjekker om der ligger data for "'Carendo"' og "'Luna loftlift"' i handles, 
%   og ud fra det finder den ud af hvilken brugermanual der skal vises i vinduet.
%   Når der trykkes på knappen "'Se Brugermnaual"' åbnes brugermanualen som
%   en PDF-fil i computerens browser. 
%  
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   
%   OUTPUT: 
%   handles = handle til elementer i GUI.

if isfield(handles.Velfaerdsteknologi,'Carendo')
    set(handles.txtValgtteknologiBrugermanualvindue,'String', 'Carendo');
    axes(handles.axValgtteknologiBrugermanualVindue)
    imshow('carendobrugermanual.png');

elseif isfield(handles.Velfaerdsteknologi,'Luna')
    set(handles.txtValgtteknologiBrugermanualvindue,'String','Luna loftlift');
    axes(handles.axValgtteknologiBrugermanualVindue)
    imshow('lunaloftliftmanual.png');   

else
    msgbox('Det er i øjeblikket ingen brugermanual ', 'Brugermanual mangler', 'error');
end
