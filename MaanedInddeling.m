function [xData, match, tt, sumAnvendelse] = MaanedInddeling(slutDato,tt)
    startDato = datetime(slutDato.Year,slutDato.Month-1,slutDato.Day);
    slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
    Begraensning = timerange ( startDato,slutDato);
    tt = tt(Begraensning,:);
    sumAnvendelse = length(tt.times);
    tt = retime(tt,'daily',@mean);
    tt = rmmissing(tt);
            
    xData = startDato: day(1):slutDato;
    match = ismember(xData,tt.times);
end