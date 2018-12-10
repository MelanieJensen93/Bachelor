function [xData, match, tt, sumAnvendelse,Begraensning, startDato] = MaanedInddeling(slutDato,tt)
%MAANEDINDDELING begr�nser data for en m�ned.
%   INPUT: 
%   slutDato = fra denne dato skal den begr�nse data fra. 
%   tt = Data, der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Data hen af x-aksen for en m�ned. 
%   startDato = Dato, hvor data skal stal vises fra. 
%   match = Array fyldt med 0 og 1. Den har st�rrelsen for antal dage p� en
%   m�ned. 1 svarer til der er data for den dag og omvendt for 0. 
%   tt = Data, der skal op af y-aksen for en m�ned. 
%   Begraensning = Interval, som data skal begr�nses til. 
%   sumAnvendelse = Antal gange teknologien bliver anvendt.

    startDato = datetime(slutDato.Year,slutDato.Month-1,slutDato.Day);
    slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day);
    Begraensning = timerange ( startDato,slutDato+1);
    tt = tt(Begraensning,:);
    xData = startDato: day(1):slutDato;
    sumAnvendelse = length(tt.times)/length(xData);
    tt = retime(tt,'daily',@mean);
    tt = rmmissing(tt);
            

    match = ismember(xData,tt.times);
    
end