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
Last Changes on Sep. 12., 2018
%}

%{
                       History :

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
                           7    biquadratisch Buckel, von Abl=0. (=Min) nach Abl=0.(=Min), Max=Par_1 bei x=0.5 oder aehnlich ....
                        
                        b) eps_r, mue_r und kappa jeweils fuer aktuelle Frequenz berechnen
%}


% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;

%radw = pi / 180.;


f_low = emk_Data(16);      f_high = emk_Data(17);

x = (f_akt - f_low) / (f_high - f_low);


eps_r_low = emk_Data(1);      eps_r_high = emk_Data(3);     eps_ftype = int32( emk_Data(2) + 0.001); 
eps_par_1 = emk_Data(4);      eps_par_2 = emk_Data(5);

    if (eps_ftype == 0)
        eps_r = eps_r_low;
        %
    elseif (eps_ftype == 1)         % OK   Typ 1
        eps_r = eps_r_low + x * (eps_r_high - eps_r_low);
        %
    elseif (eps_ftype == 2)         % OK   Typ 2
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
    elseif (eps_ftype == 3)         % OK   Typ 3
        x_h = eps_par_2;    f_h = eps_par_1;
            if ( x <= x_h )
                eps_r = 1. - x * ( 1. - f_h ) / x_h;
            else
                % analog Versuch 2 von oben :
                % Versuch 1 :
                %N_h = f_h * x_h / ( ( 1. - f_h) * ( 1. - x_h) );    % NOCH UNSINN !!!
                % Versuch 2 :
                N_h = ( ( 1. - f_h) * ( 1. - x_h) ) / ( f_h * x_h );    % OK
                a_h = f_h / ( (1.-x_h)^(N_h) );
                eps_r = a_h * ( (1.-x)^(N_h) );
            endif
        eps_r = eps_r * (eps_r_low - eps_r_high) + eps_r_high ;
        %
    elseif (eps_ftype == 4)         % OK   Typ 4
        x_05 = x - 0.5;
        eps_m = 0.5 * (eps_r_high + eps_r_low);     eps_amp = (eps_r_high - eps_r_low) * 1.5;
        eps_r = eps_m + eps_amp * ( x_05 - x_05^3 * 4. / 3. );   % steigend oder fallend
            %if (eps_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
    elseif (eps_ftype == 5)         % FEHLT
        eps_r = eps_r_low;
        %
    elseif (eps_ftype == 6)         % FEHLT
        eps_r = eps_r_low;
        %
    else      %if (eps_ftype == 7)  % FEHLT
        x_05 = (x - 0.5)^2;
                % noch Unsinn :
        eps_r = eps_r_low + (eps_r_high - eps_r_low) * (x_05^2 - x_05 + 1.);
        %
    endif



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

    if (kap_ftype == 0)
        kappa = kappa_low;
    elseif (kap_ftype == 1)         % OK   Typ 1
        kappa = kappa_low + x * (kappa_high - kappa_low);
        %
    elseif (kap_ftype == 2)         % OK   Typ 2
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
    elseif (kap_ftype == 3)         % OK   Typ 3
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
    elseif (kap_ftype == 4)         % OK   Typ 4
        x_05 = x - 0.5;
        kap_m = 0.5 * (kappa_high + kappa_low);     kap_amp = (kappa_high - kappa_low) * 1.5;
        kappa = kap_m + kap_amp * ( x_05 - x_05^3 * 4. / 3. );   % steigend
            %if (kap_amp > 0)   % steigend
            %else               % fallend
            %endif
        %
    elseif (kap_ftype == 5)
        kappa = kappa_low;
    elseif (kap_ftype == 6)
        kappa = kappa_low;
    else        %if (kap_ftype == 7)
        kappa = kappa_low;
    endif


endfunction
