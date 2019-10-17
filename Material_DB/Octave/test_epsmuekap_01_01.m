%
%{
The 10. correct 3D 'animation' of 
PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

HERE :  Test Material-Datenbank in Octave

Started on Sep. 11., 2018
Last Changes on Sep. 13., 2018
%}

%{
                       History :

 13. Sep   2018 :  - weiter build_epsmuekap_01() und hier
                   - 

 12. Sep   2018 :  - weiter build_epsmuekap_01() und hier
                       ==> Material-Datenbank-Eintraege WASSER HIER MASSIV KORRIGIERT    !!!!!!!!!!!!!  
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


%                Material-Datenbank-Eintraege VON HAND HIERHER !!!!  :
%           { teilweise NOCH PRIMITIVE VERSIONEN FKT-TYP !!!!!!! }
%
%           Salzwasser :
emk_Data_ALL(:,8) = [81., 0., 1., 1., 1., 0.02111111, 0., 1., 1., 1., 1.00000, 0., 1., 1., 1., 0., 1.e9];
emk_Data_ALL(:,9) = [81., 2., 9., 0.9, 0.15, 0.02111111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];
%           Trinkwasser :
emk_Data_ALL(:,10) = [81., 0., 1., 1., 1., 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 0., 1.e9];
% alt, eps_r fällt linear :
%emk_Data_ALL(:,11) = [81., 1., 9., 1., 1., 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];
% Versuch 2 { eps_r faellt nach Typ2 von Maximum } :
emk_Data_ALL(:,11) = [81., 2., 9., 0.9, 0.15, 0.000311111, 0., 1., 1., 1., 1.0000, 0., 1., 1., 1., 1.e9, 1.e10];
%
% alt, eps_r fällt linear :
%emk_Data_ALL(:,12) = [9., 1., 3.1111, 1., 1., 0.000311111, 4., 3111.11, 1., 1., 1.0000, 0., 1., 1., 1., 1.e10, 3.75e13];
% Versuch 2 { eps_r faellt nach Typ3 auf Minimum ; kappa = Typ 4 } :
emk_Data_ALL(:,12) = [9., 3., 3.1111, 0.1, 0.8, 0.000311111, 4., 3111.11, 1., 1., 1.0000, 0., 1., 1., 1., 1.e10, 3.75e13];
%
emk_Data_ALL(:,13) = [3.1111, 0., 1., 1., 1., 3111.11, 4., 0.0003111, 2., 1., 1.0000, 0., 1., 1., 1., 3.75e13, 3.75e14];
%
emk_Data_ALL(:,14) = [3.1111, 4., 3.2222, 1., 1., 0.000311111, 0., 1., 1., 1., 1.000, 0., 1., 1., 1., 3.75e14, 5.e14];
%
emk_Data_ALL(:,15) = [81., 1., 9., 1., 1., 0.000311111, 0., 1., 1., 1., 1.000, 0., 1., 1., 1., 1.e9, 1.e10];
                      



%               EIGENTLICHER TEST :

%              PASSENDE Werte fuer Funktions-Tests :
%emk_Data = emk_Data_ALL(:,8);      % OK, nur eps_r = const ; kappa = const
%
%emk_Data = emk_Data_ALL(:,11);     % OK, ALTE Daten Versuch 1 :  eps_r = lin ; kappa = const
%emk_Data = emk_Data_ALL(:,11);     % OK, NEUE Daten Versuch 2 :  eps_r = Typ 2 ; kappa = const
%
%emk_Data = emk_Data_ALL(:,12);     % OK, ALTE Daten :   eps_r = linear ; kappa = Typ 4
%emk_Data = emk_Data_ALL(:,12);      % OK, NEUE Daten :   eps_r = Typ 3 ; kappa = Typ 4 steigend
%
emk_Data = emk_Data_ALL(:,13);      %  NEUE Daten :   eps_r = Typ 3 ; kappa = Typ 4 fallend
%

f_low = emk_Data(16);     f_high = emk_Data(17);



N_Test = 1000;

f_test = linspace( f_low, f_high, N_Test);

    for n = 1:N_Test
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data);
        %
        eps_r_1(n) = eps_rO;        mue_r_1(n) = mue_rO;         kappa_1(n) = kappaO;
    endfor



%               Plots :

figure(1)
plot( f_test, eps_r_1, 'r');
title('eps_r_1');


figure(2)
plot( f_test, kappa_1, 'm');
title('kappa_1');



                                % Concatenate :

clear f_test;   clear N_Test;

                % Versuch 1 :

emk_Data_10 = emk_Data_ALL(:,10);

f_low = emk_Data_10(16);     f_high = emk_Data_10(17);

N_Test_10 = 1000;

f_test = linspace( f_low, f_high, N_Test_10);

    for n = 1:N_Test_10
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data_10);
        %
        eps_r_1_g(n) = eps_rO;        mue_r_1_g(n) = mue_rO;         kappa_1_g(n) = kappaO;
    endfor

f_test_g = f_test;

N_Test = N_Test_10;


emk_Data_11 = emk_Data_ALL(:,11);

f_low = emk_Data_11(16);     f_high = emk_Data_11(17);

N_Test_11 = 1000;

f_test = linspace( f_low, f_high, N_Test_11);

    for n = 1:N_Test_11
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data_11);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor
 
f_test_g = [f_test_g, f_test];
   
N_Test = N_Test + N_Test_11;


emk_Data_12 = emk_Data_ALL(:,12);

f_low = emk_Data_12(16);     f_high = emk_Data_12(17);

N_Test_12 = 1000;

f_test = linspace( f_low, f_high, N_Test_12);

    for n = 1:N_Test_12
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data_12);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor

f_test_g = [f_test_g, f_test];
    
N_Test = N_Test + N_Test_12;


emk_Data_13 = emk_Data_ALL(:,13);

f_low = emk_Data_13(16);     f_high = emk_Data_13(17);

N_Test_13 = 1000;

f_test = linspace( f_low, f_high, N_Test_13);

    for n = 1:N_Test_13
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data_13);
        %
        eps_r_1_g(n + N_Test) = eps_rO;        mue_r_1_g(n + N_Test) = mue_rO;         kappa_1_g(n + N_Test) = kappaO;
    endfor

f_test_g = [f_test_g, f_test];
    
N_Test = N_Test + N_Test_13;


emk_Data_14 = emk_Data_ALL(:,14);

f_low = emk_Data_14(16);     f_high = emk_Data_14(17);

N_Test_14 = 1000;

f_test = linspace( f_low, f_high, N_Test_14);

    for n = 1:N_Test_14
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_01( f_akt, emk_Data_14);
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
