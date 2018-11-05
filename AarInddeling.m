function [xData, match, tt, sumAnvendelse,Begraensning] = AarInddeling(slutDato,tt)
        startDato = datetime(slutDato.Year-1,slutDato.Month+1,slutDato.Day);
        slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
        Begraensning = timerange (startDato,slutDato);    
        tt = tt(Begraensning,:);
        sumAnvendelse = length(tt.times);

        tt = retime(tt,'monthly',@mean);
        count =  [(month(slutDato))+1:12, 1:(month(slutDato))]; 
        match = ismember(count,month(tt.times)); 
        
        xData = linspace(startDato,slutDato,12);
        
end
