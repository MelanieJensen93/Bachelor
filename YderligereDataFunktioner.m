function YderligereDataFunktioner(handles,ttYderligere, teknologi, Begraensning)

        ttYderligere = ttYderligere(Begraensning,:);
        if strcmp(teknologi,'Carendo')==1 
            Omsorgsfunktion = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            Komfortfunktion = (sum(ttYderligere.Var2)/length(ttYderligere.Var2))*100;
            Haevesaenkefunktion = (sum(ttYderligere.Var3)/length(ttYderligere.Var3))*100;
            set(handles.txtOmsorgsfunktionYderligere,'String',string(round(Omsorgsfunktion)));
            set(handles.txtKomfortfunktionYderligere,'String',string(round(Komfortfunktion)));
            set(handles.txtHaeveSaenkefunktionYderligere,'String',string(round(Haevesaenkefunktion)));
        else
            LunaMedCarendo = (sum(ttYderligere.Var1)/length(ttYderligere.Var1))*100;
            set(handles.txtLunaMedCarendoYderligere,'String',string(round(LunaMedCarendo)));
        end
    end

