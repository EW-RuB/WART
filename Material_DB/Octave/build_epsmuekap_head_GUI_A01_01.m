function [eps_r, mue_r, kappa] = build_epsmuekap_head_GUI_01( f_akt, data_struct)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       eps_r, mue_r und kappa aus Datenbank-Eintrag konstruieren :
    #           ( geeignet mindestens für :
    #              -    alle Fälle 'delta' , d.h. ALLE Medien mit Dämpfung )
    #
    # Rolf :
    #   f_akt als Input-PARAMETER übergeben : aktuelle Frequenz in Hz
    # André :
    #   data_struct als Input-PARAMETER-Struct mit 20 REAL DOUBLEs übergeben

Started on Feb. 15., 2019
Last Changes on Feb. 15., 2019
%}

%{
                       History :

 15. Feb.  2019 :  - Beginn Rolf als Kopie von 'build_epsmuekap_A02_02.m' :
                     
                              Logik NEU !  Aufteilung in  
                       'build_epsmuekap_head_DIA.m'    UND     'build_epsmuekap_head_GUI.m'
                          ==>  WAHLWEISE EINE DAVON KOPIERT MAN NACH 'build_epsmuekap.m'

                      DAS und NUR DAS wird vom octave-Hauptprogramm unter FESTEM NAMEN aufgerufen !
                      Der 2. Übergabe-Parameter ist dann eben aus der GUI eine 'struct' und aus dem Dialog ein Vektor !

                      Beide setzen als EINZIGE Aufgabe die Eingabe-Parameter auf einheitliche Typen um !

                         ==> Beide rufen danach das IDENTISCHE 'build_epsmuekap_main.m' auf !

                      DAS hat Versionen, die auf diesen FESTEN Namen kopiert werden.
                      NUR im '..._main()' werden die eigentlichen Berechnungen durchgeführt.

                                           DAS IST NICHT HIER !

                      Die berechneten Werte gehen an den aufrufenden 'wrapper' HIER zurück


                         ALT   build_epsmuekap_A02_02.m :
 13. Dec.  2018 :  - Beginn André als Kopie von 'build_epsmuekap_02_01.m' :
                     Eingabe-Werte aus data-struct lesen !
%}


emk_Data = zeros(20, 1, "double");


emk_Data(19) = data_struct.f_min;        emk_Data(20) = data_struct.f_max;


emk_Data(1) = data_struct.eps_r_fmin;       emk_Data(3) = data_struct.eps_r_fmax;
emk_Data(2) = data_struct.eps_r_Fkt_Typ;
emk_Data(4) = data_struct.eps_r_a;     emk_Data(5) = data_struct.eps_r_b;     emk_Data(6) = data_struct.eps_r_c;


emk_Data(7) = data_struct.kappa_fmin;       emk_Data(9) = data_struct.kappa_fmax;
emk_Data(8) = data_struct.kappa_Fkt_Typ;
emk_Data(10) = data_struct.kappa_a;     emk_Data(11) = data_struct.kappa_b;     emk_Data(12) = data_struct.kappa_c;


emk_Data(13) = data_struct.my_r_fmin;       emk_Data(15) = data_struct.my_r_fmax;
emk_Data(14) = data_struct.my_r_Fkt_Typ;
emk_Data(16) = data_struct.my_r_a;    emk_Data(17) = data_struct.my_r_b;     emk_Data(18) = data_struct.my_r_c;





      [eps_r, mue_r, kappa] = build_epsmuekap_main_01( f_akt, emk_Data)

endfunction
