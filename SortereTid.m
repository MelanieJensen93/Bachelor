function handles = SortereTid(handles)

% Finder den teknologi der er trykket på
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
hourOne = hours(1);

% Den valgte periode
periode = get(get(handles.btngroupRedigerGrafTeknologioverblik,'SelectedObject'),'String');

% Den valgte dato
stringDato = get(handles.stDatoTeknozlogiOverblik,'String');

% Hvis dato ikke valgt, vælges seneste dato 
if isempty(stringDato)
    stringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
end

% 
dateTimeDatoLower = datetime(stringDato,'InputFormat','dd-MM-yyyy');

CntRowMedarbejdere = 1; 

times = [handles.Velfaerdsteknologi.(teknologi).Tidspunkt];
times.Format = 'dd-MM-yyyy HH:mm:ss';
times = times';
D= [handles.Velfaerdsteknologi.(teknologi).Medarbejdere]';
tt = timetable(times,D,'VariableNames',{'Data'});
d=1; 
d=1; 
if strcmp(periode, 'Dag')==1
    dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month,dateTimeDatoLower.Day-1);
    first = dateTimeDatoUpper + '05:00:00';
    last = dateTimeDatoLower + '05:00:00';
    S = timerange(char(dateTimeDatoUpper + '05:00:00'),char(dateTimeDatoLower + '05:00:00'));
    tt = tt(S,:);
    tt = retime(tt,'hourly',@mean);
    tt = rmmissing(tt);
           
    x = first: hourOne:last;
    d=1; 
    %hoursIntimes = hour(tt.times);
    %mins = minute(tt.times);
    %secs = second(tt.times);
    matchDay = ismember(x,tt.times);
    CntRowDag=1; 
    iiDag=1; 
            for i=1:length(matchDay)
                if matchDay(i) ==1 
                    d=1; 
                    MedarbejdereDag(CntRowDag)=tt.Data(iiDag);
                    iiDag = iiDag+1; 
                else
                    MedarbejdereDag(CntRowDag)=0; 
                end
                CntRowDag=CntRowDag +1; 
            end
        
    d=1; 
    
    category_inteval = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
    d=1; 
    for i = 1: length(x)
        if hour(x(i))>=5 && hour(x(i))< 9
            d=1; 
            category_interval_data(i)=category_inteval(1);
        else if hour(x(i))>=9 && hour(x(i))<11
                d=1; 
                category_interval_data(i)= category_inteval(2);
            else if hour(x(i))>=11 && hour(x(i))<14
                    d=1; 
                    category_interval_data(i)= category_inteval(3);
                else if hour(x(i))>=14 && hour(x(i))<17
                        d=1; 
                        category_interval_data(i)= category_inteval(4);
                    else if hour(x(i))>=17 && hour(x(i))<23
                            d=1; 
                            category_interval_data(i)= category_inteval(5);
                        else if hour(x(i))==23 || hour(x(i))<5
                                d=1; 
                                category_interval_data(i)= category_inteval(6);
                            end
                        end
                    end
                end
            end
        end
    end
    d=1; 
    tab_new_all = timetable(x',MedarbejdereDag',category_interval_data');
    
    d=1;    
    
    %if tab_new_all
                            
                  
                    
%     d=1; 
%     match = (times <= dateTimeDatoLower & times >= dateTimeDatoLower );
%     d=1; 
%     for i =1:length(times)
%         d=1; 
%         
%         if dateTimeDatoLower == times(i)
%             
%             Medarbejdere(CntRowMedarbejdere) = handles.Velfaerdsteknologi.(teknologi)(i).Medarbejdere;
%         end 
% %         if match(i) ==1 
% %             d=1; 
% %             Medarbejdere(CntRowMedarbejdere) = handles.Velfaerdsteknologi.(teknologi)(i).Medarbejdere;
% %         end
% % %         d=1;
% %     end
%     Medarbejdere(CntRowMedarbejdere) =mean(Medarbejdere);
%     d=1; 
end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Uge'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month,dateTimeDatoLower.Day-7);
            tt = retime(tt,'daily',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            
            match =(times>=dateTimeDatoUpper & times<dateTimeDatoLower);
            d=1;  
            for i = 1:length(match)
                if match(i)==1
                    Medarbejdere(CntRowMedarbejdere) = handles.Velfaerdsteknologi.(teknologi)(i).Medarbejdere;
                    CntRowMedarbejdere = 1+CntRowMedarbejdere;
                end
            end
            d=1; 
            axes(handles.axesMedarbejdereTeknologiOverblik)
            bar(tt.times,tt.Data)
            set(handles.txtAntalGangeTeknologioverblik,'String',sum(Medarbejdere));
            
        case 'Måned'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month-1,dateTimeDatoLower.Day);
            tt = retime(tt,'daily',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            
            match =(times>=dateTimeDatoUpper & times<dateTimeDatoLower);
            d=1;  
            for i = 1:length(match)
                if match(i)==1
                    Medarbejdere(CntRowMedarbejdere) = handles.Velfaerdsteknologi.(teknologi)(i).Medarbejdere;
                    CntRowMedarbejdere = 1+CntRowMedarbejdere;
                end
            end
            d=1; 
            axes(handles.axesMedarbejdereTeknologiOverblik)
            bar(tt.times,tt.Data)
            set(handles.txtAntalGangeTeknologioverblik,'String',sum(Medarbejdere));

        case 'År'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year-1,dateTimeDatoLower.Month+1,dateTimeDatoLower.Day);
            tt = retime(tt,'monthly',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            
            tt = tt(S,:);
           
            count =  [(month(dateTimeDatoLower))+1:12, 1:(month(dateTimeDatoLower))];
            d=1;  
            matchYear = ismember(count,month(tt.times));
            d=1; 
            CntRow=1; 
            ii=1; 
            for i=1:length(matchYear)
                if matchYear(i) ==1 
                    d=1; 
                    MedarbejdereAar(CntRow)=tt.Data(ii);
                    ii = ii+1; 
                else
                    MedarbejdereAar(CntRow)=0; 
                end
                CntRow=CntRow +1; 
            end
            
            d=1; 
%             if month(tt.times(1))==1
%                 sorteret=matchYear;
%             else
%                 months = month(dateTimeDatoLower);
%                 sorteret=[matchYear(month(tt.times(1)):end),matchYear(1:month(tt.times(1))-1)];
%             end
            xData = linspace(dateTimeDatoUpper,dateTimeDatoLower,12);
            d=1;
            axes(handles.axesMedarbejdereTeknologiOverblik)
            d=1;
            bar(xData,MedarbejdereAar);  
            datetick('x','mmm-yy','keeplimits')
            d=1;           
            set(handles.txtAntalGangeTeknologioverblik,'String',mean(tt.Data));
    end 
    

    d=1;
end

