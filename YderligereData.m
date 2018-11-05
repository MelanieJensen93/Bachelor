function handles = YderligereData(handles)
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

CntRowSuperBruger = 1;
CntRowAlmindelig = 1;
d=1;
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
d=1;
end
