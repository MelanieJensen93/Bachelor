function [xData, match, tt, sumAnvendelse,Begraensning, startDato] = MaanedInddeling(slutDato,tt)
%MaanedInddeling begrænser data for en måned.
%   INPUT: 
%   slutDato = fra denne dato skal den begrænse data fra. 
%   tt = Data der skal op af y-aksen. 
%
%   OUTPUT: 
%   xData = Dato hvor data skal startes vises fra. 
%   stringDato = Dato hvor data skal stal vises til. Pr. default er det den
%   dato hvor der den seneste data fra, ellers er dette brugervalgt. 
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