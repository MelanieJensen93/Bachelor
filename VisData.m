function handles = VisData(handles, xData)
    teknologi = fieldnames(handles.Velfaerdsteknologi);
    teknologi = string(teknologi);
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
            d=1;
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
    %             set(handles.txtLunaMedCarendoYderligere, 'Visible', 'off');
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
    
% Hvis dato ikke valgt, vælges seneste dato 
if isempty(stringDato)
    %stringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
    stringDato = xData(1);
end

%Konvertere dato til en datetime 
slutDato = datetime(stringDato,'InputFormat','dd-MM-yyyy');

%Opretter en timetable, som knytter data til tiderne. 
tt = timetable(times,yData','VariableNames',{'Data'});

if strcmp(periode, 'Dag')==1
    handles = DagInddeling(startDato,tt);
end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Måned'
            [xData, match, tt, sumAnvendelse] = AarInddeling(slutDato,tt);
        case 'År'
            [xData, match, tt, sumAnvendelse] = AarInddeling(slutDato,tt);
            
    end
    
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
    bar(xData,Data);  
    datetick('x','mmm-yy','keeplimits')  
    
    if strcmp(Vindue,'Yderligere')==0
       set(txtAntal,'String',sumAnvendelse);
    end
end
