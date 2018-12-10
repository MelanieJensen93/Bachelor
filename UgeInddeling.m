function [xData, match, tt, sumAnvendelse,Begraensning,startDato] = UgeInddeling(slutDato,tt)
%UGEINDDELING begrænser data for en uge.
%   INPUT: 
%   slutDato = fra denne dato skal den begrænse data fra. 
%   tt = Data, der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Data hen af x-aksen for en uge.  
%   startDato = Dato, hvor data skal stal vises fra. 
%   match = Array fyldt med 0 og 1. Den har størrelsen for antal dage på en
%   uge. 1 svarer til der er data for den dag og omvendt for 0. 
%   tt = Data, der skal op af y-aksen for en måned. 
%   Begraensning = Interval, som data skal begrænses til. 
%   sumAnvendelse = Antal gange teknologien bliver anvendt.
    startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day-7);
    slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day);
    Begraensning = timerange (startDato,slutDato+1);
    tt = tt(Begraensning,:);
    xData=startDato:day(1):slutDato;
    sumAnvendelse = length(tt.times)/length(xData);
    tt = retime(tt,'daily',@mean);
    tt = rmmissing(tt);
    match = ismember(xData,tt.times);

end