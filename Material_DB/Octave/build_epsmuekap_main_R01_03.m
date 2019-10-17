function [eps_r, mue_r, kappa] = build_epsmuekap_main_01( f_akt, emk_Data)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       eps_r, mue_r und kappa aus Datenbank-Eintrag konstruieren :
    #           ( geeignet mindestens bei :
    #              -    alle Faelle 'delta' , d.h. ALLE Medien mit Daempfung )
    #
    # Rolf :
    #
    #  f_akt als Input-PARAMETER übergeben : aktuelle Frequenz in Hz
    #  emk_Data als Input-PARAMETER-Vektor mit 20 REAL DOUBLEs übergeben

Started on Mar. 22., 2019
Last Changes on Mar. 22., 2019
%}

%{
                                     Status Funktionen :

                   - Beginn Funktions-Vereinheitlichung :

                   - Funktions-Implementierung :
                        a) angedachte Typen :        {  x == (f_akt - f_low) / (f_high - f_low)  }
                     OK    0    const. 
                     OK    1    linear
                     OK    2    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                     OK    3    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                     OK    4    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                    NIX    5    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                    NIX    6    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                     OK    7    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.aeh. ....

                     Diese Funktionen 
                                      sollen wie die Originale AUSSEHEN, wenn die FREQUENZ LOGARITHMISCH GEMEINT ist :
                        b) angedacht fuer 'linlog' :
                     TT    31    linear
                     OK    32    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                     OK    33    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                     TT    34    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                    NIX    35    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                    NIX    36    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                    NIX    37    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....

                     Diese Funktionen 
                                      sollen entsprechend AUSSEHEN, wenn FREQUENZ UND FUNKTION LOGARITHMISCH GEMEINT sind :
                        c) angedacht fuer 'loglog':
                    NIX    61    linear
                    NIX    62    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                    NIX    63    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                    NIX    64    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                    NIX    65    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                    NIX    66    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                    NIX    67    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....




                                       History :

 22. Mar.  2019 :  - Beginn als Kopie von 'build_epsmuekap_main_R01_02.m' 
                        Auslagerung der eigentlichen Berechnung weiter


                                    ALT in build_epsmuekap_main_R01_02 :

 26. Feb.  2019 :  - Beginn als Kopie von 'build_epsmuekap_main_R01_01.m' 
                        Auslagerung zur Vereinheitlichung der eigentlichen Berechnung

 15. Feb.  2019 :  - Beginn als Kopie von 'build_epsmuekap_R02_03_DIA.m' 
                              Logik NEU !  Aufteilung in  
                       'build_epsmuekap_head_DIA.m'    UND     'build_epsmuekap_head_GUI.m'
                          ==>  WAHLWEISE EINE DAVON KOPIERT MAN NACH 'build_epsmuekap.m'

                      DAS und NUR DAS wird vom octave-Hauptprogramm unter FESTEM NAMEN aufgerufen !
                      Der 2. Übergabe-Parameter ist dann eben aus der GUI eine 'struct' und aus dem Dialog ein Vektor !

                      Beide setzen als EINZIGE Aufgabe die Eingabe-Parameter auf einheitliche Typen um !

                         ==> Beide rufen danach das IDENTISCHE 'build_epsmuekap_main.m' auf !

                      DAS hat Versionen, die auf diesen FESTEN Namen kopiert werden.
                      NUR im '..._main()' werden die eigentlichen Berechnungen durchgeführt.

                                           DAS IST GENAU HIER !

                      Die berechneten Werte gehen zurück an die aufrufenden 'wrapper' (s.o.)



                                    ALT in build_epsmuekap_02_03 :

                   - Wasser und Luft Einträge in Datenbank korrigiert/erweitert um neue
                   - Typen-Übersicht/Status ausgefüllt !!!                       SIEHE UNTEN !!!
                          ==> ist Typ #34 OK ???????  ist wichtig fuer Luft und Wasser !
                   - loglog müsste begonnen werden !
                          ==> zumindest #61 bis #64   werden fuer Luft u. Wasser benoetigt !


                                    ALT in build_epsmuekap_02_02 :

 22. Nov.  2018 :  - Typ 34  erste Tests
                   - Typen 32 u. 33 OK

 11. Nov.  2018 :  - Beginn als Kopie von 'build_epsmuekap_02_01.m' :
                   - Typen 32 und 33 Tests auch steigend

 
                                    ALT in build_epsmuekap_02_01 :

 11. Nov.  2018 :  - Beginn als Kopie von 'build_epsmuekap_01_03.m' :
                              3 Parameter MEHR in Datenbank ; Rehenfolge NEU 

 
                                    ALT in build_epsmuekap_01_03 :
 
 08. Oct.  2018 :  - weiter 'linlog' (fuer eps_r) :  Formeln fuer 'fallend' Typen 32 und 33     OK

 07. Oct.  2018 :  - Abfrage von if() auf switch() geaendert (fuer eps_r)
                   - Einfall : 'NEUE Funktions-Typen' : 'Duplikate' der Original-Typen ,
                                                         normiert  { alt :   x == (f_akt - f_low) / (f_high - f_low)  } .
                   - erste Typen implementiert : 31 , 32

 13. Sep.  2018 :  - Typ 7 implementiert, Typ 4 korrigiert
                        Typ 7 :
                     biquadrat. Parabel 
                        Typ 3 :
                     mit 2 Parametern Parabel als a * (1.-x)^N   ==>  f_h = a * (1.-x_h)^N  Bedg.legen a UND N fest

 12. Sep.  2018 :  - Typen 2 und 3 implementiert, Par_1=x_h und Par_2=f_h mit N als REELLEM Exponenten NEU :
                        Typ 2 :
                     mit 2 Parametern Parabel als 1 - a * x^N   ==>  f_h = 1 - a * (x_h)^N  Bedg.legen a UND N fest
                        Typ 3 :
                     mit 2 Parametern Parabel als a * (1.-x)^N   ==>  f_h = a * (1.-x_h)^N  Bedg.legen a UND N fest
 
 11. Sep.  2018 :  - Beginn from scratch : 
                    Namen neu; function heisst build_epsmuekap_01; neueste Version immer in gleichnamiges File kopieren
                                               { d.h. alle Aufrufe von extern DARAN anpassen }
                        
                        b) eps_r, mue_r und kappa jeweils fuer aktuelle Frequenz berechnen
%}


% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;

%radw = pi / 180.;


f_low = emk_Data(19);      f_high = emk_Data(20);


eps_r_low = emk_Data(1);      eps_r_high = emk_Data(3);     eps_ftype = int32( emk_Data(2) + 0.001); 
eps_par_1 = emk_Data(4);      eps_par_2 = emk_Data(5);      eps_par_3 = emk_Data(6);

%      22. Mar 2019 :
eps_r = build_fun_central( f_akt, f_low, f_high, eps_r_low, eps_r_high, 
                           eps_ftype, eps_par_1 , eps_par_2 , eps_par_3 )



mue_r_low = emk_Data(13);     mue_r_high = emk_Data(15);    mue_ftype = int32( emk_Data(14) + 0.001);
mue_par_1 = emk_Data(16);     mue_par_2 = emk_Data(17);     mue_par_3 = emk_Data(18);

%      22. Mar 2019 :
mue_r = build_fun_central( f_akt, f_low, f_high, mue_r_low, mue_r_high, 
                           mue_ftype, mue_par_1 , mue_par_2 , mue_par_3 );



kappa_low = emk_Data(7);      kappa_high = emk_Data(9);     kap_ftype = int32( emk_Data(8) + 0.001); 
kap_par_1 = emk_Data(10);      kap_par_2 = emk_Data(11);      kap_par_3 = emk_Data(12);

%      22. Mar 2019 :
kappa = build_fun_central( f_akt, f_low, f_high, kappa_low, kappa_high, 
                           kap_ftype, kap_par_1 , kap_par_2 , kap_par_3 );

endfunction



function my_val = build_fun_central( f_akt, f_low, f_high, my_fun_low, my_fun_high, 
                                     my_fun_type, my_par_1 , my_par_2 , my_par_3 )
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig


         eps_r, mue_r oder kappa aus Datenbank-Eintrag konstruieren 
    #
    # Rolf :
    #
    #  f_akt, f_low, f_high als Input-PARAMETER übergeben : aktuelle Frequenz etc. 
    #  benötigte emk_Data als Input-PARAMETER mit 6 REAL DOUBLEs übergeben


Started on Feb. 26., 2019
Last Changes on Feb. 26., 2019
%}

%{
                                     Status aller Funktionen :

                        a) angedachte Typen fuer 'linlin ':        {  x == (f_akt - f_low) / (f_high - f_low)  }
           OK    0    const. 
           OK    1    linear
           OK    2    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
           OK    3    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
           OK    4    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
          NIX    5    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
          NIX    6    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
           OK    7    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.aeh. ....

                     Diese Funktionen 
                                      sollen wie die Originale AUSSEHEN, wenn die FREQUENZ LOGARITHMISCH GEMEINT ist :
                        b) angedacht fuer 'linlog' :
           TT    31    linear
           OK    32    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
           OK    33    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
           TT    34    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
          NIX    35    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
          NIX    36    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
          NIX    37    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....

                     Diese Funktionen 
                                      sollen entsprechend AUSSEHEN, wenn FREQUENZ UND FUNKTION LOGARITHMISCH GEMEINT sind :
                        c) angedacht fuer 'loglog':
          NIX    61    linear
          NIX    62    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
          NIX    63    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
          NIX    64    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
          NIX    65    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
          NIX    66    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
          NIX    67    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....




                                       History :

 26. Feb.  2019 :  - Beginn Auslagerung der eigentlichen Berechnung HIERHER

%}


%        fuer 'linlin' :
x = (f_akt - f_low) / (f_high - f_low);
%
%                Frequenz-Skala logarithmisch :
%        fuer 'linlog' ,  Ziel :   y( f_akt)  -->  y_2( log10( f_akt) )  o.ae. :
%
% Versuch normiertes u :
    if ( f_low  < 1. )
        u_h = log( f_high);
            if ( (f_akt )  < 1. )
                u = 0.;
            else 
                u = log( f_akt);
            endif
    else 
        u_h = log( f_high / f_low);
            if ( (f_akt )  < 1. )
                u = 0.;
            else 
                u = log( f_akt / f_low);
            endif
    endif
u = u / u_h;



  switch (my_fun_type)
    case 0
        my_val = my_fun_low;
        %
    case 1          % OK   Typ 1     
        my_val = my_fun_low + x * (my_fun_high - my_fun_low);
        %
    case 2          % OK   Typ 2
        x_h = my_par_2;    f_h = my_par_1;
            if ( x <= x_h )
                % Versuch 1, versagt (Knick) :
                %N_h = log10( 1. - f_h) / log10( 1. - x_h);
                % Versuch 2 :
                N_h = f_h * x_h / ( ( 1. - f_h) * ( 1. - x_h) );
                a_h = ( 1. - f_h) / (x_h)^(N_h);
                my_val = 1. - a_h * ( x^(N_h) );
            else
                my_val = f_h * ( 1. - x ) / (1. - x_h);
            endif
        my_val = my_val * (my_fun_low - my_fun_high) + my_fun_high ;
        %
    case 3         % OK   Typ 3
        x_h = my_par_2;    f_h = my_par_1;
            if ( x <= x_h )
                my_val = 1. - x * ( 1. - f_h ) / x_h;
            else
                % analog Typ 2 von oben :
                N_h = ( ( 1. - f_h) * ( 1. - x_h) ) / ( f_h * x_h );
                a_h = f_h / ( (1.-x_h)^(N_h) );
                my_val = a_h * ( (1.-x)^(N_h) );
            endif
        my_val = my_val * (my_fun_low - my_fun_high) + my_fun_high ;
        %
    case 4         % OK   Typ 4
        x_05 = x - 0.5;
        my_fun_m = 0.5 * (my_fun_high + my_fun_low); 
        my_fun_amp = (my_fun_high - my_fun_low) * 1.5;
        % steigend oder fallend  OK :
        my_val = my_fun_m + my_fun_amp * ( x_05 - x_05^3 * 4. / 3. );   
            %if (my_fun_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
    case 5         % FEHLT
        my_val = my_fun_low;
        %
    case 6         % FEHLT
        my_val = my_fun_low;
        %
    case 7     % FEHLT / OK ??????
        x_05 = (x - 0.5)^2;
        my_val = my_fun_low + (my_fun_high - my_fun_low) * my_par_1 * 
                              (16. * x_05^2 - 8. * x_05 + 1.);
        %
    case 31        % FEHLT/OK   Typ 31    ???????
        %  linlog von :   my_val = my_fun_low + x * (my_fun_high - my_fun_low);
        my_val = my_fun_low + u * (my_fun_high - my_fun_low);
         %
    case 32          %  Typ 32   sieht fallend OK aus (07.Okt.18)
        f_h = my_par_1;
        %x_h = my_par_2;
        u_p = my_par_2;
        %   sinnlose Versuche :
        %{
        %u_p = log( 1. + my_par_2 * (e - 1.) );    % war V2
        % V3 :
        u_p = f_low + my_par_2  * (f_high - f_low);    %  f_Umschalt
            if ( f_low  < 1. )
                if ( (u_p )  < 1. )
                    u_p = 0.;
                else 
                    u_p = log( u_p);
                endif
            else 
                if ( (u_p )  < 1. )
                    u_p = 0.;
                else 
                    u_p = log( u_p / f_low);
                endif
            endif
        u_p = u_p / u_h;
        %
        disp('');
        disp(['  bei Typ 32  UMSCHALT-u_p  :  ', num2str(u_p), '   :']);
        %disp(' PAUSE !    Weiter mit Taste ...');
        %pause();
        %
        %}
        %
            if ( u <= u_p )
                N_h = f_h * u_p / ( ( 1. - f_h) * ( 1. - u_p) );
                a_h = ( 1. - f_h) / (u_p)^(N_h);
                my_val = 1. - a_h * ( u^(N_h) );
            else
                my_val = f_h * ( 1. - u ) / (1. - u_p);
            endif
        my_val = my_val * (my_fun_low - my_fun_high) + my_fun_high ;
        %
        %
    case 33         %  Typ 33    ???    fallend OK (08.Okt.18)
        f_h = my_par_1;
        u_p = my_par_2;
        %
            if ( u <= u_p )
                my_val = 1. - u * ( 1. - f_h ) / u_p;
            else
                % analog Typ 32 von oben :
                N_h = ( ( 1. - f_h) * ( 1. - u_p) ) / ( f_h * u_p );
                a_h = f_h / ( (1. - u_p)^(N_h) );
                my_val = a_h * ( (1. - u)^(N_h) );
            endif
        my_val = my_val * (my_fun_low - my_fun_high) + my_fun_high ;
        %
    case 34         %    Typ 34
        %
        %                  das war linlin :
        %x_05 = x - 0.5;
        %my_fun_m = 0.5 * (my_fun_high + my_fun_low);
        %my_fun_amp = (my_fun_high - my_fun_low) * 1.5;
        %
        % steigend oder fallend OK :
        %my_val = my_fun_m + my_fun_amp * ( x_05 - x_05^3 * 4. / 3. );   
            %if (my_fun_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
        %                  nun linlog :
        % Versuch 1 :
        %x_05 = u - 0.5;     % UNSINN, ABER FUER 'linlin' GUTER KOMPLETTER BUCKEL !!!
        % Versuch 2 :
        x_05 = u - 0.5;
        %
        my_fun_m = 0.5 * (my_fun_high + my_fun_low); 
        my_fun_amp = (my_fun_high - my_fun_low) * 1.5;
        %
        % steigend oder fallend :
        my_val = my_fun_m + my_fun_amp * ( x_05 - (x_05^3) * (4. / 3.) );   
        %
    case 61        % FEHLT Typ 61
        %  loglog von :     my_val = my_fun_low + x * (my_fun_high - my_fun_low);
        %  S.o. linlog (Typ 31) :
        %my_val = my_fun_low + u * (my_fun_high - my_fun_low);
        %
    otherwise
        % ...
  endswitch

endfunction
