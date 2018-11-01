function handles = SortereTid(handles,xData, yData, axesTeknologi, Vindue)
d=1; 
% Finder den teknologi der er trykket på
% teknologi = fieldnames(handles.Velfaerdsteknologi);
% teknologi = string(teknologi);
enTime = hours(1);
d=1; 

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
end
% Hvis dato ikke valgt, vælges seneste dato 
if isempty(stringDato)
    %stringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
    stringDato = xData(1);
    d=1;
end
d=1; 
%Konvertere dato til en datetime 
slutDato = datetime(stringDato,'InputFormat','dd-MM-yyyy');

times = xData';

%times.Format = 'dd-MM-yyyy HH:mm:ss';
 
% Data hentes alt efter den data der skal vises. 
% switch data 
%     case 'Medarbejdere'
%         D= [handles.Velfaerdsteknologi.(teknologi).Medarbejdere]';
%         d=1;
%     case 'Varighed'
%         D = [handles.Velfaerdsteknologi.(teknologi).Varighedforarbejdsgang]';
%         %Idet at det er en tid så skal det skrives ud i typen duration med
%         %følgende format. 
%         infmt = 'mm:ss';
%         D = duration(D,'InputFormat',infmt); 
% end

%Opretter en timetable, som knytter data til tiderne. 
tt = timetable(times,yData','VariableNames',{'Data'});

%Hvis den valgte periode er dag skal der ske følgende
if strcmp(periode, 'Dag')==1
    d=1;
    slutDato.Format  = 'dd-MM-yyy 05:00:00';
    slutTidspunkt = slutDato;
    % startDato findes vha. slutDato og trækker en dag fra. 
    startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
    %Definere data mellem startTidspunkt og slutTidspunkt
    startTidspunkt = startDato + '05:00:00';
    %slutTidspunkt = slutDato + '05:00:00';
    d=1;
    Begraensning = timerange(char(slutTidspunkt),char(startTidspunkt));    
    tt = tt(Begraensning,:);
    % Antal angiver, antal gange systemet har været i brug om dagen. 
    Antal = length(tt.Data);
    d=1;
    
    % Finder gennemsnittet af hver time og sletter rækker hvor der er ingen
    % data
      tt = retime(tt,'hourly',@mean);
      tt = rmmissing(tt);
    
    % Definere x-aksen
    x = slutTidspunkt: enTime:startTidspunkt;
    
    % Finder hvilke timer af x-aksen der er data for 
    matchDay = ismember(x,tt.times);
    
    Dag = zeros(1,length(x));
    %Hvis der er data skal data ligges ind i et array eller skal det være lig med 0.  
    CntRowDag=1; 
    iiDag=1; 
    for i=1:length(matchDay)
        if matchDay(i) ==1 
            d=1; 
            %  Hvis det er en varighed, skal minutterne fra tiden hentes. 
            if isduration(tt.Data) ==1
                Dag(CntRowDag)=minutes(tt.Data(iiDag));
            else
                Dag(CntRowDag)=tt.Data(iiDag);
            end
            iiDag = iiDag+1; 
        else
            Dag(CntRowDag)=0; 
        end
        CntRowDag=CntRowDag +1; 
    end
    
    % Præallokere et categorical array med tidspunkterpådagen
    TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
    d=1; 
    
    % Tiden bliver placeret indenfor de bestemte intervaller. 
    for i = 1: length(x)
        if hour(x(i))>=5 && hour(x(i))< 9
            d=1; 
            TidspunktPaaDagen_Data(i)=TidspunktPaaDagen(1);
        elseif hour(x(i))>=9 && hour(x(i))<11
            d=1; 
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(2);
        elseif hour(x(i))>=11 && hour(x(i))<14
            d=1; 
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(3);
        elseif hour(x(i))>=14 && hour(x(i))<17
            d=1; 
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(4);
        elseif hour(x(i))>=17 && hour(x(i))<23
            d=1; 
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(5);
        else %hour(x(i))==23 || hour(x(i))<5
            d=1; 
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(6);
         end
    end

    d=1; 
    %Dette indsættes i en ny timetable
    ttMedTidspunkt = timetable(x',Dag',TidspunktPaaDagen_Data');
    
    d=1;  
    
    %Beregner summen af alle medarbejder indenfor hvert interval.
    %Var2 er tidspunkt, hvor Va1 angiver antal medarbejdere. 
    CntSum = 1;
    CntData=1; 
    for tidspunkt=1:length(TidspunktPaaDagen)
        data =[];
        for i = 1:size(ttMedTidspunkt)
            if ttMedTidspunkt.Var2(i)==TidspunktPaaDagen(tidspunkt)
                data(CntData) = double(ttMedTidspunkt.Var1(i));
                CntData=CntData+1; 
                d=1; 
            end
            d=1; 
        end
        d=1;
        %Beregner summen af data indenfor et bestemt tidspunkt
        sumData(CntSum) = sum(data);
        CntSum = CntSum +1; 
    end
%     d=1;
%     A=find(ttMedTidspunkt.Var1~=0)
%     d=1;
%     
%     Row = 1; 
% 
%         for i=1:length(A)
%             Data(Row) = ttMedTidspunkt.Var2(A(i));
%             Row = Row+1; 
%         end
d=1; 
    axes(axesTeknologi)
    %x-aksen vil sortere det i kategorisk rækkefølge, derfor anvendes
    %reordercats, som indsætter det i den originale rækkefølge. 
    x = reordercats(TidspunktPaaDagen,{'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'});
    d=1; 
    bar(x, sumData);
    set(txtAntal,'String',Antal);

end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Uge'
            
            startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day-7);
            slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
            d=1;
            Begraensning = timerange ( startDato,slutDato);
            tt = tt(Begraensning,:);
            [C,~,ic]=unique(day(tt.times));
            a_accounts = accumarray(ic,1);
            value = [C,a_accounts];
            d=1; 
            sumAnvendelse = length(tt.times);
            x=startDato:day(1):slutDato;
            tt = retime(tt,'daily',@mean);
            CntRowMedarbejdere = 1; 
            match =(times>=startDato & times<slutDato);
            d=1;  
            ii = 1; 
            tt = retime(tt,'daily',@mean);
%             for i = 1:length(match)
%                 d=1; 
%                 if match(i)==1
%                     DataUge(CntRowMedarbejdere) = tt.Data(ii);
%                     ii=ii+1;
%                     d=1; 
%                 else 
%                     DataUge(CntRowMedarbejdere)=0; 
%                     d=1; 
%                 end
%                  CntRowMedarbejdere = 1+CntRowMedarbejdere;
%             end
            tt = rmmissing(tt);
            d=1; 
            axes(axesTeknologi)
            bar(tt.times,tt.Data)
            set(txtAntal,'String',sumAnvendelse);
            
        case 'Måned'
            d=1; 
            
            startDato = datetime(slutDato.Year,slutDato.Month-1,slutDato.Day);
            slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
            d=1; 
            Begraensning = timerange ( startDato,slutDato);
            tt = tt(Begraensning,:);
            d=1; 
            [C,~,ic]=unique(day(tt.times));
            a_accounts = accumarray(ic,1);
            value = [C,a_accounts];
            sumAnvendelse = length(tt.times);
            
            d=1;  
          
            tt = retime(tt,'daily',@mean);
            d=1; 
            tt = rmmissing(tt);
            
            x = startDato: day(1):slutDato;
            %match =(times>=startDato & times<slutDato);
            match = ismember(x,tt.times);
            d=1;  
            ii =1; 
            CntRow=1; 
            for i = 1:length(match)
                if match(i)==1
                    if isduration(tt.Data(ii))==1 
                        DataMaaned(CntRow) = minutes(tt.Data(ii));
                        ii=1+ii; 
                    else 
                        DataMaaned(CntRow) = tt.Data(ii); 
                    end    
                else 
                    DataMaaned(CntRow)=0; 
                end 
                CntRow=1+CntRow; 
            end
            d=1; 
            axes(axesTeknologi)
            bar(x,DataMaaned)
            d=1; 
            tt = rmmissing(tt);
            if isduration(tt.Data)==1
                meanValue = mean(minutes(tt.Data)); 
            else
                meanValue = mean(tt.Data);
            end
            d=1;
            set(txtAntal,'String',sumAnvendelse);
            
        case 'År'
            startDato = datetime(slutDato.Year-1,slutDato.Month+1,slutDato.Day);
            slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
            Begraensning = timerange ( startDato,slutDato);    
            tt = tt(Begraensning,:);
            
            [C,~,ic]=unique(month(tt.times));
            a_accounts = accumarray(ic,1);
            value = [C,a_accounts];
            d=1; 
            sumAnvendelse = length(tt.times);
           
            tt = retime(tt,'monthly',@mean);
            count =  [(month(slutDato))+1:12, 1:(month(slutDato))];
            d=1;  
            matchYear = ismember(count,month(tt.times));
            d=1; 
            CntRow=1; 
            ii=1; 
            for i=1:length(matchYear)
                if matchYear(i) ==1 
                    d=1; 
                    if isduration(tt.Data)==1 
                        DataAar(CntRow)=minutes(tt.Data(ii));
                    else 
                        DataAar(CntRow)=tt.Data(ii);
                    end
                    ii = ii+1; 
                else
                    DataAar(CntRow)=0; 
                end
                CntRow=CntRow +1; 
            end
            
            d=1; 
%             if month(tt.times(1))==1
%                 sorteret=matchYear;
%             else
%                 months = month(slutDato);
%                 sorteret=[matchYear(month(tt.times(1)):end),matchYear(1:month(tt.times(1))-1)];
%             end
            xData = linspace(startDato,slutDato,12);
            d=1;
            axes(axesTeknologi)
            d=1;
            bar(xData,DataAar);  
            datetick('x','mmm-yy','keeplimits')
            d=1;           
            set(txtAntal,'String',sumAnvendelse);
    end 
    d=1;
end

