function [startDato, slutDato] = VisOverblikData(handles,Vindue)
%VISOVERBLIKDATA plotter data i en graf og udskriver antal gange en teknologi eller
%   sensor er blevet brugt. Den inddeler data i den valgte periode, for
%   derefter at plotte dem. Denne funktion plotter kun på "Teknologi
%   Overblik Skærm" og "Sensor Overblik Skærm". 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   Vindue = Det vindue/skærm data skal plottes i
%
%   OUTPUT: 
%   startDato = Dato, hvor data skal startes vises fra. 
%   slutDato = Dato, hvor data skal stal vises til. Pr. default er det den
%   dato, hvor der den seneste data fra, ellers er dette brugervalgt. 
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
[startDato,slutDato,DataEksistere] = VisData(handles,tid,varighed,axVarighed,Vindue);
axes(axMedarbejder)
ylabel('Antal medarbejdere')
axes(axVarighed)
ylabel('Varighed i minutter')

    if DataEksistere == 1
        msgbox('Der er ikke data for den valgte periode');
    end
end

