function handles = SortereTid(handles)

teknologi = fieldnames(handles.Velfaerdsteknologi);
teknologi = string(teknologi);
d=1; 

periode = get(get(handles.btngroupRedigerGrafTeknologioverblik,'SelectedObject'),'String');


stringDato = get(handles.stDatoTeknologiOverblik,'String');
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
            
        case 'Måned'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year,dateTimeDatoLower.Month-1,dateTimeDatoLower.Day);
            tt = retime(tt,'monthly',@mean);
        case 'År'
            dateTimeDatoUpper = datetime(dateTimeDatoLower.Year-1,dateTimeDatoLower.Month,dateTimeDatoLower.Day);
    end 

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
    bar(times,[handles.Velfaerdsteknologi.(teknologi).Medarbejdere]')
    
    set(handles.txtAntalGangeTeknologioverblik,'String',mean(Medarbejdere));
    d=1;
end

%dateTimeDatoUpper = datetime(stringDato-year(dateTime,'InputFormat','dd-MM-yyyy';

% days = caldays(between(handles.Velfaerdsteknologi.(teknologi).Tidspunkt,dateTimeDato,'days')) < 365;
% d=1; 
% CntRowYear = 1; 
%     for i=1:length(handles.Velfaerdsteknologi.(teknologi))
%         d=1;
%         if year(handles.Velfaerdsteknologi.(teknologi)(i).Tidspunkt) == year(handles.Velfaerdsteknologi.(teknologi)(1).Tidspunkt)
%             YearMedarbejdere(CntRowYear) = handles.Velfaerdsteknologi.(teknologi)(i).Medarbejdere;
%             CntRowYear = 1+CntRowYear; 
%         end
%         d=1;
%     end 
%     set(handles.txtAntalGangeTeknologioverblik,'String',sum(YearMedarbejdere));
%     
%     d=1;
