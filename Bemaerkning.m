function [handles,datatogo,svar] = Bemaerkning(handles, datatogo)
%BEMAERKNING aktiveres når brugeren trykker på "'+ Tilføj bemærkning"'-knappen.
%   Funktionen tjekker om brugeren har valgt dato og bemærkning, hvis 
%   brugeren har valgt dato og bemærkning åbnes et vindue, hvor brugren skal
%   vælge om han/hun ønsker at tilføje at bemærkningen. Hvis brugren trykker
%   "'Ja"', gemmes bemærkningen i handles og "'Sensor Overblik Skærm"' vises
%   mens "'Tilføj bemærkning"'- vinduet lukker. Hvis brugren trykker
%   "'Annuller"' lukker meddelelsesvinduet og brugren har mulighed for at
%   ændre på datoen og bemærkningen eller lukke "'Tilføj bemærkning"'
%   -vinduetned. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI.
%   datatogo = handle til de elementer der ligger i
%   handles.Velfærdsteknolgi fra andre GUI's.
%   
%   OUTPUT: 
%   handles = handle til elementer i GUI. 
%   datatogo = handle der sender de elementer der ligger i
%   handles.Velfærdsteknologi med til andre GUI's
%   svar = brugerens svar på hvor han/hun ønsker at tilføje bemærkningen


%Henter alle filnavne i handles.Velfaerdsteknologi, første kolonne
%indeholder den valgte teknologi og derfor udvælges denne. 
teknologi = fieldnames(handles.Velfaerdsteknologi(1));
teknologi = string(teknologi(1));

Antalfravalgtdato = 0;

if isfield(handles.Velfaerdsteknologi,'ValgtTidspunktPaaDato')
    Sensornr = getfield(handles.Velfaerdsteknologi, 'BrugerValgtSensor');
    Valuefromlistbox = getfield(handles.Velfaerdsteknologi, 'ValgtTidspunktPaaDato');
   
    for i = 1:length(fieldnames(handles.Velfaerdsteknologi.(teknologi)))
        if Sensornr == i 
          Sensor = fieldnames(handles.Velfaerdsteknologi.(teknologi));
          Sensornavn = string(Sensor(i));
          for ii = 1:length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn))
              handles.Velfaerdsteknologi.ValgtTidspunkt = get(handles.etDatoTilfoejBemaerkning, 'String');
              tidspunkt = handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).Tidspunkt;
              tidspunkt.Format = 'dd-MMM-yyyy';
              tidspunkt = string(tidspunkt);
            if handles.Velfaerdsteknologi.ValgtTidspunkt == tidspunkt 
                  Antalfravalgtdato = Antalfravalgtdato+1;
                  if Antalfravalgtdato == Valuefromlistbox 
                      %Tjekker om det er første bemærkning der oprettes til
                      %dette tidspunkt, ellers gå den i else og finde ud af
                      %hvilken nr. bemærkning det så er. 
                    if ~isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn),'TilfoejBemaerkning') || isempty(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning)
                        idx=1; 
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt= get(handles.etDatoTilfoejBemaerkning,'String');
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                    else
                        idx = length(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning);
                        idx = idx+1;
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt = get(handles.etDatoTilfoejBemaerkning,'String');
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning = get(get(handles.bgBemaerkningTilfoejBemaerkning,'SelectedObject'),'String');
                        
                    end
                    
                    %Henter kommentar fra andet feltet
                    if strcmp(getfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx),'bemaerkning'),'Andet') == 1
                        AndetBemaerkning = get(handles.etAndetTilfoejBemaerkning,'String');
                        AndetBemaerkning = "Andet: " + AndetBemaerkning;
                        handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning =  AndetBemaerkning;
                    end
                    
                    %Spørg brugeren om han/hun ønsker at tilføje en
                    %bemærkning, men de oplysninger de har valgt på tilføj
                    %bemærknings vinduet. 
                    if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning,'Bemaerkning')
                        % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
                        spoergsmaal=sprintf('Ønsker du at tilføje bemærkningen: %s %s til %s?',...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt,...
                            Sensornavn);
                        svar=questdlg(spoergsmaal,'Tilføj bemærkning',...
                            'Gem', 'Annuller', 'Gem'); %den sidste gem er default værdien
                        switch svar
                            %Hvis brugeren trykker på "Gem" tilføjes
                            %bemærkningen bemærkningsfilen, ved at kalde
                            %funktionen GemBemaerkningiFil. 
                            case 'Gem'
                                disp([svar ' gemt'])
                                GemBemaerkningiFil(handles); 
                                datatogo = handles.Velfaerdsteknologi;
                                GUITilfoejBemaerkning(datatogo);
                                break
                                %Hvis brugeren trykker på "Annuller",
                                %lukker spørgsmålet og brugeren vender
                                %tilbage til Tilføj bemærkning vinduet. 
                            case 'Annuller'
                                disp([svar ' annulleret'])

                        end 
                    end
                  end
            end
          end
          
       end
    end
       

    %Hvis ikke der er valgt en dato udskrives denne fejlmeddelelse. 
else
  uiwait(msgbox('Vælg venligst en dato', 'Error', 'error', 'modal'));
end



end




   
 





