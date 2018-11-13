function [startDato, slutDato] = VisOverblikData(handles,Vindue)

teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
switch Vindue 
    case 'Teknologi'
        tid = [handles.Velfaerdsteknologi.(teknologi).Tidspunkt];
        Varighed = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang];
        Medarbejder = [handles.Velfaerdsteknologi.(teknologi).Medarbejdere];
        axMedarbejder = handles.axesMedarbejdereTeknologiOverblik;
        axVarighed = handles.axesVarighedTeknologiOverblik;
    case 'Sensor'
        teknologi = handles.field;
        sensorer=fieldnames(handles.Velfaerdsteknologi.(teknologi));
        sensor = string(sensorer(handles.Velfaerdsteknologi.BrugerValgtSensor));
        Varighed = [handles.Velfaerdsteknologi.(teknologi).(sensor).Varighedforarbejdsgang];
        tid = [handles.Velfaerdsteknologi.(teknologi).(sensor).Tidspunkt];
        Medarbejder = [handles.Velfaerdsteknologi.(teknologi).(sensor).Medarbejdere];
        axMedarbejder = handles.axesMedarbejderSensorDataVindue;
        axVarighed =handles.axesVarighedSensorDataVindue;
end   
       
%Idet at det er en tid så skal det skrives ud i typen duration med
%følgende format. 
infmt = 'mm:ss';
varighed = duration(Varighed,'InputFormat',infmt); 
VisData(handles,tid,Medarbejder,axMedarbejder,Vindue);
[startDato,slutDato] = VisData(handles,tid,varighed,axVarighed,Vindue);
axes(axMedarbejder)
ylabel('Antal medarbejdere')
axes(axVarighed)
ylabel('Varighed i minutter')
end

