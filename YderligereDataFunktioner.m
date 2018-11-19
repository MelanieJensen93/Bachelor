function YderligereDataFunktioner(handles,ttYderligere, teknologi, Begraensning)

        ttYderligere = ttYderligere(Begraensning,:);
        if strcmp(teknologi,'Carendo')==1 
            Omsorgsfunktion = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            Komfortfunktion = (sum(ttYderligere.Var2)/length(ttYderligere.Var2))*100;
            Haevesaenkefunktion = (sum(ttYderligere.Var3)/length(ttYderligere.Var3))*100;
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
            LunaMedCarendo = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            
            if ~isnan(LunaMedCarendo)
                textLabel = sprintf('%s %%', string(round(LunaMedCarendo)));
                set(handles.txtLunaMedCarendoYderligere,'String',textLabel);
            else
                set(handles.txtLunaMedCarendoYderligere,'String','Ingen Data');
            end
        end
    end

