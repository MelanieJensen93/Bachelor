function [handles,datatogo,svar] = Bemaerkning(handles, datatogo)
%BEMAERKNING aktiveres n�r brugeren trykker p� "'+ Tilf�j bem�rkning"'-knappen.
%   Funktionen tjekker om brugeren har valgt dato og bem�rkning, hvis 
%   brugeren har valgt dato og bem�rkning �bnes et vindue, hvor brugren skal
%   v�lge om han/hun �nsker at tilf�je at bem�rkningen. Hvis brugren trykker
%   "'Ja"', gemmes bem�rkningen i handles og "'Sensor Overblik Sk�rm"' vises
%   mens "'Tilf�j bem�rkning"'- vinduet lukker. Hvis brugren trykker
%   "'Annuller"' lukker meddelelsesvinduet og brugren har mulighed for at
%   �ndre p� datoen og bem�rkningen eller lukke "'Tilf�j bem�rkning"'
%   -vinduetned. 
%   
%   INPUT: 
%   handles = handle til elementer i GUI.
%   datatogo = handle til de elementer der ligger i
%   handles.Velf�rdsteknolgi fra andre GUI's.
%   
%   OUTPUT: 
%   handles = handle til elementer i GUI. 
%   datatogo = handle der sender de elementer der ligger i
%   handles.Velf�rdsteknologi med til andre GUI's
%   svar = brugerens svar p� hvor han/hun �nsker at tilf�je bem�rkningen


%Henter alle filnavne i handles.Velfaerdsteknologi, f�rste kolonne
%indeholder den valgte teknologi og derfor udv�lges denne. 
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
                      %Tjekker om det er f�rste bem�rkning der oprettes til
                      %dette tidspunkt, ellers g� den i else og finde ud af
                      %hvilken nr. bem�rkning det s� er. 
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
                    
                    %Sp�rg brugeren om han/hun �nsker at tilf�je en
                    %bem�rkning, men de oplysninger de har valgt p� tilf�j
                    %bem�rknings vinduet. 
                    if isfield(handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning,'Bemaerkning')
                        % Stammer fra : https://se.mathworks.com/help/matlab/ref/questdlg.html
                        spoergsmaal=sprintf('�nsker du at tilf�je bem�rkningen: %s %s til %s?',...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).bemaerkning,...
                            handles.Velfaerdsteknologi.(teknologi).(Sensornavn)(ii).TilfoejBemaerkning.Bemaerkning(idx).tidspunkt,...
                            Sensornavn);
                        svar=questdlg(spoergsmaal,'Tilf�j bem�rkning',...
                            'Gem', 'Annuller', 'Gem'); %den sidste gem er default v�rdien
                        switch svar
                            %Hvis brugeren trykker p� "Gem" tilf�jes
                            %bem�rkningen bem�rkningsfilen, ved at kalde
                            %funktionen GemBemaerkningiFil. 
                            case 'Gem'
                                disp([svar ' gemt'])
                                GemBemaerkningiFil(handles); 
                                datatogo = handles.Velfaerdsteknologi;
                                GUITilfoejBemaerkning(datatogo);
                                break
                                %Hvis brugeren trykker p� "Annuller",
                                %lukker sp�rgsm�let og brugeren vender
                                %tilbage til Tilf�j bem�rkning vinduet. 
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
  uiwait(msgbox('V�lg venligst en dato', 'Error', 'error', 'modal'));
end



end




   
 





