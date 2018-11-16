function YderligereDataFunktioner(handles,ttYderligere, teknologi, Begraensning)

        ttYderligere = ttYderligere(Begraensning,:);
        if strcmp(teknologi,'Carendo')==1 
            Omsorgsfunktion = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            Komfortfunktion = (sum(ttYderligere.Var2)/length(ttYderligere.Var2))*100;
            Haevesaenkefunktion = (sum(ttYderligere.Var3)/length(ttYderligere.Var3))*100;
            if ~isnan(Omsorgsfunktion)
                set(handles.txtOmsorgsfunktionYderligere,'String',string(round(Omsorgsfunktion)));
            else
                set(handles.txtOmsorgsfunktionYderligere,'String','Ingen Data');
            end
            
            if ~isnan(Komfortfunktion)
                set(handles.txtKomfortfunktionYderligere,'String',string(round(Komfortfunktion)));
            else
                set(handles.txtKomfortfunktionYderligere,'String','Ingen Data');
            end
            
            if ~isnan(Haevesaenkefunktion)
                set(handles.txtHaeveSaenkefunktionYderligere,'String',string(round(Haevesaenkefunktion)));
            else 
                set(handles.txtHaeveSaenkefunktionYderligere,'String','Ingen Data');
            end
        else
            LunaMedCarendo = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            
            if ~isnan(LunaMedCarendo)
                set(handles.txtLunaMedCarendoYderligere,'String',string(round(LunaMedCarendo)));
            else
                set(handles.txtLunaMedCarendoYderligere,'String','Ingen Data');
            end
        end
    end

