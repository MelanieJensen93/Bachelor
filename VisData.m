function [startDato, stringDato, DataEksisterer] = VisData(handles, xData, yData, axesTeknologi,Vindue,box2)
%VISDATA plotter data i en graf og udskriver antal gange en teknologi eller
%   sensor er blevet brugt. Hvis yderligere data kalder funktionen vil den
%   istedet udskrive yderligere data.
%   Den inddeler data i den valgte periode, for derefter at plotte dem. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%   xData = Data der skal hen af x-aksen. Tidspunkter 
%   yData = Data der skal op af y-aksen. 
%   axesTeknologi = Aksen hvor data skal plottes. 
%   Vindue = Det vindue/skærm data skal plottes i
%
%   OUTPUT: 
%   startDato = Dato hvor data skal startes vises fra. 
%   stringDato = Dato hvor data skal stal vises til. Pr. default er det den
%   dato hvor der den seneste data fra, ellers er dette brugervalgt. 
%   DataEksisterer = Varibel der er 1, hvis der ikke er data, og er 2, hvis
%   der er data. 

% Hvis data ikke stammer fra det andet plejecenter initialiseret box2. 
if nargin<6
    box2=0;
end

% Teknologien defineres afhængig af hvilken skærm, der kalder funktionen. 
if strcmp(Vindue, 'Plejecentre')
    if nargin == 6
        teknologi = fieldnames(handles.TeknologiOverblik);
        teknologi = string(teknologi(1));
    else 
        teknologi = string(handles.teknologi);
    end    
else 
    teknologi = fieldnames(handles.Velfaerdsteknologi);
    teknologi = string(teknologi(1));
end

% times angiver tidspunkter. 
times = xData';
  
    % Alt efter hvilken skærm der kalder funktionen, så vil perioden, dato
    % og tekstfelter hvor data skal plottes defineres. 
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
            % Hvis den valgte teknologi er Carendo, vil felterne for
            % Carendos funktioner defineres. Derudover vil en timetable
            % oprettes med tidpunkterne samt Carendo funktioner
            if strcmp(teknologi,'Carendo')==1
                Omsorgsfunktion = [handles.Velfaerdsteknologi.(teknologi).Omsorgsfunktion];
                Komfortfunktion = [handles.Velfaerdsteknologi.(teknologi).Komfortfunktion];
                Haevesaenkefunktion = [handles.Velfaerdsteknologi.(teknologi).Haevesaenkefunktion];
                ttYderligere = timetable(tider',Omsorgsfunktion',Komfortfunktion',Haevesaenkefunktion');
            end
            % Hvis den valgte teknologi er Luna, vil feltet LunaMedCarendo defineres. Derudover vil en timetable
            % oprettes med tidpunkterne samt Luna med Carendo
            if strcmp(teknologi,'Luna')==1
                LunaMedCarendo = [handles.Velfaerdsteknologi.(teknologi).LunaMedCarendo];
                ttYderligere = timetable(tider',LunaMedCarendo');
            end 
    end
    
    % Alt efter hvilken periode, der vælges skal skriften på perioden ændre
    % farve til karrygul. 
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
    if strcmp(Vindue,'Yderligere')==1
        stringDato = handles.Velfaerdsteknologi.Yderligere.Dato;
    elseif strcmp(Vindue,'Plejecentre')==1
        stringDato = handles.StringDato;
        stringDato = datetime(datestr(stringDato,'dd-mm-yyyy'));
    else
        stringDato = datetime(datestr(xData(1),'dd-mm-yyyy'));
    end
    
end

%Konvertere dato til en datetime 
slutDato = datetime(stringDato,'InputFormat','dd-MM-yyyy');

%Opretter en timetable, som knytter data til tiderne. 
tt = timetable(times,yData','VariableNames',{'Data'});

% Hvis dag er valgt, skal DagInddeling plotte data for en dag. 
if strcmp(periode, 'Dag')==1
    [sumAnvendelse,Begraensning, DataEksisterer] = DagInddeling(slutDato,stringDato,tt,axesTeknologi);
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
    
    % Hvis et plads i match array er lig med 1, vil data i timetable tt
    % placeres i array Data og hvis ikke det er lig med 0, vil 0 placeres i
    % array Data. 
    CntRow = 1; 
    ii=1; 
    Data = 0;
    for i=1:length(match)
        if match(i) ==1  
            % Før tid kan sammenlignes skal der anvendes minutes rundt om
            % tt.Data 
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
    
    % Her plottes data og 1.aksen justeres alt efter hvilken periode der er
    % valgt. 
    if strcmp(Vindue,'Plejecentre')==0
       if strcmp(periode, 'År')==1   
            bar(xData,Data); 
            axesTeknologi.XTick =xData; 
            % https://se.mathworks.com/help/matlab/ref/datetick.html
            datetick('x','mmm','keepticks')
       elseif strcmp(periode,'Måned')==1
            bar(xData,Data); 
            xDataDag = linspace(startDato,slutDato,7);
            axesTeknologi.XTick =xDataDag; 
            %https://se.mathworks.com/help/matlab/ref/datetick.html
            datetick('x','dd-mmm','keepticks')
       else
           bar(xData,Data); 
       end               
    end
    
    % Hvis det er Sammenlign med Andre Plejecentre skærm der kalder, skal
    % kurvediagram plottes. 
    if strcmp(Vindue,'Plejecentre')==1
        %https://se.mathworks.com/matlabcentral/answers/151011-how-to-plot-a-line-of-a-certian-color
        colorspec = {[0.69, 0.49, 0]; [0.69, 0, 0.21]};
        
        if nargin == 6
            plot(xData,Data,'-o','Color',colorspec{1},'LineWidth',2);
        else 
            plot(xData,Data,'-o','Color',colorspec{2},'LineWidth',2);
        end
        %1.aksen justeres alt efter hvilken periode der er
        % valgt. 
        if strcmp(periode, 'År')==1   
            axesTeknologi.XTick =xData; 
            %https://se.mathworks.com/help/matlab/ref/datetick.html
            datetick('x','mmm','keepticks')
        elseif strcmp(periode,'Måned')==1
            xDataDag = linspace(startDato,slutDato,7);
            axesTeknologi.XTick =xDataDag; 
            %https://se.mathworks.com/help/matlab/ref/datetick.html
            datetick('x','dd-mmm','keepticks')
        end
    end 

end
% Her sættes antal gange teknologien anvendes på "Sensor Overblik Skærm",
% "Teknologi Overblik Skærm" og "Sammenlign med Andre Plejecentre Skærm"
    if strcmp(Vindue,'Yderligere')==0
       if strcmp(Vindue,'Teknologi')==1 || strcmp(Vindue,'Plejecentre')==1
           if box2==0
               set(txtAntal,'String',string(sumAnvendelse));
           else
               set(handles.txtTeknologiOverblikPlejecenter,'String',string(sumAnvendelse));
           end 
       else 
           set(txtAntal,'String',string(sumAnvendelse));
       end
    end
    
    % Hvis "Yderligere Data Skærm" kalder funktionen VisData vil yderligere
    % data i procent beregnes og tilføjes i de enkelte tekstbokse. 
    if strcmp(Vindue,'Yderligere')==1
        YderligereDataFunktioner(handles,ttYderligere,teknologi, Begraensning);
    end
    
    % Hvis der ikke er data sættes data lig med 1 og hvis der er sættes det
    % lig med 2. 
    if strcmp(periode, 'Dag')==0
        if  ~any(Data)
            DataEksisterer = 1; 
            %msgbox('Der er ikke data for den valgte periode');
        else 
            DataEksisterer = 2; 
        end
    end
end
