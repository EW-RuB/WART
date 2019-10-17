function [k_R_t2, k_I_t2, alpha_t2, psi_t2] = kRt2_Solve_01( ...
                       k_R_e2, k_I_e2, k_30, p_35, alpha_e2, psi_e2)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       krt2-Algorithmus
    #           ( geeignet mindestens bei :
    #              -    alle Faelle 'delta'an Border # 2 , d.h. BEIDE Medien mit Daempfung )
    # 
    #    ( Laufrichtung :  Phase nach +x 
    #                      Daempfung nach +x und +-y , um psi verdreht  )
    # Rolf :
    #      [ (kR + J * kxI)*e_x + J * kyI * e_y ]^2 = om^2 * mue * eps - J * om * mue * kap
    #        (kR + J * kxI)^2 + (J * kyI)^2 = om^2 * mue * eps - J * om * mue * kap
    #        kR^2 - kxI^2 - kyI^2 + J * 2 * kR * kxI = om^2 * mue * eps - J * om * mue * kap
    #        kR^2 - (kxI^2 + kyI^2) + J * 2 * kR * kxI = om^2 * mue * eps - J * om * mue * kap
    #              kI = -sqrt(kxI^2 + kyI^2)   "Achtung : MINUSZEICHEN bei kI !"
    # NEU krt2 :
    #              Cpsi = cos (psi) = kxI / kI   ==>  kxI = kI * Cpsi
    #        kr^2 - ki^2 + J * 2 * kr * ki * Cpsi = om^2 * mue * eps - J * om * mue * kap
    #            a)   kr^2 - ki^2 = om^2 * mue * eps
    #            b)   2 * kr * ki * Cpsi = - om * mue * kap
    #        ki = - (0.5 * om * mue * kap / Cpsi) / kr
    #              k_30_q = om * om * mue * eps          p_35 = 0.5 * om * mue * kap / Cpsi
    #        kr^2 - p_35^2 / kr^2 = k_30_q
    #        kr^4 - k_30_q * kr^2 - p_35^2 = 0       ;  s.o. a)   ==>   kr^2 >= V
    #        kr = sqrt( 0.5 * k_30_q  + sqrt(0.25 * k_30_q^2 + p35^2) )
    #
    #  k_R_e2, k_I_e2, k_30, p_35 als PARAMETER uebergeben
    #  alpha_e2, psi_e2 als PARAMETER uebergeben

Started on Jun. 24., 2018
Last Changes on Aug. 17., 2018
%}

%{
                       History :

 17. Aug.  2018 :  - Beginn Bypass : primitiv als exakt senkr. Einfall naehern, d.h. fuer kleine 
                       alpha_e2 sagen :  psi_t2 = 0.  UND  alpha_t2 = 0.
                       { kleine Restfehler besser als Absturz; bessere Naeherungen spaeter ueberlegen. 
                         1. Einfall dazu : Nur fuer alpha_t2 die "Loesung verlustlos" benutzen; dann 
                         die k_R_t2 , k_I_t2 und psi_t2 verbessern ? }

 24. Jun.  2018 :  - Beginn als Kopie von kRt2_Solve_01_01.m ;
                            Ziele :
                   - neu fuer (nahezu) senkrechten Einfall : Bypass d. Algorithmus, EINFACHE LSG.
                        { zur numerischen Stabilitaet bei Freq. > 1.e17 Hz }
                   - neu genaue Doku, WELCHE Groessen WO und WIE NORMIERT sind (input und output) !

                   
                    ALT :
 
        in kRt2_Solve_01_01.m :

 09. Dez.  2017 :  - Speed up : einige weitere 'disp( )' auskommentiert

 03. Jun.  2017 :  - Code-Kosmetik (Header)
                   - Speed up : einige 'disp( )' auskommentiert

 16. Jan.  2017 :  - Beginn als Kopie von krt2_Solve_01.m : 
                     Namen neu; function heisst nun kRt2_Solve_01; neueste Version immer in gleichnamiges File kopieren
                                              { d.h. alle Aufrufe von extern DARAN anpassen }
                   - Beginn 'numerisch stabilisieren' :
                        a) indem 3 Sonderfaelle VORHER abgefragt werden : wirkungslos !
                        b) Analyse Siehe bei kRt_Solve_05
                     ==> Kriterium abgeaendert, ca. line 215 ! :
                            % ALT                             if( S_bi <= ( 0.99999 * S_bi_kritT ) )
                            %  VERSUCH 16. Jan. 2017 :        if( S_bi <= S_bi_kritT )
                     ==> Ausreisser in EW_o_ESN_HPT_2a2ad_04Rolf.m WEG !                               OK


                   ALT :

 08. Jan.  2017 :  - 2 Einzel-Aussetzer in EW_o_ESN_HPT_2a2ad_03  NOCH FALSCH !!! :
                      bei alpha_e2 = ca. 64 Grad => k_R_t2 u. k_I_t2 BEIDE NULL ,   Im{ZW_t2_tr}, r2 u. t2 MUELL
                        { obiger Fehler KOENNTE ABER am SPRUNG von alpha_t bei alpha_e = ca. 52 Grad liegen !! }
                      bei alpha_e2 = ca. 40 Grad => k_R_t2 ZACKE , alpha_t2 u. psi_t2 ZACKE
                        { obiger Fehler KANN NICHT an SPRUENGEN an Border 1 bei alpha_e = ca. 40 Grad liegen !

 07. Jan.  2017 :  - Korrektur DES FLAGS 'ungueltige Pseudo-Loesung' ;

 30. Aug.  2016 :  - weiter mit k_R_t2 Algorithmus : viele Korrekturen, Code sieht erstmals korrekt aus

 29. Aug.  2016 :  - erste Aufrufe aus "EW_o_ESN_HPT_1b1bd_03"
                   - k_R_t2 Algorithmus ERSTMALS Code bearbeitet  
                             ==> Solver laeuft bereits durch 

 16. Jul.  2016 :  - Beginn als Kopie von "krt_Solve_01"
                   - k_R_t2 Algorithmus NEU HIER ZUERST begonnen  
                             ==> nur formale Parameter-Listen angepasst ; Code alt u. neue Fehler

%}

% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;

radw = pi / 180.;


k_30_q = k_30^2;
S_i = sin(alpha_e2);	C_i = cos(alpha_e2);
beta_e = alpha_e2 - psi_e2;
S_bi = sin(beta_e);	C_bi = cos(beta_e);

k_r_t2_valid = True;

    %         neu Rolf 17.Aug.2018 :
    % winzige Einfallswinkel zu allererst abfangen :
    if( alpha_e2 < 1.e-5 )
        % (vorlaeufig) primitive Naeherung :
        psi_t2 = 0.;
    %#        kr^4 - k_30_q * kr^2 - p_35^2 = 0       ;  s.o. a)   ==>   kr^2 >= V
        k_R_t2 = sqrt( 0.5 * k_30_q  + sqrt(0.25 * k_30_q^2 + p_35^2) );
        k_I_t2 = -sqrt( k_R_t2^2 - k_30_q);   % "Achtung : MINUSZEICHEN bei kI !"
        alpha_t2 = 0.;
        return
    %
    %         weiter wie vor 17.Aug.2018 :
    %if( abs(C_i) > 1.e-5 )
    elseif( abs(C_i) > 1.e-5 )
        %
        %         erster Versuch  =  'k_R_t2-Algorithmus' :
        %    ALTES "p" :
        %h7 = 0.5 * ( (k_R_e2^2 + k_I_e2^2) * S_i^2 + k_30_q );
        %    ALTES "q" :
        %h8 = p_35^2 + ( 2. * p_35 * k_R_e2 * k_I_e2 - k_30_q * k_R_e2^2 ) * S_i^2;
        %    NEUES "p" und "q" :
        %h7 = 0.5 * ( (k_R_e2 * S_i)^2 + (k_I_e2 * S_bi)^2 + k_30_q );
        %h8 = p_35^2 + 2. * p_35 * k_R_e2 * k_I_e2 * S_i * S_bi - k_30_q * (k_R_e2 * S_i)^2;
        h20 = k_R_e2 * S_i;     h21 = k_I_e2 * S_bi;
        h20_q = h20 * h20;     h21_q = h21 * h21;
        h7 = 0.5 * ( h20_q + h21_q + k_30_q );
        h8 = p_35^2 + 2. * p_35 * h20 * h21 - k_30_q * h20_q;
        %
        %  W^2 - 2 * W^1 * h7 - h8  =  0 :
        %
        p3 = h7^2 + h8;
%{
        disp('');
        disp(['  bei k_R_t2  IN DER WURZEL  :  ', num2str(p3), '   :']);
        disp(' PAUSE !    Weiter mit Taste ...');
        pause();
%}
        p3 = sqrt(p3);
        %
        %       neu 16. Jan. 2017 :
        % { numerisch stabilisieren, indem 3 Sonderfaelle VORHER abgefragt werden }
            if( (abs(h8) > 1.e16 ) && (h7 >= 1.e16) )
                % Sonderfall 1 : Vorfaktor quadrat. Term winzig
%                disp('  bei k_R_t2  Sonderfall 1  !');
                %  0-te Naeherung : 
                W0 = - h8 / ( 2. * h7 );
                %  1-te Naeherung { mit delta << W0 } : 
                delta_1 = h8 * h8 / ( 4. * h7 * ( 2. * h7 * h7 + h8 ) );
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            elseif( (abs(h8) >= 1. ) && (h7 <= 1.e-16) )
                % Sonderfall 2 : Vorfaktor lin. Term winzig
%                disp('  bei k_R_t2  Sonderfall 2  !');
                %  0-te Naeherung : 
                W0 = sqrt( h8 );
                %  1-te Naeherung { mit delta << W0    wegen  delta =ca. h7 }: 
                delta_1 = W0 * h7 / ( W0 - h7 );
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            elseif( (abs(h8) <= 1.e-16 ) && (h7 >= 1.) )
                % Sonderfall 3 : absoluter Term winzig
%                disp('  bei k_R_t2  Sonderfall 3  !');
                %  0-te Naeherung : 
                W0 = 2. * h7;
                %  1-te Naeherung ( NICHT mit p3 ; mit delta << W0   ) : 
                delta_1 = h8 / W0;
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            else
                % alter Code vor 16. Jan. 2017 :
                W(1) = h7 + p3;    W(2) = h7 - p3;
            endif
        %
        %       WEITER ALT (vor 16. Jan. 2017) :
        W(1) = h7 + p3;    W(2) = h7 - p3;
        %
        %    FALLS MEHRERE LOESUNGEN existieren mit 0 < k_30_q <= W  :
        W_L_k = k_30_q;
        %clear h;
        [h iw] = size(W);
            for i_W = 1:iw
                h = W(i_W);
                hr = real(h);
                %
                if( (abs(imag(h)) < 1.e-10 ) && (hr >= k_30_q))
                    W_L = hr;
                    %disp('');
                    %disp(['  angebl. Loesung W  # ', num2str(i_W), '   :']);
                    W2_valid = True; k_r_t2_valid = True;
                    k_r_tT = sqrt(W_L);
                    k_i_tT = - sqrt( k_r_tT^2 - k_30_q );
                    %
                    %     28. Aug. '14 / 6. Jan. 15 :
                    S_i_GrenzT = k_r_tT / k_R_e2;
                        if( S_i_GrenzT < 1. )
                            alpha_e_GrenzT = asin( S_i_GrenzT );
                            %h3 = alpha_e_GrenzT / radw;
                            %h1 = sprintf('%12.5e', h3);
                            %disp('');
                            %disp(['laut k_R_t2 EXISTIERT  alpha_e_Grenz2 = ', h1, ' Grad']);
                                if( S_i < S_i_GrenzT )
                                    S_tT = S_i * k_R_e2 / k_r_tT;      
                                    % dies KANN UNGENAU werden fuer alpha_tT --> pi/2 :
                                    alpha_tT = asin(S_tT);	% nur pos. Hauptwert, OK
                                else
                                    % einzige Loesung ; zur Sicherheit ALLES NEU :
                                    k_r_tT = k_R_e2 * S_i;
                                    k_i_tT = - sqrt( k_r_tT^2 - k_30_q );
                                    S_tT = 1.;      
                                    alpha_tT = 0.5 * pi + 1.e-6;
                                endif
                        else
                            S_i_GrenzT = 1.;
                            alpha_e_GrenzT = 0.5 * pi + 1.e-6;
                            S_tT = S_i * k_R_e2 / k_r_tT;      
                            % dies KANN UNGENAU werden fuer alpha_tT --> pi/2 :
                            alpha_tT = asin(S_tT);	% nur pos. Hauptwert, OK
%                            disp('');
%                            disp('es EXISTIERT KEIN alpha_e_Grenz');
                        endif
                    %     weiter ...
                    C_tT = cos(alpha_tT);
                    %
                    %              neu 30. Aug.2016 : NUR DIESE Bedgg. gilt NICHT MEHR, NEU !!! :
                    % alt, von k_r_t :
                    %    die Gl. hiess dort :   k_I_t * sin( alpha_t - psi_t) = k_I_e * sin( alpha_e)
                    %  ==> selbst WENN beta_t == (alpha_t - psi_t) --> 90 Grad, also Filmwelle,
                    %      dann darf  sin( alpha_e ) HOECHSTENS = k_I_t / k_I_e sein !
                    % Ist dies Verhaeltnis < 1 , dann begrenzt dies alpha_e auf  ein Maximum !!!
                    %h = k_i_tT / k_I_e2;	% (spaeter, 'ohne Daempfung', Overflow abfangen !)
                    %
                    % NEU, bei k_R_t2 :
                    %    die Gl. heisst nun :   k_I_t * sin( alpha_t - psi_t) = k_I_e * sin( alpha_e - psi_e)
                    %        d.h. mit :  beta_e2 = alpha_e2 - psi_e2   und   beta_t2 = alpha_t2 - psi_t2
                    %       ==>   k_I_t2 * sin( beta_t2) = k_I_e2 * sin( beta_e2)
                    %  ==> selbst WENN beta_t2  --> 90 Grad , also Filmwelle,
                    %      dann darf  sin( beta_e2 ) HOECHSTENS = k_I_t2 / k_I_e2 sein !
                    h = k_i_tT / k_I_e2;	% 
                    %
                       if( h < 1. )
                            %    NEU, bei k_R_t2 :
                            S_bi_kritT = h;
                            beta_e_kritT = asin( S_bi_kritT );
                            %h3 = beta_e_kritT / radw;
                            %h1 = sprintf('%12.5e', h3);
                            %disp('');
                            %disp(['es EXISTIERT  beta_e2_krit = ', h1, ' Grad']);
                            %
%   ALT :
%                           if( S_bi < ( 0.99999 * S_bi_kritT ) )
%  VERSUCH 16. Jan. 2017 :
                            if( S_bi <= S_bi_kritT )
                            %     weiter ANALOG zu alt :
                                h3 = asin( S_bi * k_I_e2 / k_i_tT );	% nur Hauptwert, | | < pi/2
                                % 2 moegliche Loesungen :
                                psi_tT1 = alpha_tT - h3;
                                psi_tT2 = alpha_tT - pi + h3;
                            else
                                % disp(' UND  alpha_e >= alpha_e_krit !');     % alt
                                %disp(' UND  beta_e2 > beta_e2_krit !');        % neu, k_R_t2
                                disp(' beta_e2 > beta_e2_krit !');        % neu, k_R_t2
                                %
                                %          STIMMT DIES FUER k_R_t2 UEBERHAUPT ??????? :
                                % einzige Loesung ; zur Sicherheit ALLES NEU :
                                k_r_tT = k_R_e2 * S_i;
                                k_i_tT = - sqrt( k_r_tT^2 - k_30_q );
                                alpha_tT = 0.5 * pi + 1.e-6;
                                S_tT = 1. ;      C_tT = 0. ;
                                psi_tT = 0. ;	%	= alpha_tT - .5 * pi;
                                psi_tT1 = 2. * pi;	% als ungueltig markieren
                            endif
                        else
                            %    alt, bei k_r_t :
                            %alpha_e_kritT = .5 * pi + 1.e-6;
                            %disp('');
                            %disp('es EXISTIERT KEIN alpha_e_krit');
                            %h3 = asin( S_i * k_I_e2 / k_i_tT );	% nur Hauptwert, | | < pi/2
                            %    NEU, bei k_R_t2 :
                            beta_e_kritT = .5 * pi + 1.e-6;
%                            %disp('');
%                            %disp('es EXISTIERT KEIN beta_e2_krit');
                            h3 = asin( S_bi * k_I_e2 / k_i_tT );	% nur Hauptwert, | | < pi/2
                            %      weiter WIE alt :
                            % 2 moegliche Loesungen :
                            psi_tT1 = alpha_tT - h3;
                            psi_tT2 = alpha_tT - pi + h3;
                        endif

                        if( psi_tT1 < pi )
                            % AUSWAHL der korrekten psi_tT - Loesung ! :
                            C_psi_tT1 = cos( psi_tT1 );
                            C_psi_tT2 = cos( psi_tT2 );
                            h31 = k_i_tT * k_r_tT * C_psi_tT1 + p_35;
                            h32 = k_i_tT * k_r_tT * C_psi_tT2 + p_35;
                            %h1 = sprintf('%12.5e', h31);	h2 = sprintf('%12.5e', h32);
                            %disp(['k_R_t2  sagt :   Residuum mit psi_tT1 = ', h1]);
                            %disp(['k_R_t2  sagt :   Residuum mit psi_tT2 = ', h2]);
                                if( abs( h31) <= abs(h32) )
                                    psi_tT = psi_tT1;
                                    h3 = psi_tT1 / radw;
                                    h1 = sprintf('%12.5e', h3);
%                                    disp(['k_R_t2  sagt : psi_tT1 in Grad = ', h1, '   GENOMMEN !']);
                                else
                                    psi_tT = psi_tT2;
                                    h3 = psi_tT2 / radw;
                                    h1 = sprintf('%12.5e', h3);
%                                    disp(['k_R_t2  sagt : psi_tT2 in Grad = ', h1, '   GENOMMEN !']);
                                endif
                        endif
                    C_psi_tT = cos( psi_tT );
                    S_HT = sin( alpha_tT - psi_tT );
                    %
                    %         NEU, bei k_R_t2 :
                    beta_e2_krit = beta_e_kritT;
                    h3 = beta_e2_krit / radw;
                    h1 = sprintf('%12.5e', h3);
                    disp(['k_R_t2  sagt :   beta_e2_krit  in Grad  = ', h1]);
                    %         weiter ANALOG alt :
                    %
                    h3 = k_r_tT * S_tT;
                    h4 = k_R_e2 * S_i;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_R_t2 * S_t = ', h1, '   ?=   ', h2, ' = k_R_e2 * S_i']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            %disp('k_R_t2  sagt : Gl. 1  Residuum zu gross ! UNGUELTIG');
                            W2_valid = False;
                        endif
                    %
                    h3 = k_i_tT * S_HT;
                    %      alt, k_r_t :
                    %%%h4 = k_I_e2 * S_i;
                    %      neu, 30.Aug.2016 fuer k_R_t2 :
                    h4 = k_I_e2 * S_bi;
                    %      weiter ...
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_I_t2 * S_H = ', h1, '   ?=   ', h2, ' = k_I_e2 * S_bi']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            %disp('k_R_t2  sagt : Gl. 2  Residuum zu gross ! UNGUELTIG');
                            W2_valid = False;
                        endif
                    %
                    h3 = k_r_tT^2 - k_i_tT^2;
                    h4 = k_30_q;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_R_t2^2 - k_I_t2^2 = ', h1, '   ?=   ', h2, ' = k_30^2']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            %disp('k_R_t2  sagt : Gl. 3  Residuum zu gross ! UNGUELTIG');
                            W_valid = False;
                        endif
                    %
                    h3 = k_i_tT * k_r_tT * C_psi_tT;
                    h4 = -p_35;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    % 29. Aug.'14 :
                    %disp(['( k_I_t2 * k_R_t2 * C_psi_t2 ) = ', h1, '  ?=  ', h2, ' = -0.5 * p_20']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            %disp('k_R_t2  sagt : Gl. 4  Residuum zu gross ! UNGUELTIG');
                            W2_valid = False;
                        endif
                    %
                        if( W2_valid == True )
                            % als moegliche Loesung uebernehmen :
                            W_L_k = W_L;
                            k_r_t2_valid = True;
                            %
                            h3 = alpha_tT / radw;
                            %h1 = sprintf('%12.5e', h3);
                            %disp(['k_R_t2  sagt :   alpha_t2  in Grad  = ', h1, '   GUELTIG !']);
     % neu 07. Jan. 2017 :
                        else
                            k_r_t2_valid = False;
                            disp(' k_R_t2 Pseudo-Loesung UNGUELTIG !');
                        endif
                    %{
                    % 05. Jan. 2015 :
                    %h3 = psi_tT / radw;
                    %h1 = sprintf('%12.5e', h3);
                    %disp(['k_R_t2  sagt :   psi_t2  in Grad  = ', h1, '  !']);
                    % Ende Einschub 05. Jan.
                    disp(' PAUSE !    Weiter mit Taste ...');
                    pause();
                    %}
                %else
                    %disp(['  Pseudo-Loesung W  # ', num2str(i_W), ' entfaellt !']);
                endif
            endfor

            if( k_r_t2_valid == True)
%                disp(' k_r_t2_valid = True !');
                k_R_t2 = k_r_tT;      
                k_I_t2 = k_i_tT;
                %S_t = S_tT;
                alpha_t2 = alpha_tT;
                %C_t = cos(alpha_t2);
                psi_t2 = psi_tT;
                %C_psi_t2 = cos( psi_t2 );
%%%                alpha_H = alpha_t2 - psi_t2;
                beta_t2 = alpha_t2 - psi_t2;
                S_H = sin( beta_t2 );    C_H = cos( beta_t2 );
                %
                h3 = k_R_t2;    h4 = k_I_t2;
                h1 = sprintf('%12.5e', h3);	h2 = sprintf('%12.5e', h4);
                disp(['k_R_t2  sagt :    k_R_t2 = ', h1, '   ;   k_I_t2 = ', h2]);
                h3 = alpha_t2 / radw;	h4 = psi_t2 / radw;
                h1 = sprintf('%12.5e', h3);	h2 = sprintf('%12.5e', h4);
                disp(['k_R_t2  sagt :   alpha_t2  in Grad  = ', h1, '   GENOMMEN !']);
                disp(['k_R_t2  sagt :   psi_t2  in Grad  = ', h2, '   GENOMMEN !']);
             else
                 disp(' VERSAGEN k_R_t2-Algorithmus WIRD IGNORIERT !');
                 k_R_t2 = k_r_tT;      
                 k_I_t2 = - sqrt( k_R_t2^2 - k_30_q );
                 S_t = S_i * k_R_e2 / k_R_t2;
                 alpha_t2 = asin(S_t);
                 C_t = cos(alpha_t2);
                 % evtl. numerisch ungenauer 'asin' :
                 %      neu, k_R_t2 :
                 psi_t_h = alpha_t2 - asin( S_bi * k_I_e2 / k_I_t2 );
                 %
                 % evtl. numerisch genauerer 'acos' :
                 C_psi_t = -p_35 / ( k_I_t2 * k_R_t2 );
                 psi_t2 = acos( C_psi_t );	% liefert NUR POSITIVE 'Loesg.' !
                     if( psi_t_h < 0.)
                         disp(' aus asin-Gl.  :   psi_t_h < 0. !');
                         disp('    ==> VZ psi_t UMDREHEN !');
                         psi_t2 *= (-1.);
                     endif
                 S_H = sin( alpha_t2 - psi_t2 );    C_H = cos( alpha_t2 - psi_t2 );
                     if( S_H < 0.)
                         disp(' MUELL !   S_H angeblich < 0. !');
                     elseif( S_H <= S_t )
                         disp(' S_H angeblich <= S_t !');
                         disp('    ==> psi_t MUESSTE >= 0. sein !');
                     else
                         disp(' S_H angeblich > S_t !');
                         disp('    ==> psi_t MUESSTE < 0. sein !');
                     endif
                 h3 = psi_t2 / radw;
                 h4 = psi_t_h / radw;
                 h1 = sprintf('%12.5e', h3);
                 h2 = sprintf('%12.5e', h4);
                 disp(['k_R_t2  sagt :   psi_t2  in Grad  = ', h1, '   GENOMMEN !']);
                 disp(['k_R_t2  sagt :   psi_t_h  in Grad  = ', h2, '   nur VZ !']);
             endif
    else
        alpha_t2 = 90. * radw;    % ab alpha_t2 >= 89,999 Grad
        k_R_t2 = S_bi * k_R_e2;
        k_I_t2 = - sqrt( k_R_t2^2 - k_30_q );
        psi_t2 = alpha_t2 - asin( S_bi * k_I_e2 / k_I_t2 );
%%% WOZU ??? :
%%%        C_t = 0.;    S_t = 1.;
%%%        C_psi_t = cos( psi_t2 );
%%%        S_H = sin( alpha_t2 - psi_t2 );    C_H = cos( alpha_t2 - psi_t2 );
    endif

endfunction
