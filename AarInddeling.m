function [xData, match, tt, sumAnvendelse,Begraensning, startDato] = AarInddeling(slutDato,tt)
        startDato = datetime(slutDato.Year-1,slutDato.Month,slutDato.Day);
        slutDato = datetime(slutDato.Year,slutDato.Month,slutDato.Day+1);
        Begraensning = timerange (startDato,slutDato);    
        tt = tt(Begraensning,:);
        sumAnvendelse = length(tt.times);

        tt = retime(tt,'monthly',@mean);
        count =  [(month(slutDato))+1:12, 1:(month(slutDato))]; 
        match = ismember(count,month(tt.times)); 
        
        tempStart = datetime(startDato.Year,startDato.Month+1,startDato.Day);
        xData = linspace(tempStart,slutDato,12);     
end
