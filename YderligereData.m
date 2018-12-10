function handles = YderligereData(handles)
%YDERLIGEREDATA Funktionen YderligereData sorterer teknologiens data, og udtrækker værdier for varighed af arbejdsgang for superbruger samt for alment personale, som senere skal vises på "Yderligere Data Skærm"
%   INPUT: 
%   handles = handle til elementer i GUI. 
%
%   OUTPUT: 
%   handles = handle til elementer i GUI.  
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

CntRowSuperBruger = 1;
CntRowAlmindelig = 1;

for i = 1:length(handles.Velfaerdsteknologi.(teknologi))
    if handles.Velfaerdsteknologi.(teknologi)(i).Superbruger ==1
        handles.SuperBruger(CntRowSuperBruger) = handles.Velfaerdsteknologi.(teknologi)(i);
        CntRowSuperBruger = CntRowSuperBruger +1; 
    end
    
    if handles.Velfaerdsteknologi.(teknologi)(i).Almindeligtpersonale ==1
        handles.Almindelig(CntRowAlmindelig) = handles.Velfaerdsteknologi.(teknologi)(i);
        CntRowAlmindelig = CntRowAlmindelig +1; 
    end 
end

end
