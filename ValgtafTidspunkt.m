function handles = ValgtafTidspunkt(handles)
%VALGTAFTIDSPUNKT aktiveres n�r brugren i "'Tilf�j bem�rkning"'-vinduet har
%   valgt hvilken dato og hvilket tidspunkt p� dagen bem�rkningen skal
%   tilf�jes til. Det funktionen g�r at er udskriver den valgt dato og 
%   tidspunkt, samt hvilken sensor brugeren er ved at tilf�je en bem�rkning
%   til. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI. 
%
%   OUTPUT: 
%   handles = handle til elementer i GUI. 

teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

Antalfravalgtdato = 0;
%Henter oplysninger om hvilken, sensor og tidspunkt/periode brugeren har
%valgt
if isfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    Valuefromlistbox = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
    %L�ber alle elementer af velf�rdsteknologi i gennem
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          %L�ber alle sensorerne i gennem
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
              %Henter tidspunkt brugeren har valgt og henter tidspunkt fra
              %handles der tilh�rer datapunktet. Sammenligner de to
              %tidspunkter, hvis de er ens udskrives bem�rkningen p�
              %Sensor Overblik Sk�rm 
              ValgtTidspunkt = get(handles.etDatoTilfoejBemaerkning, 'String');
              tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
              tidspunkt.Format = 'dd-MMM-yyyy';
              tidspunkt = string(tidspunkt);
            if ValgtTidspunkt == tidspunkt 
                  Antalfravalgtdato = Antalfravalgtdato+1;
                  if Antalfravalgtdato == Valuefromlistbox
                      tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                     % Pr�allokere et categorical array med tidspunkterp�dagen
                      TidspunktPaaDagen = (categorical({'Morgen', 'Formiddag', 'Middag', 'Eftermiddag', 'Aften', 'Nat'}))';
                    %Tiden bliver placeret indenfor de bestemte intervaller. 
                        if hour(tidspunkt)>=5 && hour(tidspunkt)< 9
                            TidspunktPaaDagen_Data=TidspunktPaaDagen(1);
                        elseif hour(tidspunkt)>=9 && hour(tidspunkt)<11
                                TidspunktPaaDagen_Data= TidspunktPaaDagen(2);
                        elseif hour(tidspunkt)>=11 && hour(tidspunkt)<14
                                TidspunktPaaDagen_Data= TidspunktPaaDagen(3);
                        elseif hour(tidspunkt)>=14 && hour(tidspunkt)<17
                                TidspunktPaaDagen_Data= TidspunktPaaDagen(4);
                        elseif hour(tidspunkt)>=17 && hour(tidspunkt)<23 
                                TidspunktPaaDagen_Data= TidspunktPaaDagen(5);
                        else 
                                TidspunktPaaDagen_Data= TidspunktPaaDagen(6);
                        end

                    tidspunktKunDato = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
                    tidspunktKunDato.Format = 'dd-MMM-yyyy';
                    tidspunktKunDato = string(tidspunktKunDato);
                     udskrift = sprintf("%s %s %s", Sensornavn, tidspunktKunDato, TidspunktPaaDagen_Data);
                    set(handles.txtValgtTidspunkt, 'String', udskrift);
                   end
            end
          end
        end
    end
end
end

