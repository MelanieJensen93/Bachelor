function handles = SortereTid(handles, data, axesTeknologi)

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

dateTimeDatoLower = datetime(stringDato,'InputFormat','dd-MM-yyyy');



times = [handles.Velfaerdsteknologi.(teknologi).Tidspunkt];
times.Format = 'dd-MM-yyyy HH:mm:ss';
times = times';

switch data 
    case 'Medarbejdere'
        D= [handles.Velfaerdsteknologi.(teknologi).Medarbejdere]';
    case 'Varighed'
        D = [handles.Velfaerdsteknologi.(teknologi).Varighed]';
        infmt = 'mm:ss';
        D = duration(D,'InputFormat',infmt); 
end

tt = timetable(times,D,'VariableNames',{'Data'});
d=1; 

if strcmp(periode, 'Dag')==1
    d=1; 
    dateTimeDatoLower.Format  = 'dd-MM-yyy';
    dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month,dateTimeDatoLower.Day-1);
    first = dateTimeDatoUpper + '05:00:00';
    last = dateTimeDatoLower + '05:00:00';
    S = timerange(char(first),char(last));
           
    tt = tt(S,:);
    tt = retime(tt,'hourly',@mean);
    tt = rmmissing(tt);
           
    x = first: hourOne:last;
    d=1; 
    %hoursIntimes = hour(tt.times);
    %mins = minute(tt.times);
    %secs = second(tt.times);
    matchDay = ismember(x,tt.times);
    %matchDayVarig = ismember(x,tV.times);
    CntRowDag=1; 
    iiDag=1; 
        for i=1:length(matchDay)
            if matchDay(i) ==1 
                d=1; 
                if isduration(tt.Data) ==1
                    Dag(CntRowDag)=minutes(tt.Data(iiDag));
                else
                    Dag(CntRowDag)=tt.Data(iiDag);
                end
                
                iiDag = iiDag+1; 
            else
                Dag(CntRowDag)=0; 
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
    tab_new_all = timetable(x',Dag',category_interval_data');
    
    d=1;    

    CntSum = 1;
    CntData=1; 
    for category=1:length(category_inteval)
        data =[];
        for i = 1:size(tab_new_all)
            if tab_new_all.Var2(i)==category_inteval(category)
                data(CntData) = double(tab_new_all.Var1(i));
                CntData=CntData+1; 
                d=1; 
            end
            d=1; 
        end
            sumData(CntSum) = sum(data);
            CntSum = CntSum +1; 
    end
    d=1; 
    
    axes(axesTeknologi)
    x = reordercats(category_inteval,{'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'});
    d=1; 
    bar(x, sumData);
    set(handles.txtAntalGangeTeknologioverblik,'String',length(tt.Data));

end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Uge'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month,dateTimeDatoLower.Day-7);
            d=1; 
            tt = retime(tt,'daily',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            CntRowMedarbejdere = 1; 
            match =(times>=dateTimeDatoUpper & times<dateTimeDatoLower);
            d=1;  
            ii = 1; 
%             for i = 1:length(match)
%                 d=1; 
%                 if match(i)==1
%                     DataUge(CntRowMedarbejdere) = tt.Data(ii);
%                     ii=ii+1;
%                     d=1; 
%                 else 
%                     DataUge(CntRowMedarbejdere)=0; 
%                     d=1; 
%                 end
%                  CntRowMedarbejdere = 1+CntRowMedarbejdere;
%             end
            tt = rmmissing(tt);
            d=1; 
            axes(axesTeknologi)
            bar(tt.times,tt.Data)
            set(handles.txtAntalGangeTeknologioverblik,'String',length(tt.Data));
            
        case 'Måned'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month-1,dateTimeDatoLower.Day);
            tt = retime(tt,'daily',@mean);
            d=1;  
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            match =(times>=dateTimeDatoUpper & times<dateTimeDatoLower);
            d=1;  
            ii =1; 
            CntRow=1; 
            for i = 1:length(match)
                if match(i)==1
                    DataMaaned(CntRow) = tt.Data(ii);
                    ii=1+ii; 
                else 
                    DataMaaned(CntRow)=0; 
                end 
                CntRow=1+CntRow; 
            end
            d=1; 
            axes(axesTeknologi)
            bar(tt.times,tt.Data)
            d=1; 
            tt = rmmissing(tt);
            if isduration(tt.Data)==1
                meanValue = mean(minutes(tt.Data)); 
            else
                meanValue = mean(tt.Data);
            end
            set(handles.txtAntalGangeTeknologioverblik,'String',length(tt.Data));

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
                    if isduration(tt.Data)==1 
                        DataAar(CntRow)=minutes(tt.Data(ii));
                    else 
                        DataAar(CntRow)=tt.Data(ii);
                    end
                    ii = ii+1; 
                else
                    DataAar(CntRow)=0; 
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
            axes(axesTeknologi)
            d=1;
            bar(xData,DataAar);  
            datetick('x','mmm-yy','keeplimits')
            d=1;           
            set(handles.txtAntalGangeTeknologioverblik,'String',length(tt.Data));
    end 
    d=1;
end

