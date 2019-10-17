function [eps_r, mue_r, kappa] = build_epsmuekap( f_akt, emk_Data)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       eps_r, mue_r und kappa aus Datenbank-Eintrag konstruieren :
    #           ( geeignet mindestens für :
    #              -    alle Faelle 'delta' , d.h. ALLE Medien mit Daempfung )
    #
    # Rolf :
    #
    #  f_akt als Input-PARAMETER übergeben : aktuelle Frequenz in Hz
    #  emk_Data als Input-PARAMETER-Vektor mit 20 REAL DOUBLEs übergeben

Started on Feb. 15., 2019
Last Changes on Feb. 15., 2019
%}

%{
                       History :


 15. Feb.  2019 :  - Beginn als Kopie von 'build_epsmuekap_R02_03_DIA.m' :
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


        ==> DIESER Wrapper IST DERZEIT TOTAL LEER UND NUR DER NAMENSGEBUNG WEGEN VORHANDEN !
              ER MUSS IN DER DIALOG-VERSION NACH 'build_epsmuekap.m' KOPIERT WERDEN !

%}




      [eps_r, mue_r, kappa] = build_epsmuekap_main( f_akt, emk_Data)


endfunction
