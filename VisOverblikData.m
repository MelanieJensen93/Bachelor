function [startDato, slutDato] = VisOverblikData(handles,xData, yMedarbejder, yVarighed, axMedarbejder, axVarighed,Vindue)

%Idet at det er en tid s� skal det skrives ud i typen duration med
%f�lgende format. 
infmt = 'mm:ss';
varighed = duration(yVarighed,'InputFormat',infmt); 
VisData(handles,xData,yMedarbejder,axMedarbejder,Vindue);
[startDato,slutDato] = VisData(handles,xData,varighed,axVarighed,Vindue);
axes(axMedarbejder)
ylabel('Antal medarbejdere')
axes(axVarighed)
ylabel('Varighed i minutter')
end

