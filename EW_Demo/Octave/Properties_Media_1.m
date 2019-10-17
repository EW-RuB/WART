function [eps_r1, mue_r1, kap_1, eps_r2, mue_r2, kap_2, eps_r3, mue_r3, kap_3] = ...
               Properties_Media_1( f, choice_mat, sub_case_str )

%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig
       
                     Material-Konstanten aller 3 Medien : 
    # Rolf :
    # 
    #    je eps_r, mue_r und kap  SETZEN
    #
    #    Kombinationen passend zu den moeglichen Faellen und zur Frequenz
    #
    #    unabhaengig von 'TE'- oder 'TM'-Polarisation


                Eingabe-Parameter :
                
    f               :   Frequenz in Hz
    
    choice_mat      :   falls = 0  ==> Defaults fuer den Brechungs-Fall  ;  sonst weitere passende Beispiel-Werte
    
    sub_case_str    :   gewuenschter Brechungs-Fall ALS STRING , z.B. '1b1b'



                  moegliche Werte waeren z.B. :

%      Dielektrizitaetskonstante :
%eps_r = 1.0;   % Luft ,  Plasma ?
%eps_r = 2.3;   % viele Kunststoffe (PE)
%eps_r = 2.7;   % WILLKUERLICH ,  (Glas optische Freq. ?)
%eps_r = 4.0;   % hoeher (PVC ?  Teflon ? )
%eps_r = 5.0;   % Halbleiter (Si ?)
%eps_r = 9.0;   % Wasser (Freq. bis 1 GHz ?)
%eps_r = 3.0;   % Wasser (Freq. ab 10 GHz ?)


%      Permeabilitaetskonstante :
%mue_r = 1.0;  % wie Vakuum
   { andere Werte wohl nur fuer FERRITE sinnvoll }


%      Spezif. Leitfaehigkeit :
%kap = 0.6e8;    % ca. beste reale Leiter (Ag, Cu)
%kap = 1.e1;     % WILLKUERLICH ,  (Graphit ?) 
%kap = 1.e0;     % WILLKUERLICH   
%kap = 1.e-1;    % WILLKUERLICH   
%kap = 1.e-2;    % (Glas, Salzwasser ?)
%kap = 1.e-3;    % WILLKUERLICH
%kap = 6.e-4;    % WILLKUERLICH
%kap = 3.e-4;    % WILLKUERLICH
%kap = 2.e-4;    % Halbleiter (Si ?)
%kap = 1.e-6;    % (deionisiertes Wasser ?)
%kap = 2.e-14;   % WILLKUERLICH , fast idealer Isolator
%kap = 1.5e-16;  %  bester realer Isolator  (Diamant ?)
%kap = 0.;       % fiktiv OHNE Daempfung : Fall alpha



Die Frequenz wird noch gar nicht benutzt !
Das waere verbunden z.B. mit der Wahl bestimmter STOFFE wie Suess-/Salz-Wasser, Glas, ....




Started on May 25., 2017
Last Changes on Jun 06., 2017
%}

%{
                       History :

 06. Jun.  2017 :  - weiter im Code : 
                     4 Faelle mit '1aXX' und 4 Faelle mit '2aXX' formal fertig,
                     Werte teilweise noch schlecht fuer Demo geeignet
                        ==> die schwerer verstaendlichen Faelle MIT 'Umschlagen psi_t'

 04. Jun.  2017 :  - weiter im Code : 8 Faelle mit '1bXX' und '2bXX' fertig
                        ==> die leichter verstaendlichen Faelle OHNE 'Umschlagen psi_t'

 03. Jun.  2017 :  - weiter im Code : 4 Faelle mit '1bXX' fertig

 29. May   2017 :  - weiter im Code, Ersatz fuer 'switch ... case ' BEGINN :
                       2 geschachtelte if() funktionieren
                       
 27. May   2017 :  - weiter im Code, zuerst Fall '1b1b' : Aufruf funktioniert 1. Mal !
                      ==> diese primitive 1. Form als <Properties_Media_00.m> gespeichert
                        
 25. May   2017 :  - Auslagerung ' Properties_Media(om) ' begonnen , nur formal
                       
%}


mue_r1 = 1.0;  % wie Vakuum
mue_r2 = 1.0;  % wie Vakuum
mue_r3 = 1.0;  % wie Vakuum



%                               1. TRAUM-ZIEL WAERE SO ETWAS :

%{
%                KENNT Octave dies ODER NICHT ??? :

switch (sub_case_str)

    case "1a1a" :
          %............

    case "1b1b" :
%%        %{
            Border 1 : TEM incident , Refr. "1b"   ;   Border 2 : TE incident ; Refr. "1b"
		  eps_r2 > eps_r1  refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,   > 0
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,   > 0
%%        %}
        if ( choice_mat == 0 )
 %_________________________________________________________________________________________
            eps_r1 = 1.0;   % Luft         , hier  eps_r1  <  eps_r2  <  eps_r3
            kap_1 = 2.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
            %
            eps_r2 = 2.0;   % NICHT Luft
            kap_2 = 8.e-4;  % WILLKUERLICH
            %
            eps_r3 = 3.0;   % WILLKUERLICH
            kap_3 = 2.e-3;  % WILLKUERLICH
            %
            %      PLATZ fuer WEITERE DEFAULTS :
            %  waere guter Default fuer festen Einfallswinkel :
            %alpha_e = 25. * radw;       % Default
 %_________________________________________________________________________________________

        else
            eps_r1 = 1.0;   % Luft
            kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
            %
            eps_r2 = 2.3;   % NICHT Luft
            kap_2 = 4.e-4;  % WILLKUERLICH
            %
            eps_r3 = 4.0;   % WILLKUERLICH
            kap_3 = 1.e-3;  % WILLKUERLICH
            %
        endif
    case "1b2a" :
          %............
end     % switch
%}


%                Rolfs Ersatz Versuch 1 (ab 29.Mai 2017) :

case_bo_1 = substr(sub_case_str, 1, 2);     case_bo_2 = substr(sub_case_str, 3, 2);

    if ( case_bo_1 == '1a' )
        disp( '     1a , keine UMSCHLAGENDEN Filmwellen an Border # 1');
        %
        if ( case_bo_2 == '1a' )
            disp( '1a1a erkannt');
            disp( '     harmlos, keine UMSCHLAGENDEN Filmwellen');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '        nur als BEISPIEL :   Plasma ==> Glas ==> deionisiertes Wasser  ?');
            %{
                  Border 1 : TEM incident , Refr. "1a"   ;   Border 2 : TE incident ; Refr. "1a"
		  eps_r2 > eps_r1  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 < kappa_1     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % wie Luft       , aber  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 4.e-4;  % WILLKUERLICH   , aber  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.0;   % WILLKUERLICH
                    kap_2 = 1.e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 3.3;   % WILLKUERLICH
                    kap_3 = 6.e-4;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default                   ??????????
                    %
                else
                    %               ANDERE Werte, die zu '1a1a' passen : :
                    eps_r1 = 1.0;   % wie Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 8.e-4;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.3;   % NICHT Luft
                    kap_2 = 1.5e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 4.5;   % WILLKUERLICH,  Halbleiter ?
                    kap_3 = 4.e-4;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '1b' )
            disp( '1a1b erkannt');
            disp( '     harmlos, keine UMSCHLAGENDEN Filmwellen');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '        nur als BEISPIEL :   Plasma ==> Glas ==> Salzwasser  ?');
            %{
                  Border 1 : TEM incident , Refr. "1a"   ;   Border 2 : TE incident ; Refr. "1b"
		  eps_r2 > eps_r1  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 < kappa_1     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,   > 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % wie Luft       , aber  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 1.5e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.3;   % viele Kunststoffe
                    kap_2 = 6.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.3;   % WILLKUERLICH
                    kap_3 = 1.2e-3; % WILLKUERLICH   , hier  kappa_3  <  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default                   ??????????
                    %
                else
                    %               ANDERE Werte, die zu '1a1b' passen : ?????????????????????????????
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 8.e-4;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.0;   % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.5;   % WILLKUERLICH
                    kap_3 = 1.6e-3; % WILLKUERLICH   , hier  kappa_3  >  kappa_1
                    %
                endif
        elseif ( case_bo_2 == '2a' )
            disp( '1a2a erkannt');
            disp( '     Achtung, ggfs. UMSCHLAGENDE Filmwellen an Border # 2');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '        nur als BEISPIEL :   Plasma ==> deionisiertes Wasser /Teflon ==> Glas   ?');
            %{
                  Border 1 : TEM incident , Refr. "1a"   ;   Border 2 : TE incident ; Refr. "2a"
		  eps_r2 > eps_r1  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 < kappa_1     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % wie Luft       , aber  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 1.6e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 3.3;   % Wasser ?
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.0;   % WILLKUERLICH   , hier  eps_r3  >  eps_r1
                    kap_3 = 3.e-4;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default                   ??????????
                    %
                else
                    %               ANDERE Werte, die zu '1a2a' passen : ???????????????????
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 8.e-4;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.3;   % NICHT Luft
                    kap_2 = 1.5e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 3.5;   % WILLKUERLICH
                    kap_3 = 4.e-4;  % WILLKUERLICH
                    %
                endif
        else        %if ( case_bo_2 == '2b' )
            disp( '1a2b erkannt');
            disp( '     Achtung, ggfs. trotz 2b UMSCHLAGENDE Filmwellen an Border # 2 ?');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '        nur als BEISPIEL :   Plasma  ==>  deionisiertes Wasser  ==>  Glas   ?');
            %{
                  Border 1 : TEM incident , Refr. "1a"   ;   Border 2 : TE incident ; Refr. "2b"
		  eps_r2 > eps_r1  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 < kappa_1     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % wie Luft       , aber  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 1.1e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 3.0;   % Wasser ?
                    kap_2 = 3.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.0;   % WILLKUERLICH
                    kap_3 = 7.e-4;  % WILLKUERLICH   , hier  kappa_3  <  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default                   ??????????
                    %
                else
                    %               ANDERE Werte, die zu '1a2b' passen : ???????????????????????
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 9.e-4;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.7;   % NICHT Luft
                    kap_2 = 3.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.0;   % WILLKUERLICH
                    kap_3 = 6.e-4;  % WILLKUERLICH
                    %
                endif
        endif
        %
    elseif ( case_bo_1 == '1b' )
        %
        if ( case_bo_2 == '1a' )
            disp( '1b1a erkannt');
            disp( '        nur als BEISPIEL :   Luft ==> Glas ==> deionisiertes Wasser  ?');
            %{
                  Border 1 : TEM incident , Refr. "1b"   ;   Border 2 : TE incident ; Refr. "1a"
		  eps_r2 > eps_r1  refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,   > 0
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 4.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.3;   % viele Kunststoffe
                    kap_2 = 1.e-3;  % WILLKUERLICH   , hier  kappa_2  >  kappa_1
                    %
                    eps_r3 = 4.0;   % WILLKUERLICH
                    kap_3 = 6.e-4;  % WILLKUERLICH
                    %
%%%%  EINIGE WERTE NOCH UNSINN %%%%%%%% :
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default                   ??????????
                    %
                else
                    %               ANDERE Werte, die zu '1b1a' passen : :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 8.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.3;   % NICHT Luft
                    kap_2 = 1.5e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 3.5;   % WILLKUERLICH
                    kap_3 = 4.e-4;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '1b' )
            disp( '1b1b erkannt');
            disp( '        nur als BEISPIEL :   Luft ==> Glas ==> \(Salz\)-Wasser  ?');
            %{
                  Border 1 : TEM incident , Refr. "1b"   ;   Border 2 : TE incident ; Refr. "1b"
		  eps_r2 > eps_r1  refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,   > 0
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,   > 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.0;   % NICHT Luft
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.0;   % WILLKUERLICH
                    kap_3 = 2.e-3;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default
                    %alpha_e = 55. * radw;       %          Brewster bei TM  ?????????
                    %
                else
                    %               ANDERE Werte, die zu '1b1b' passen : :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  <  eps_r3
                    kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.3;   % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 4.0;   % WILLKUERLICH
                    kap_3 = 1.e-3;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '2a' )
            disp( '1b2a erkannt');
            disp( 'DIES IST DER PRAKTISCH WICHTIGSTE FALL :');
            disp( '     nur als BEISPIEL :   Luft  ==>  Wasser  ==>  Luft');
            %{
                  Border 1 : TEM incident , Refr. "1b"   ;   Border 2 : TE incident ; Refr. "2a"
		  eps_r2 > eps_r1  refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,   > 0
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_3 < kappa_2     psi_t phase jump : "YES at 90 degrees"  , < 0 otherwise
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 3.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.0;   % NICHT Luft
                    kap_2 = 1.e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % Luft
                    kap_3 = 3.e-4;  % WILLKUERLICH   , hier  kappa_1  =  kappa_3
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 25. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '1b2a' passen : :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 4.5;   % NICHT Luft
                    kap_2 = 2.e-3;  % WILLKUERLICH
                    %
                    eps_r3 = 2.0;   % WILLKUERLICH   , etwas > Luft
                    kap_3 = 2.e-4;  % WILLKUERLICH
                    %
                endif
        else        %if ( case_bo_2 == '2b' )
            disp( '1b2b erkannt');
            disp( '     nur als BEISPIEL :   Luft  ==>  deionisiertes Wasser  ==>  Glas  ???');
            %{
                  Border 1 : TEM incident , Refr. "1b"   ;   Border 2 : TE incident ; Refr. "2b"
		  eps_r2 > eps_r1  refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,   > 0
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 1.0;   % Luft           , aber  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.7;   % Kunststoffe
                    kap_2 = 6.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % WILLKUERLICH   ,  wie Luft
                    kap_3 = 1.e-3;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '1b2b' passen : :
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 4.;    % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.3;   % WILLKUERLICH
                    kap_3 = 8.e-4;  % WILLKUERLICH
                    %
                endif
        endif
        %
    elseif ( case_bo_1 == '2a' )
      disp( '     Achtung, IMMER UMSCHLAGENDE Filmwellen an Border # 1');
        %
        if ( case_bo_2 == '1a' )
            disp( '2a1a erkannt');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '     Achtung, ggfs. UMSCHLAGENDE Filmwellen an Border # 2');
            disp( '        nur als BEISPIEL :   Salzwasser ==> Glas ==> deionis. Wasser  ?');
            disp( '              ODER       :   dotierter Halbl. ==> Glas ==> Harz / Teflon  ?');
            %{
                  Border 1 : TEM incident , Refr. "2a"   ;   Border 2 : TE incident ; Refr. "1a"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_2 < kappa_1     psi_t phase jump : "YES ?"  ,  < 0 nur DIREKT vor 90 Grad
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 1.5e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 1.7;   % WILLKUERLICH
                    kap_2 = 7.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.7;   % WILLKUERLICH   ,  hier  eps_r3  >  eps_r1
                    kap_3 = 3.e-4;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '2a1a' passen : ????????????????????????????
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 4.;    % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.3;   % WILLKUERLICH
                    kap_3 = 8.e-4;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '1b' )
            disp( '2a1b erkannt');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
            disp( '     KEINE UMSCHLAGENDE Filmwelle an Border # 2');
            disp( '        nur als BEISPIEL :   Salzwasser ==> Luft ==> Glas  ?');
            disp( '              ODER       :   dotierter Halbl. ==> Glas ==> Harz / Teflon  ?');
            %{
                  Border 1 : TEM incident , Refr. "2a"   ;   Border 2 : TE incident ; Refr. "1b"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_2 < kappa_1     psi_t phase jump : "YES ?"  ,  < 0 nur DIREKT vor 90 Grad
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,   > 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 1.6e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 1.0;   % Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.0;   % WILLKUERLICH   , hier  eps_r3  <  eps_r1  
                    kap_3 = 8.e-4;  % WILLKUERLICH   , hier  kappa_3  <  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '2a1b' passen : ???????????????????????
                    eps_r1 = 1.0;   % Luft           , hier  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 8.e-5;  % WILLKUERLICH   , hier  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 4.;    % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 2.3;   % WILLKUERLICH
                    kap_3 = 8.e-4;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '2a' )
            disp( '2a2a erkannt');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
           disp( '     Achtung, ggfs. UMSCHLAGENDE Filmwellen an Border # 2');
            disp( '                praktisch wichtiger Fall !');
            disp( '        nur als BEISPIEL :  Salzwasser ==> Glas ==> Luft   ?');
            %{
                  Border 1 : TEM incident , Refr. "2a"   ;   Border 2 : TE incident ; Refr. "2a"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_2 < kappa_1     psi_t phase jump : "YES ?"  ,  < 0 nur DIREKT vor 90 Grad
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 1.5e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.0;   % WILLKUERLICH
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % Luft
                    kap_3 = 3.e-4;  % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '2a2a' passen : ?????????????????????????????
                    eps_r1 = 4.0;   % dot. Halbl.    , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 1.5e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.3;    % NICHT Luft
                    kap_2 = 7.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.7;   % WILLKUERLICH
                    kap_3 = 2.e-4;  % WILLKUERLICH
                    %
                endif
        else        %if ( case_bo_2 == '2b' )
            disp( '2a2b erkannt');
%%%%                            TEXTE  UND  WERTE HIER NOCH UNSINN                        %%%%%%%% :
           disp( '     KEINE UMSCHLAGENDE Filmwelle an Border # 2');
            disp( '        nur als BEISPIEL :   Salzwasser ==> Glas ==> Plasma  ?');
            %{
                  Border 1 : TEM incident , Refr. "2a"   ;   Border 2 : TE incident ; Refr. "2b"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_2 < kappa_1     psi_t phase jump : "YES ?"  ,  < 0 nur DIREKT vor 90 Grad
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % Luft           , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 1.3e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.0;   % WILLKUERLICH
                    kap_2 = 5.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % WILLKUERLICH   ,  wie Luft
                    kap_3 = 1.0e-3; % WILLKUERLICH   , hier  kappa_3  >  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default
                    %
                else
                    %               ANDERE Werte, die zu '2a2b' passen : ??????????????????????????????
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 1.2e-3; % WILLKUERLICH   , aber  kappa_1  >  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.0;   % NICHT Luft
                    kap_2 = 4.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % wie Luft
                    kap_3 = 1.6e-3; % WILLKUERLICH   , hier  kappa_3  <  kappa_1
                    %
                endif
        endif
        %
    else        %if ( case_bo_1 == '2b' )
      disp( '     Achtung, IMMER REGULAERE Filmwellen an Border # 1');
        %
        if ( case_bo_2 == '1a' )
            disp( '2b1a erkannt');
            disp( '  nur als BEISPIEL :   deionisiertes Wasser  ==>  Blei-Glas  ==>  deionisiertes Wasser  ???');
            disp( '      ODER         :    Kunstharz / Teflon   ==>  Blei-Glas  ==>        Teflon  ???');
            %{
                  Border 1 : TEM incident , Refr. "2b"   ;   Border 2 : TE incident ; Refr. "1a"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 2.7;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 6.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.;    % WILLKUERLICH
                    kap_2 = 1.5e-3; % WILLKUERLICH
                    %
                    eps_r3 = 3.0;   % WILLKUERLICH   , hier z.B. eps_r3  >  eps_r1
                    kap_3 = 2.e-4;  % WILLKUERLICH   , hier z.B. kappa_3  <  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default                 ???
                    %
                else
                    %               ANDERE Werte, die zu '2b1a' passen : :
                    eps_r1 = 3.7;   % WILLKUERLICH   , aber  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.;    % WILLKUERLICH     
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.7;   % WILLKUERLICH   , hier  Mat. # 3 = Mat. # 1
                    kap_3 = 2.e-4;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '1b' )
            disp( '2b1b erkannt');
            disp( '  nur als BEISPIEL :   deionisiertes Wasser  ==>  Blei-Glas  ==>  Salzwasser  ???');
            disp( '      ODER         :    Kunstharz / Teflon   ==>  Blei-Glas  ==>  dotierter Halbleiter  ???');
            %{
                  Border 1 : TEM incident , Refr. "2b"   ;   Border 2 : TE incident ; Refr. "1b"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
		  eps_r3 > eps_r2  Refraction angle SMALLER  ,  total reflection : "NO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,   > 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  <  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 1.7;   % WILLKUERLICH
                    kap_2 = 6.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.3;   % WILLKUERLICH   , hier z.B. eps_r3  >  eps_r1   ==> Filmwelle !?
                    kap_3 = 1.5e-3; % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default                 ???
                    %
                else
                    %               ANDERE Werte, die zu '2b1b' passen : :
                    eps_r1 = 3.7;   % WILLKUERLICH   , hier  eps_r1  <  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , hier  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 2.;    % WILLKUERLICH     
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 3.0;   % WILLKUERLICH   , hier z.B. eps_r3  =  eps_r1  
                    kap_3 = 2.e-3;  % WILLKUERLICH
                    %
                endif
        elseif ( case_bo_2 == '2a' )
            disp( '2b2a erkannt');
            disp( '  nur als BEISPIEL :   deionisiertes Wasser  ==>  Glas  ==>  Luft  ???');
            disp( '      ODER         :    Kunstharz / Teflon   ==>  Glas  ==>  Luft  ???');
            %{
                  Border 1 : TEM incident , Refr. "2b"   ;   Border 2 : TE incident ; Refr. "2a"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "YES"
		  kappa_3 < kappa_2     psi_t phase jump : "YES bei 90 Grad"  , sonst  < 0
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 3.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 1.7;   % WILLKUERLICH
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % wie Luft
                    kap_3 = 8.e-5;  % WILLKUERLICH   , hier z.B. kappa_3  <  kappa_1
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default                 ???
                    %
                else
                    %               ANDERE Werte, die zu '2b2a' passen : :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.;    % WILLKUERLICH     
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.;    % WILLKUERLICH
                    kap_3 = 2.e-4;  % WILLKUERLICH   , hier z.B. kappa_3  =  kappa_1
                    %
                endif
        else        %if ( case_bo_2 == '2b' )
            disp( '2b2b erkannt');
            disp( '  nur als BEISPIEL :   deionisiertes Wasser  ==>  Glas  ==>  Plasma  ???');
            disp( '      ODER         :    Kunstharz / Teflon   ==>  Glas  ==>  Plasma  ???');
            %{
                  Border 1 : TEM incident , Refr. "2b"   ;   Border 2 : TE incident ; Refr. "2b"
		  eps_r2 < eps_r1  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_2 > kappa_1    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
		  eps_r3 < eps_r2  Refraction angle LARGER  ,  total reflection : "DE FACTO"
		  kappa_3 > kappa_2    psi_t phase jump : "NO"  ,  > 0 ,  stetig -> Filmwelle
            %}
                if ( choice_mat == 0 )
                    %               Defaults :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  <  kappa_3
                    %
                    eps_r2 = 1.7;   % WILLKUERLICH
                    kap_2 = 6.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.0;   % wie Luft
                    kap_3 = 1.5e-3; % WILLKUERLICH
                    %
                    %      PLATZ fuer WEITERE DEFAULTS :
                    %  waere guter Default fuer festen Einfallswinkel :
                    %alpha_e = 30. * radw;       % Default                 ???
                    %
                else
                    %               ANDERE Werte, die zu '2b2b' passen : :
                    eps_r1 = 3.0;   % WILLKUERLICH   , aber  eps_r1  >  eps_r2  >  eps_r3
                    kap_1 = 2.e-4;  % WILLKUERLICH   , aber  kappa_1  <  kappa_2  >  kappa_3
                    %
                    eps_r2 = 2.;    % WILLKUERLICH     
                    kap_2 = 8.e-4;  % WILLKUERLICH
                    %
                    eps_r3 = 1.;    % wie Luft
                    kap_3 = 2.e-3;  % WILLKUERLICH
                    %
                endif
        endif
        %
    endif
    




endfunction
