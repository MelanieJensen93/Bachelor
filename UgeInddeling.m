function [xData, match, tt, sumAnvendelse,Begraensning,startDato] = UgeInddeling(slutDato,tt)
%UGEINDDELING begr�nser data for en uge.
%   INPUT: 
%   slutDato = fra denne dato skal den begr�nse data fra. 
%   tt = Data, der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Data hen af x-aksen for en uge.  
%   startDato = Dato, hvor data skal stal vises fra. 
%   match = Array fyldt med 0 og 1. Den har st�rrelsen for antal dage p� en
%   uge. 1 svarer til der er data for den dag og omvendt for 0. 
%   tt = Data, der skal op af y-aksen for en m�ned. 
%   Begraensning = Interval, som data skal begr�nses til. 
%   sumAnvendelse = Antal gange teknologien bliver anvendt.

    % Dato hvor fra data skal vises defineres.
    startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day-7);
    % Dato hvor til data skal vises defineres.
    slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day);
    %https://se.mathworks.com/help/matlab/ref/timerange.html
    Begraensning = timerange (startDato,slutDato+1);
    % https://se.mathworks.com/help/matlab/timetables.html
    %timetable blive begr�nset til denne periode
    tt = tt(Begraensning,:);
    %Data til x-akse defineres. Denne starter fra startDato til slutDato,
    %med en dag imellem.
    xData=startDato:day(1):slutDato;
    %Antal gange teknologi anvendes pr. dag beregnes. 
    sumAnvendelse = length(tt.times)/length(xData);
    % Finder det gennemsnitlig v�rdi pr. dag. 
    tt = retime(tt,'daily',@mean);
     % Sletter r�kker, hvor der ikke er data for den dag. 
    tt = rmmissing(tt);
    % match er et array, der indeholder 1, hvis der er data for
    % tidspunktet i xData og ellers indeholde den 0. 
    match = ismember(xData,tt.times);

end