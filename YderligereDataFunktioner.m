function YderligereDataFunktioner(handles,ttYderligere, teknologi, Begraensning)
%YDERLIGEREDATAFUNKTIONER begrænser data for en måned samt beregner
%procenter for en af teknologiens aktiviteter ud af den samlede teknologis
%aktivitet 
%
%   INPUT: 
%   handles = handles til elementer i GUI. 
%   ttYderligere = Data for yderligere data, der skal begrænses. 
%   teknologi = Den teknologi den skal beregne procenter for. 
%   Begraesning = Interval, ttYderligere bliver begrænset til. 
        
        % Begrænser ttYderligere i perioden 
        ttYderligere = ttYderligere(Begraensning,:);
        % Hvis den valgte teknologi er Carendo, vil funktionerne
        % Omsorgsfunktion, komfortfunktion og hævesænkefunktion udregnes,
        % som gennemsnit af antal gange de bliver brugt. 
        if strcmp(teknologi,'Carendo')==1 
            Omsorgsfunktion = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            Komfortfunktion = (sum(ttYderligere.Var2)/length(ttYderligere.Var2))*100;
            Haevesaenkefunktion = (sum(ttYderligere.Var3)/length(ttYderligere.Var3))*100;
            % Hvis procenten ikke er nul, vil den udskrives på Yderligere
            % Data Skærm, ellers vil den udskrive Ingen Data. Dette er
            % gældende for alle funktioner. 
            if ~isnan(Omsorgsfunktion)
                textLabel = sprintf('%s %%', string(round(Omsorgsfunktion)));
                set(handles.txtOmsorgsfunktionYderligere,'String',textLabel);
            else
                set(handles.txtOmsorgsfunktionYderligere,'String','Ingen Data');
            end
            
            if ~isnan(Komfortfunktion)
                textLabel = sprintf('%s %%', string(round(Komfortfunktion)));
                set(handles.txtKomfortfunktionYderligere,'String',textLabel);
            else
                set(handles.txtKomfortfunktionYderligere,'String','Ingen Data');
            end
            
            if ~isnan(Haevesaenkefunktion)
                textLabel = sprintf('%s %%', string(round(Haevesaenkefunktion)));
                set(handles.txtHaeveSaenkefunktionYderligere,'String',textLabel);
            else 
                set(handles.txtHaeveSaenkefunktionYderligere,'String','Ingen Data');
            end
        else
            % Hvis det er Luna der er den valgte teknologi, vil procent for
            % antal gange Luna bliver anvendt med Carendo ud af antal gange
            % Luna anvendes beregnes. 
            LunaMedCarendo = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            % Hvis procenten ikke er nul, vil den udskrives på Yderligere
            % Data Skærm, ellers vil den udskrive Ingen Data.
            if ~isnan(LunaMedCarendo)
                textLabel = sprintf('%s %%', string(round(LunaMedCarendo)));
                set(handles.txtLunaMedCarendoYderligere,'String',textLabel);
            else
                set(handles.txtLunaMedCarendoYderligere,'String','Ingen Data');
            end
        end
    end

