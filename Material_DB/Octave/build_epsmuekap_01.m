function [eps_r, mue_r, kappa] = build_epsmuekap_01( f_akt, emk_Data)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       eps_r, mue_r und kappa aus Datenbank-Eintrag konstruieren :
    #           ( geeignet mindestens bei :
    #              -    alle Faelle 'delta' , d.h. ALLE Medien mit Daempfung )
    #
    # Rolf :
    #
    #  f_akt als Input-PARAMETER uebergeben : aktuelle Frequenz in Hz
    #  emk_Data als Input-PARAMETER-Vektor mit 17 REAL DOUBLEs uebergeben

Started on Sep. 11., 2018
Last Changes on Oct. 08., 2018
%}

%{
                       History :

 08. Oct.  2018 :  - weiter 'linlog' (fuer eps_r) :  Formeln fuer 'fallend' Typen 32 und 33     OK

 07. Oct.  2018 :  - Abfrage von if() auf switch() geaendert (fuer eps_r)
                   - Einfall : 'NEUE Funktions-Typen' : 'Duplikate' der Original-Typen ,
                                                         normiert  { alt :   x == (f_akt - f_low) / (f_high - f_low)  } .
                     Diese Funktionen 
                                      sollen wie die Originale AUSSEHEN, wenn die FREQUENZ LOGARITHMISCH GEMEINT ist :
                        a) angedacht fuer 'linlog' :       
                           31    linear
                     OK    32    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                     OK    33    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                           34    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                           35    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                           36    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                           37    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....
                     Diese Funktionen 
                                      sollen entsprechend AUSSEHEN, wenn FREQUENZ UND FUNKTION LOGARITHMISCH GEMEINT sind :
                        b) angedacht fuer 'loglog':
                           61    linear
                           62    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                           63    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                           64    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                           65    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                           66    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                           67    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.ae. ....
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
                   - Beginn 'Funktionen implementieren' :
                        a) angedachte Typen :        {  x == (f_akt - f_low) / (f_high - f_low)  }
                     OK    0    const. 
                     OK    1    linear
                     OK    2    Parabel N-ter Ordnung, linker Rand von Abl=0 bei x=0 nach Abl=Par_2 bei x=Par_1, dann knickfrei linear
                     OK    3    linker Rand Abl=Par_2 bei x=0 linear bis x=Par_1, dann Parabel N-ter Ordnung bis x=1, Abl=0
                     OK    4    Parabel 3. Ordnung, an Raendern von Abl=0 nach Abl=0, WP bei x=0.5
                           5    fallend mit Resonanzen, Max u. Min als Par_1 u. Par_2,  Par_3 = x_max bzw. (1 - x_min)       Par_3 FEHLT
                           6    doppelt exponentiell, von Abl=+-0.001 nach Abl=-+0.001, WP bei x=0.5 oder aehnlich ....
                     OK    7    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder Par_2 o.aeh. ....
                        
                        b) eps_r, mue_r und kappa jeweils fuer aktuelle Frequenz berechnen
%}


% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;

%radw = pi / 180.;


f_low = emk_Data(16);      f_high = emk_Data(17);

%        fuer 'linlin' :
x = (f_akt - f_low) / (f_high - f_low);
%
%                Frequenz-Skala logarithmisch :
%        fuer 'linlog' ,  Ziel :   y( f_akt)  -->  y_2( log10( f_akt) )  o.ae. :
%
% Versuch 2 , normiertes u :
%u = log( 1. + x * ( e - 1.) );
%
% Versuch 3 , normiertes u :
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




eps_r_low = emk_Data(1);      eps_r_high = emk_Data(3);     eps_ftype = int32( emk_Data(2) + 0.001); 
eps_par_1 = emk_Data(4);      eps_par_2 = emk_Data(5);

  switch (eps_ftype)
    case 0
        eps_r = eps_r_low;
        %
    case 1          % OK   Typ 1     
        eps_r = eps_r_low + x * (eps_r_high - eps_r_low);
        %
    case 2          % OK   Typ 2
        x_h = eps_par_2;    f_h = eps_par_1;
            if ( x <= x_h )
                % Versuch 1, versagt (Knick) :
                %N_h = log10( 1. - f_h) / log10( 1. - x_h);
                % Versuch 2 :
                N_h = f_h * x_h / ( ( 1. - f_h) * ( 1. - x_h) );
                a_h = ( 1. - f_h) / (x_h)^(N_h);
                eps_r = 1. - a_h * ( x^(N_h) );
            else
                eps_r = f_h * ( 1. - x ) / (1. - x_h);
            endif
        eps_r = eps_r * (eps_r_low - eps_r_high) + eps_r_high ;
        %
    case 3         % OK   Typ 3
        x_h = eps_par_2;    f_h = eps_par_1;
            if ( x <= x_h )
                eps_r = 1. - x * ( 1. - f_h ) / x_h;
            else
                % analog Typ 2 von oben :
                N_h = ( ( 1. - f_h) * ( 1. - x_h) ) / ( f_h * x_h );
                a_h = f_h / ( (1.-x_h)^(N_h) );
                eps_r = a_h * ( (1.-x)^(N_h) );
            endif
        eps_r = eps_r * (eps_r_low - eps_r_high) + eps_r_high ;
        %
    case 4         % OK   Typ 4
        x_05 = x - 0.5;
        eps_m = 0.5 * (eps_r_high + eps_r_low);     eps_amp = (eps_r_high - eps_r_low) * 1.5;
        eps_r = eps_m + eps_amp * ( x_05 - x_05^3 * 4. / 3. );   % steigend oder fallend
            %if (eps_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
    case 5         % FEHLT
        eps_r = eps_r_low;
        %
    case 6         % FEHLT
        eps_r = eps_r_low;
        %
    case 7     % FEHLT / OK ??????
        x_05 = (x - 0.5)^2;
        eps_r = eps_r_low + (eps_r_high - eps_r_low) * eps_par_1 * (16. * x_05^2 - 8. * x_05 + 1.);
        %
    case 31        % FEHLT/OK   Typ 31    ???????
        %  linlog von :     eps_r = eps_r_low + x * (eps_r_high - eps_r_low);
        eps_r = eps_r_low + u * (eps_r_high - eps_r_low);
         %
    case 32          %  Typ 32   sieht fallend OK aus (07.Okt.18)
        f_h = eps_par_1;
        %x_h = eps_par_2;
        u_p = eps_par_2;
        %   sinnlose Versuche :
        %{
        %u_p = log( 1. + eps_par_2 * (e - 1.) );    % war V2
        % V3 :
        u_p = f_low + eps_par_2  * (f_high - f_low);    %  f_Umschalt
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
                eps_r = 1. - a_h * ( u^(N_h) );
            else
                eps_r = f_h * ( 1. - u ) / (1. - u_p);
            endif
        eps_r = eps_r * (eps_r_low - eps_r_high) + eps_r_high ;
        %
        %
    case 33         %  Typ 33    ???    fallend OK (08.Okt.18)
        f_h = eps_par_1;
        u_p = eps_par_2;
        %
            if ( u <= u_p )
                eps_r = 1. - u * ( 1. - f_h ) / u_p;
            else
                % analog Typ 32 von oben :
                N_h = ( ( 1. - f_h) * ( 1. - u_p) ) / ( f_h * u_p );
                a_h = f_h / ( (1. - u_p)^(N_h) );
                eps_r = a_h * ( (1. - u)^(N_h) );
            endif
        eps_r = eps_r * (eps_r_low - eps_r_high) + eps_r_high ;
        %
    case 34         %    Typ 34
        %
        %                  das war linlin :
        %x_05 = x - 0.5;
        %eps_m = 0.5 * (eps_r_high + eps_r_low);     eps_amp = (eps_r_high - eps_r_low) * 1.5;
        %
        %eps_r = eps_m + eps_amp * ( x_05 - x_05^3 * 4. / 3. );   % steigend oder fallend
            %if (eps_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
        %                  nun linlog :
        % Versuch 1 :
        %x_05 = u - 0.5;     % UNSINN, ABER FUER 'linlin' GUTER KOMPLETTER BUCKEL !!!
        % Versuch 2 :
        x_05 = u - 0.5;
        %
        eps_m = 0.5 * (eps_r_high + eps_r_low);     eps_amp = (eps_r_high - eps_r_low) * 1.5;
        %
        eps_r = eps_m + eps_amp * ( x_05 - (x_05^3) * (4. / 3.) );   % steigend oder fallend
        %
    case 61        % FEHLT Typ 61
        %  loglog von :     eps_r = eps_r_low + x * (eps_r_high - eps_r_low);
        %  S.o. linlog (Typ 31) :
        %eps_r = eps_r_low + u * (eps_r_high - eps_r_low);
        %
    otherwise
        % ...
  endswitch



mue_r_low = emk_Data(11);     mue_r_high = emk_Data(13);    mue_ftype = int32( emk_Data(12) + 0.001);
mue_par_1 = emk_Data(14);     mue_par_2 = emk_Data(15);

    if (mue_ftype == 0)
        mue_r = mue_r_low;
    elseif (mue_ftype == 1)
        mue_r = mue_r_low + x * (mue_r_high - mue_r_low);
    elseif (mue_ftype == 2)
        mue_r = mue_r_low;
    elseif (mue_ftype == 3)
        mue_r = mue_r_low;
    elseif (mue_ftype == 4)
        mue_r = mue_r_low;
    elseif (mue_ftype == 5)
        mue_r = mue_r_low;
    elseif (mue_ftype == 6)
        mue_r = mue_r_low;
    else        %if (mue_ftype == 7)
        mue_r = mue_r_low;
    endif

    

kappa_low = emk_Data(6);      kappa_high = emk_Data(8);     kap_ftype = int32( emk_Data(7) + 0.001); 
kap_par_1 = emk_Data(9);      kap_par_2 = emk_Data(10);



  switch (kap_ftype)
    case 0
        kappa = kappa_low;
        %
    case 1                          % OK   Typ 1
        kappa = kappa_low + x * (kappa_high - kappa_low);
        %
    case 2                          % OK   Typ 2
        x_h = kap_par_2;    f_h = kap_par_1;
            if ( x <= x_h )
                N_h = f_h * x_h / ( ( 1. - f_h) * ( 1. - x_h) );
                a_h = ( 1. - f_h) / (x_h)^(N_h);
                kappa = 1. - a_h * ( x^(N_h) );
            else
                kappa = f_h * ( 1. - x ) / (1. - x_h);
            endif
        kappa = kappa * (kappa_low - kappa_high) + kappa_high ;
        %
    case 3                          % OK   Typ 3
        x_h = kap_par_2;    f_h = kap_par_1;
            if ( x <= x_h )
                kappa = 1. - x * ( 1. - f_h ) / x_h;
            else
                N_h = ( ( 1. - f_h) * ( 1. - x_h) ) / ( f_h * x_h );
                a_h = f_h / ( (1.-x_h)^(N_h) );
                kappa = a_h * ( (1.-x)^(N_h) );
            endif
        kappa = kappa * (kappa_low - kappa_high) + kappa_high ;
        %
    case 4                          % OK   Typ 4
        x_05 = x - 0.5;
        kap_m = 0.5 * (kappa_high + kappa_low);     kap_amp = (kappa_high - kappa_low) * 1.5;
        %
        kappa = kap_m + kap_amp * ( x_05 - ((x_05)^3) * 4. / 3. );   % OK
        %
    case 5                          % FEHLT
        kappa = kappa_low;
    case 6                          % FEHLT
        kappa = kappa_low;
    case 7                          % FEHLT / OK ??????
        x_05 = (x - 0.5)^2;
        kappa = kappa_low + (kappa_high - kappa_low) * kap_par_1 * (16. * x_05^2 - 8. * x_05 + 1.);
        %
    case 31        % FEHLT/OK   Typ 31    ???????
        %  linlog von :     kappa = kappa_low + x * (kappa_high - kappa_low);
        kappa = kappa_low + u * (kappa_high - kappa_low);
         %
    case 32          %  Typ 32   sieht fallend OK aus (07.Okt.18)
        f_h = kap_par_1;
        %x_h = kap_par_2;
        u_p = kap_par_2;
        %   sinnlose Versuche :
        %{
        %u_p = log( 1. + kap_par_2 * (e - 1.) );    % war V2
        % V3 :
        u_p = f_low + kap_par_2  * (f_high - f_low);    %  f_Umschalt
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
                kappa = 1. - a_h * ( u^(N_h) );
            else
                kappa = f_h * ( 1. - u ) / (1. - u_p);
            endif
        kappa = kappa * (kappa_low - kappa_high) + kappa_high ;
        %
        %
    case 33         %  Typ 33    ???    fallend OK (08.Okt.18)
        f_h = kap_par_1;
        u_p = kap_par_2;
        %
            if ( u <= u_p )
                kappa = 1. - u * ( 1. - f_h ) / u_p;
            else
                % analog Typ 32 von oben :
                N_h = ( ( 1. - f_h) * ( 1. - u_p) ) / ( f_h * u_p );
                a_h = f_h / ( (1. - u_p)^(N_h) );
                kappa = a_h * ( (1. - u)^(N_h) );
            endif
        kappa = kappa * (kappa_low - kappa_high) + kappa_high ;
        %
    case 34         %    Typ 34
        %
        %                  das war linlin :
        %x_05 = x - 0.5;
        %kap_m = 0.5 * (kappa_high + kappa_low);     kap_amp = (kappa_high - kappa_low) * 1.5;
        %
        %kappa = kap_m + kap_amp * ( x_05 - x_05^3 * 4. / 3. );   % steigend oder fallend
            %if (kap_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
        %                  nun linlog :
        % Versuch 1 :
        x_05 = u - 0.5;
        %
        kap_m = 0.5 * (kappa_high + kappa_low);     kap_amp = (kappa_high - kappa_low) * 1.5;
        %
        kappa = kap_m + kap_amp * ( x_05 - (x_05^3) * (4. / 3.) );   % steigend oder fallend
        %
    case 61        % FEHLT Typ 61
        %  loglog von :     kappa = kappa_low + x * (kappa_high - kappa_low);
        %  S.o. linlog (Typ 31) :
        %kappa = kappa_low + u * (kappa_high - kappa_low);
        %
    otherwise 
        %
    endswitch


endfunction
