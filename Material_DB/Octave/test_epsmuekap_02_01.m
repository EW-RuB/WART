%
%{
The 11. correct 3D 'animation' of 
PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

HERE :  Test Material-Datenbank in Octave

Started on Nov. 11., 2018
Last Changes on Nov. 11., 2018
%}

%{
                       History :

 11. Nov.  2018 :  - Beginn als Kopie von 'test_epsmuekap_01_03.m' :
                     3 Parameter MEHR in Datenbank ; Rehenfolge NEU                     Test OK
 
 
                                    ALT in test_epsmuekap_01 :

 07. Oct   2018 :  - weiter build_epsmuekap_01() und hier , massiv neue Fkt-Typen 'logx' begonnen

 13. Sep   2018 :  - weiter build_epsmuekap_01() und hier

 12. Sep   2018 :  - weiter build_epsmuekap_01() und hier
                       ==> Material-Datenbank-Eintraege WASSER HIER MASSIV KORRIGIERT    !!! 
                   - neues (Fern-)Ziel :  
                     Verkettung mehrerer zusammengehoerender Datenbank_Eintraege im Plot
                             ==> Modell-Gesamt-Frequenzgaenge eps_r und kappa

 11. Sep   2018 :  - Beginn build_epsmuekap_01() und erste TEST-Aufrufe VON HIER AUS !
                       ==> Material-Datenbank-Eintraege VON HAND HIERHER !!!!   
 
%}


more off;
clear all;


% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;


%                Material-Datenbank-Eintraege VON HAND HIERHER !!!  :
%           { teilweise NOCH PRIMITIVE VERSIONEN FKT-TYP !!! }
%
%           Salzwasser :

%%%%%emk_Data_ALL(:,8) = [81., 0., 1., 1., 1., 0.02111111, 0., 1., 1., 1., 1.00000, 0., 1., 1., 1., 0., 1.e9];
%%%%%emk_Data_ALL(:,9) = [81., 2., 9., 0.9, 0.15, 0.02111111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];

%          AB HIER NEU    11. Nov. 2018 : 
emk_Data_ALL(:,8) = [81., 0., 81., 1., 1., 1., 0.02111111, 0., 0.02111111, 1., 1., 1., 1.00000, 0., 1.00000, 1., 1., 1., 0., 1.e9];
emk_Data_ALL(:,9) = [81., 32., 9., 0.9, 0.23, 0., 0.02111111, 0., 0.02111111, 1., 1., 1., 1.0000, 0., 1.0000, 1., 1., 1., 1.e9, 1.e10];
%
%           Trinkwasser :
%
%%%%%%%emk_Data_ALL(:,10) = [81., 0., 1., 1., 1., 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 0., 1.e9];
emk_Data_ALL(:,10) = [81., 0., 81., 1., 1., 1., 0.00031111, 0., 0.00031111, 1., 1., 1., 1.0000, 0., 1.0000, 1., 1., 1., 0., 1.e9];
%
% Versuch 3 { eps_r faellt nach Typ 32 von Maximum } :         OK
%emk_Data_ALL(:,11) = [81., 32., 9., 0.9, 0.15, 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];
% sanfterer Abfall, besser :
%%%%%%%emk_Data_ALL(:,11) = [81., 32., 9., 0.9, 0.23, 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];
emk_Data_ALL(:,11) = [81., 32., 9., 0.9, 0.23, 0., 0.00031111, 0., 0.00031111, 1., 1., 1., 1.0000, 0., 1.0000, 1., 1., 1., 1.e9, 1.e10];
%
% Versuch 4 { eps_r faellt nach Typ 33 auf Minimum  OK  ;  kappa = Typ 34 steigend } :
%%%%%%%emk_Data_ALL(:,12) = [9., 33., 3.1111, 0.1, 0.8, 0.000311111, 34., 3111.11, 1., 0., 1.0000, 0., 1., 1., 1., 1.e10, 3.75e13];
emk_Data_ALL(:,12) = [9., 33., 3.1111, 0.1, 0.8, 0., 0.00031111, 34., 3111.11, 1., 0., 0., 1.0000, 0., 1.0000, 1., 1., 1., 1.e10, 3.75e13];
%
% Versuch 2 { eps_r konstant ; kappa = Typ 34 fallend } :      OK
%%%%%%%emk_Data_ALL(:,13) = [3.1111, 0., 1., 1., 1., 3111.11, 34., 0.0003111, 2., 0., 1.0000, 0., 1., 1., 1., 3.75e13, 3.75e14];
emk_Data_ALL(:,13) = [3.1111, 0., 3.1111, 1., 1., 1., 3111.11, 34., 0.0003111, 2., 0., 0., 1.0000, 0., 1.0000, 1., 1., 1., 3.75e13, 3.75e14];
%
%%%%%%emk_Data_ALL(:,14) = [3.1111, 34., 3.2222, 1., 1., 0.000311111, 0., 1., 1., 1., 1.000, 0., 1., 1., 1., 3.75e14, 5.e14];
emk_Data_ALL(:,14) = [3.1111, 34., 3.2222, 1., 0., 0., 0.000311111, 0., 0.000311111, 1., 1., 1., 1.000, 0., 1.000, 1., 1., 1., 3.75e14, 5.e14];
%
%       SINN ????  :
%emk_Data_ALL(:,15) = [81., 1., 9., 1., 1., 0.000311111, 0., 1., 1., 1., 1.000, 0., 1., 1., 1., 1.e9, 1.e10];
                      



%               EIGENTLICHER TEST :

%              PASSENDE Werte fuer Funktions-Tests :
%emk_Data = emk_Data_ALL(:,8);      % OK, nur eps_r = const ; kappa = const
%
%emk_Data = emk_Data_ALL(:,11);     % OK, ALTE Daten Versuch 1 :  eps_r = Typ 1 fallend ; kappa = const
%emk_Data = emk_Data_ALL(:,11);     % OK, NEUE Daten Versuch 2 :  eps_r = Typ 2 fallend ; kappa = const
%emk_Data = emk_Data_ALL(:,11);     % OK, NEUE Daten Versuch 3 :  eps_r = Typ 32 fallend ; kappa = const
%
%emk_Data = emk_Data_ALL(:,12);     % OK, ALTE Daten :   eps_r = linear ; kappa = Typ 4
%emk_Data = emk_Data_ALL(:,12);     % OK, NEUE Daten :   eps_r = Typ 3 ; kappa = Typ 4 steigend 
emk_Data = emk_Data_ALL(:,12);     %  NEUE Daten    :   eps_r = Typ 33 FALLEND OK   ;   kappa = Typ 34 steigend  
%
%emk_Data = emk_Data_ALL(:,13);     % OK, NEUE Daten :   eps_r = Typ 3 ???? KONST !!!!!   ;   kappa = Typ 4 fallend
%emk_Data = emk_Data_ALL(:,13);     %  NEUE Daten :   eps_r = const   ;    kappa = Typ 4 fallend
%
%emk_Data = emk_Data_ALL(:,14);     %  NEUE Daten    :   eps_r = Typ 34 STEIGEND   ;   kappa = const
%



f_low = emk_Data(19);     f_high = emk_Data(20);



%N_Test = 1000;     % am unteren log()-Ende zu wenig
%N_Test = 3000;
N_Test = 10000;



f_test = linspace( f_low, f_high, N_Test);

    for n = 1:N_Test
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data);
        %
        eps_r_1(n) = eps_rO;        mue_r_1(n) = mue_rO;         kappa_1(n) = kappaO;

%{
%                     ANFANG NUR FUER TESTZWECKE :
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
%
X_N(n) = x;
U_N(n) = u;
%    linlin   x_05 = x -0.5;      1.5 * ( x_05 - (x_05^3) * (4. / 3.) );
u_05 = u - 0.5;
U_N4(n) = 0.5 +  1.5 * ( u_05 - ( u_05^3 * 4./3 ) );
%
%                       ENDE NUR FUER TESTZWECKE 
%}
    endfor



%               Plots :

figure(1)
%plot( f_test, eps_r_1, 'r');
plot( f_test, kappa_1, 'm');
%title('eps_r_1');
title('kappa_1');


figure(2)
%plot( f_test, kappa_1, 'm');
semilogx( f_test, kappa_1, 'r');
%semilogx( f_test, eps_r_1, 'r');
title('kappa_1');
%title('eps_r_1');


%{
figure(11)
plot( f_test, X_N, 'r');
hold on;
plot( f_test, U_N, 'm');
title('lineare und logarithmische Hilfsvariablen');


figure(12)
semilogx( f_test, U_N, 'm');
hold on;
semilogx( f_test, U_N4, 'm');
title('lineare und logarithmische Hilfsvariablen');
%}




                                % Concatenate :

clear f_test;   clear N_Test;

                % Versuch 1 :

emk_Data_10 = emk_Data_ALL(:,10);

f_low = emk_Data_10(19);     f_high = emk_Data_10(20);

N_Test_10 = 1000;

f_test = linspace( f_low, f_high, N_Test_10);

    for n = 1:N_Test_10
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data_10);
        %
        eps_r_1_g(n) = eps_rO;        mue_r_1_g(n) = mue_rO;         kappa_1_g(n) = kappaO;
    endfor

f_test_g = f_test;

N_Test = N_Test_10;


emk_Data_11 = emk_Data_ALL(:,11);

f_low = emk_Data_11(19);     f_high = emk_Data_11(20);

N_Test_11 = 1000;

f_test = linspace( f_low, f_high, N_Test_11);

    for n = 1:N_Test_11
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data_11);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor
 
f_test_g = [f_test_g, f_test];
   
N_Test = N_Test + N_Test_11;


emk_Data_12 = emk_Data_ALL(:,12);

f_low = emk_Data_12(19);     f_high = emk_Data_12(20);

N_Test_12 = 1000;

f_test = linspace( f_low, f_high, N_Test_12);

    for n = 1:N_Test_12
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data_12);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor

f_test_g = [f_test_g, f_test];
    
N_Test = N_Test + N_Test_12;


emk_Data_13 = emk_Data_ALL(:,13);

f_low = emk_Data_13(19);     f_high = emk_Data_13(20);

N_Test_13 = 1000;

f_test = linspace( f_low, f_high, N_Test_13);

    for n = 1:N_Test_13
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data_13);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor

f_test_g = [f_test_g, f_test];
    
N_Test = N_Test + N_Test_13;


emk_Data_14 = emk_Data_ALL(:,14);

f_low = emk_Data_14(19);     f_high = emk_Data_14(20);

N_Test_14 = 1000;

f_test = linspace( f_low, f_high, N_Test_14);

    for n = 1:N_Test_14
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_02( f_akt, emk_Data_14);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor

f_test_g = [f_test_g, f_test];
    
N_Test = N_Test + N_Test_14;




%               Plots :

figure(3)
semilogx( f_test_g, eps_r_1_g, 'r');
title('eps_r_1');


figure(4)
semilogx( f_test_g, kappa_1_g, 'm');
title('kappa_1');



figure(5)
loglog( f_test_g, eps_r_1_g, 'r');
title('eps_r_1');


figure(6)
loglog( f_test_g, kappa_1_g, 'm');
title('kappa_1');



%  fuer 'linlog' :

%l_f_test_g = log10(f_test_g);

