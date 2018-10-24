function handles = SortereTid(handles)

% Finder den teknologi der er trykket på
teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);

% Den valgte periode
periode = get(get(handles.btngroupRedigerGrafTeknologioverblik,'SelectedObject'),'String');

% Den valgte dato
stringDato = get(handles.stDatoTeknologiOverblik,'String');

% Hvis dato ikke valgt, vælges seneste dato 
if isempty(stringDato)
    stringDato = handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt;
end

% 
dateTimeDatoLower = datetime(stringDato,'InputFormat','dd-MM-yyyy');

CntRowMedarbejdere = 1; 

times = [handles.Velfaerdsteknologi.(teknologi).Tidspunkt];
times.Format = 'dd-MM-yyyy';
times = times';
D= [handles.Velfaerdsteknologi.(teknologi).Medarbejdere]';
tt = timetable(times,D,'VariableNames',{'Data'});

%rmmissing(retime(tt,'yearly',@mean))
d=1; 
% if strcmp(periode, 'Dag')==1
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
% end

if strcmp(periode, 'Dag')==0
    switch periode 
        case 'Uge'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month,dateTimeDatoLower.Day-7);
            tt = retime(tt,'daily',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
        case 'Måned'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month-1,dateTimeDatoLower.Day);
            tt = retime(tt,'daily',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            
        case 'År'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year-1,dateTimeDatoLower.Month,dateTimeDatoLower.Day);
            tt = retime(tt,'monthly',@mean);
            S = timerange ( dateTimeDatoUpper,dateTimeDatoLower);
            tt = tt(S,:);
            
% %             for i=1:12 
% %                 d=1;
% %                 for ii = 1:length(month(tt.Data))
% %                     if i == month(tt.times(ii))
% %                        d=1; 
% %                        months(i) =  tt.Data(ii);
% %                        d=1;
% %                     else 
% %                        months(i) = 0; 
% %                     end
% %                 end
% %             end
    end 
    d=1; 

    %dateTimeDatoUpper = datetime(dateTimeDatoLower.Year-1,dateTimeDatoLower.Month,dateTimeDatoLower.Day);
    d=1;  
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
    %datetick('x','mmm','keepticks')
    
    set(handles.txtAntalGangeTeknologioverblik,'String',sum(Medarbejdere));
    d=1;
end

