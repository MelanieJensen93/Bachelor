function [startDato, stringDato] = VisData(handles, xData, yData, axesTeknologi,Vindue)
    teknologi = fieldnames(handles.Velfaerdsteknologi);
    teknologi = string(teknologi(1));
    times = xData';
    
    switch Vindue
        case 'Teknologi'
            % Den valgte periode
            periode = get(get(handles.btngroupRedigerGrafTeknologioverblik,'SelectedObject'),'String');
            % Den valgte dato
            stringDato = get(handles.stDatoTeknologiOverblik,'String');
            txtAntal = handles.txtAntalGangeTeknologioverblik;
        case 'Sensor'
            periode = get(get(handles.btngroupRedigerGrafSensoroverblik,'SelectedObject'),'String');
            % Den valgte dato
            stringDato = get(handles.stDatoSensorOverblik,'String');
            txtAntal = handles.txtAntalGangeSensoroverblik;
        case 'Plejecentre'
            periode = get(get(handles.btngroupRedigergrafPlejecentre,'SelectedObject'),'String');
            stringDato = get(handles.stDatoPlejecentre,'String');
            % Den valgte dato
            txtAntal = handles.txtAntalGangePlejecentreoverblik;
        case 'Yderligere'
            periode = get(get(handles.btngroupRedigergrafYderligere,'SelectedObject'),'String');
            stringDato = get(handles.stDatoYderligere,'String');
            tider = [handles.Velfaerdsteknologi.(teknologi).Tidspunkt];
            if strcmp(teknologi,'Carendo')==1
                Omsorgsfunktion = [handles.Velfaerdsteknologi.(teknologi).Omsorgsfunktion];
                Komfortfunktion = [handles.Velfaerdsteknologi.(teknologi).Komfortfunktion];
                Haevesaenkefunktion = [handles.Velfaerdsteknologi.(teknologi).Haevesaenkefunktion];
                ttYderligere = timetable(tider',Omsorgsfunktion',Komfortfunktion',Haevesaenkefunktion');
            end
            if strcmp(teknologi,'Luna')==1
                LunaMedCarendo = [handles.Velfaerdsteknologi.(teknologi).LunaMedCarendo];
                ttYderligere = timetable(tider',LunaMedCarendo');
            end 
    end
    
    switch periode
        case 'Dag'
            set(handles.rbDag, 'ForegroundColor', [0.69 0.49 0])
            set(handles.rbUge, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbMaaned, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbAar, 'ForegroundColor', [0 0.55 0.69])
        case 'Uge'
            set(handles.rbUge, 'ForegroundColor', [0.69 0.40 0])
            set(handles.rbDag, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbMaaned, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbAar, 'ForegroundColor', [0 0.55 0.69])
        case 'Måned'
            set(handles.rbMaaned, 'ForegroundColor', [0.69 0.40 0])
            set(handles.rbUge, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbAar, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbDag, 'ForegroundColor', [0 0.55 0.69])
        case 'År'
            set(handles.rbAar, 'ForegroundColor', [0.69 0.40 0])
            set(handles.rbUge, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbMaaned, 'ForegroundColor', [0 0.55 0.69])
            set(handles.rbDag, 'ForegroundColor', [0 0.55 0.69])
    end
% Hvis dato ikke valgt, vælges seneste dato 
if isempty(stringDato)
    %stringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
    if strcmp(Vindue,'Yderligere')==1
        stringDato = handles.Velfaerdsteknologi.Yderligere.Dato;
    else 
        %stringDato = xData(1);
        stringDato = datetime(datestr(xData(1),'dd-mm-yyyy'));
        
    end
end

%Konvertere dato til en datetime 
slutDato = datetime(stringDato,'InputFormat','dd-MM-yyyy');

%Opretter en timetable, som knytter data til tiderne. 
tt = timetable(times,yData','VariableNames',{'Data'});

if strcmp(periode, 'Dag')==1
    [sumAnvendelse,Begraensning,slutDato] = DagInddeling(slutDato,stringDato,tt,axesTeknologi);
    %handles.Velfaerdsteknologi.VisData.TidsBegraensning = stringDato; 
    startDato = stringDato; 
end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Uge' 
            [xData, match, tt, sumAnvendelse, Begraensning, startDato] = UgeInddeling(slutDato,tt);
        case 'Måned'
            [xData, match, tt, sumAnvendelse, Begraensning, startDato ] = MaanedInddeling(slutDato,tt);
        case 'År'
            [xData, match, tt, sumAnvendelse, Begraensning, startDato] = AarInddeling(slutDato,tt);    
    end
    %handles.Velfaerdsteknologi.VisData.TidsBegraensning= xData; 
    
%     if isfield(handles.Velfaerdsteknologi, 'VisData')
%         delete(datestr(handles.Velfaerdsteknologi.VisData.slutDato));
%         delete(datestr(handles.Velfaerdsteknologi.VisData.startDato));
%     end
    CntRow = 1; 
    ii=1; 
    for i=1:length(match)
        if match(i) ==1  
            if isduration(tt.Data)==1 
                Data(CntRow)=minutes(tt.Data(ii));
            else 
                Data(CntRow)=tt.Data(ii);
            end
                ii = ii+1; 
        else
            Data(CntRow)=0; 
        end
        CntRow=CntRow +1; 
    end
  
    axes(axesTeknologi)
    if strcmp(Vindue,'Plejecentre')==0
       bar(xData,Data);  
    end
    
    if strcmp(Vindue,'Plejecentre')==1
        plot(xData,Data,'-o','LineWidth',2);
        
    end 
    
    %datetick('x','mmm-yy','keeplimits')  
end
    if strcmp(Vindue,'Yderligere')==0
       set(txtAntal,'String',sumAnvendelse);
    end
    
    if strcmp(Vindue,'Yderligere')==1
        YderligereDataFunktioner(handles,ttYderligere,teknologi, Begraensning);
    end

end
