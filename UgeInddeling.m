function [xData, match, tt, sumAnvendelse,Begraensning,startDato] = UgeInddeling(slutDato,tt)
    startDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day-7);
    slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day);
    Begraensning = timerange (startDato,slutDato+1);
    tt = tt(Begraensning,:);
    sumAnvendelse = length(tt.times);
    xData=startDato:day(1):slutDato;
    tt = retime(tt,'daily',@mean);
    tt = rmmissing(tt);
    match = ismember(xData,tt.times);

end