function [xData, match, tt, sumAnvendelse,Begraensning, startDato] = AarInddeling(slutDato,tt)
%MAANEDINDDELING begr�nser data for en m�ned.
%   INPUT: 
%   slutDato = fra denne dato skal den begr�nse data fra. 
%   tt = Data, der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Data hen af x-aksen for et �r. 
%   startDato = Dato, hvor data skal stal vises fra. 
%   match = Array fyldt med 0 og 1. Den har st�rrelsen for antal m�neder p�
%   et �r. 1 svarer til der er data for den dag og omvendt for 0. 
%   tt = Data, der skal op af y-aksen for et �r. 
%   Begraensning = Interval, som data skal begr�nses til. 
%   sumAnvendelse = Antal gange teknologien bliver anvendt.        
        % Dato, hvor fra data skal vises defineres.        
        startDato = datetime(slutDato.Year-1,slutDato.Month,slutDato.Day);
        % Dato hvor til data skal vises defineres.
        slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
        %timetable blive begr�nset til denne periode
        %https://se.mathworks.com/help/matlab/ref/timerange.html
        Begraensning = timerange (startDato,slutDato);    
        % https://se.mathworks.com/help/matlab/timetables.html
        tt = tt(Begraensning,:);
        % En m�ned efter startDato, s�ledes et �r f.eks. er defineret som
        % nov 2018 - okt 2019 og ikke fra okt 2018 - okt 2019
        tempStart = datetime(startDato.Year,startDato.Month+1,startDato.Day);
        %timetable blive begr�nset til denne periode
        xData = linspace(tempStart,slutDato,12);   
        %Antal gange teknologi anvendes pr. dag beregnes. 
        sumAnvendelse = length(tt.times)/365;
        % Finder det gennemsnitlig v�rdi pr. m�ned. 
        tt = retime(tt,'monthly',@mean);
        % S�tter m�ned sammen s� den ikke t�ller fra 1, 2 3, men det hedder
        % 11 12 1 2 
        count =  [(month(slutDato))+1:12, 1:(month(slutDato))]; 
        % match er et array, der indeholder 1, hvis der er data for
        % tidspunktet i xData og ellers indeholde den 0. 
        match = ismember(count,month(tt.times)); 
  
end
