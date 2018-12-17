function [xData, match, tt, sumAnvendelse,Begraensning, startDato] = AarInddeling(slutDato,tt)
%MAANEDINDDELING begrænser data for en måned.
%   INPUT: 
%   slutDato = fra denne dato skal den begrænse data fra. 
%   tt = Data, der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Data hen af x-aksen for et år. 
%   startDato = Dato, hvor data skal stal vises fra. 
%   match = Array fyldt med 0 og 1. Den har størrelsen for antal måneder på
%   et år. 1 svarer til der er data for den dag og omvendt for 0. 
%   tt = Data, der skal op af y-aksen for et år. 
%   Begraensning = Interval, som data skal begrænses til. 
%   sumAnvendelse = Antal gange teknologien bliver anvendt.        
        % Dato, hvor fra data skal vises defineres.        
        startDato = datetime(slutDato.Year-1,slutDato.Month,slutDato.Day);
        % Dato hvor til data skal vises defineres.
        slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
        %timetable blive begrænset til denne periode
        %https://se.mathworks.com/help/matlab/ref/timerange.html
        Begraensning = timerange (startDato,slutDato);    
        % https://se.mathworks.com/help/matlab/timetables.html
        tt = tt(Begraensning,:);
        % En måned efter startDato, således et år f.eks. er defineret som
        % nov 2018 - okt 2019 og ikke fra okt 2018 - okt 2019
        tempStart = datetime(startDato.Year,startDato.Month+1,startDato.Day);
        %timetable blive begrænset til denne periode
        xData = linspace(tempStart,slutDato,12);   
        %Antal gange teknologi anvendes pr. dag beregnes. 
        sumAnvendelse = length(tt.times)/365;
        % Finder det gennemsnitlig værdi pr. måned. 
        tt = retime(tt,'monthly',@mean);
        % Sætter måned sammen så den ikke tæller fra 1, 2 3, men det hedder
        % 11 12 1 2 
        count =  [(month(slutDato))+1:12, 1:(month(slutDato))]; 
        % match er et array, der indeholder 1, hvis der er data for
        % tidspunktet i xData og ellers indeholde den 0. 
        match = ismember(count,month(tt.times)); 
  
end
