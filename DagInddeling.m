function [sumAnvendelse,Begraensning,DataEksisterer] = DagInddeling(slutDato,stringDato, tt,axesTeknologi)
%DagInddeling begrænser data for en dag og plotter det samt viser data for
%antal gange en teknologi er anvendt. 
%   
%   INPUT: 
%   slutDato = Den dato, data skal vises fra i datetime.
%   stringDato = Den dato, data skal vises fra i string
%   tt = Data der skal op af y-aksen. 
%   axesTeknologi = Aksen hvor data skal plottes. 
%
%   OUTPUT: 
%   sumAnvendelse = Antal gange teknologien er anvendt 
%   Begraensning = Begrænser timetable til en dag. 
%   dato hvor der den seneste data fra, ellers er dette brugervalgt.  
%   DataEksisterer = 1, hvis data ikke eksisterer og 2 hvis det eksisterer. 

    slutTidspunkt = datetime([datestr(stringDato,'dd-mm-yyyy') ' 05:00:00']);
    % startDato findes vha. slutDato og trækker en dag fra. 
    startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
    %Definere data mellem startTidspunkt og slutTidspunkt
    startTidspunkt = startDato + '05:00:00';
    %https://se.mathworks.com/help/matlab/ref/timerange.html
    Begraensning = timerange(char(slutTidspunkt),char(startTidspunkt));
    % https://se.mathworks.com/help/matlab/timetables.html
    tt = tt(Begraensning,:);
    % Antal angiver, antal gange systemet har været i brug om dagen. 
    
    sumAnvendelse = length(tt.Data);
    % Finder gennemsnittet af hver time og sletter rækker hvor der er ingen
    % data
    tt = retime(tt,'hourly',@mean);
    tt = rmmissing(tt);
    
    % Definere x-aksen
    enTime = hours(1);
    x = slutTidspunkt: enTime:startTidspunkt;
    
    % Finder hvilke timer af x-aksen der er data for 
    matchDay = ismember(x,tt.times);
    
    Dag = zeros(1,length(x));
    %Hvis der er data, skal denne data ligges ind i et array eller skal det være lig med 0.  
    CntRowDag=1; 
    i_ttData=1; 
    for i=1:length(matchDay)
        if matchDay(i) ==1 
            %  Hvis det er en varighed, skal minutterne fra tiden hentes. 
            if isduration(tt.Data) ==1
                Dag(CntRowDag)=minutes(tt.Data(i_ttData));
            else
                Dag(CntRowDag)=tt.Data(i_ttData);
            end
            i_ttData = i_ttData+1; 
        else
            Dag(CntRowDag)=0; 
        end
        CntRowDag=CntRowDag +1; 
    end
    
    % Præallokere et categorical array med tidspunkterpådagen
    TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';

    % Tiden bliver placeret indenfor de bestemte intervaller. 
    for i = 1: length(x)
        if hour(x(i))>=5 && hour(x(i))< 9
            TidspunktPaaDagen_Data(i)=TidspunktPaaDagen(1);
        elseif hour(x(i))>=9 && hour(x(i))<11
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(2);
        elseif hour(x(i))>=11 && hour(x(i))<14
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(3);
        elseif hour(x(i))>=14 && hour(x(i))<17
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(4);
        elseif hour(x(i))>=17 && hour(x(i))<23
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(5);
        else %hour(x(i))==23 || hour(x(i))<5
            TidspunktPaaDagen_Data(i)= TidspunktPaaDagen(6);
         end
    end

    %Dette indsættes i en ny timetable
    ttMedTidspunkt = timetable(x',Dag',TidspunktPaaDagen_Data');

    %Beregner summen af alle medarbejder indenfor hvert interval.
    %Var2 er tidspunkt, hvor Va1 angiver antal medarbejdere. 
    meanData = zeros(1, 6);
    CntSum = 1;
    CntData=1; 
    for tidspunkt=1:length(TidspunktPaaDagen)
        data=[];
        for i = 1:size(ttMedTidspunkt)
            if ttMedTidspunkt.Var2(i)==TidspunktPaaDagen(tidspunkt)
                data(CntData) = double(ttMedTidspunkt.Var1(i));
                CntData=CntData+1; 
            end 
        end
        
        if ~all(data == 0)
            index = find(data~=0);
            data = data(index);
        end      
        meanData(CntSum) = mean(data);
        CntSum = CntSum +1;       
    end  
    
    % Hvis der er tal, der ikke er lig med 0, så vil DataEksistere være
    % lige med 1, ellers vil den være lig med 2. 
    if ~any(meanData)
        DataEksisterer =1; 
    else
        DataEksisterer =2; 
    end
    
    axes(axesTeknologi)
    %x-aksen vil sortere det i kategorisk rækkefølge, derfor anvendes
    %reordercats, som indsætter det i den originale rækkefølge. 
    x = reordercats(TidspunktPaaDagen,{'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'});
    bar(x, meanData);

end