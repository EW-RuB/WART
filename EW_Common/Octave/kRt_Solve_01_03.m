function [k_R_t, k_I_t, alpha_t, psi_t] = kRt_Solve_01( ...
                       k_R_e, k_I_e, k_20, p_25, alpha_e)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

       kRt-Algorithmus
    #           ( geeignet mindestens bei :
    #              -    alle Faelle 'delta'an Border # 1 , d.h. BEIDE Medien mit Daempfung )
    # 
    #    ( Laufrichtung :  Phase nach +x 
    #                      Daempfung nach +x und +-y , um psi verdreht  )
    # Rolf :
    #      [ (kr + J * kxi)*e_x + J * kyi * e_y ]^2 = om^2 * mue * eps - J * om * mue * kap
    #        (kr + J * kxi)^2 + (J * kyi)^2 = om^2 * mue * eps - J * om * mue * kap
    #        kr^2 - kxi^2 - kyi^2 + J * 2 * kr * kxi = om^2 * mue * eps - J * om * mue * kap
    #        kr^2 - (kxi^2 + kyi^2) + J * 2 * kr * kxi = om^2 * mue * eps - J * om * mue * kap
    #              ki = sqrt(kxi^2 + kyi^2)
    #              Cpsi = cos (psi) = kxi / ki   ==>  kxi = ki * Cpsi
    #        kr^2 - ki^2 + J * 2 * kr * ki * Cpsi = om^2 * mue * eps - J * om * mue * kap
    #            a)   kr^2 - ki^2 = om^2 * mue * eps
    #            b)   2 * kr * ki * Cpsi = - om * mue * kap
    #        ki = - (0.5 * om * mue * kap / Cpsi) / kr
    #              V = om * om * mue * eps          W = 0.5 * om * mue * kap / Cpsi
    #        kr^2 - W^2 / kr^2 = V
    #        kr^4 - V * kr^2 - W^2 = 0       ;  s.o. a)   ==>   kr^2 >= V
    #        kr = sqrt( 0.5 * V  + sqrt(0.25 * V^2 + W^2) )
    #
    #  k_R_e, k_I_e, k_20, p_25 als PARAMETER uebergeben ;
    #  alpha_e als PARAMETER uebergeben !
    #
    #        sucht korrekte Loesung aus bis zu 4 Pseudo-Loesungen heraus !
    #         2 Faelle k_R_t  UND  je 2 Faelle psi_t
    #

Started on Aug. 17., 2018
Last Changes on Okt. 06., 2018
%}

%{
                       History :

 06. Okt.  2018 :  - Aufraeumen Code

 05. Okt.  2018 :  - Beginn als Kopie von kRt_Solve_01_02.m

 21. Sep.  2018 :  - weitere disp's auskommentiert ; Tatsache der 4. (Pseudo-) Loesungen vermerkt

 17. Aug.  2018 :  - Beginn als Kopie von kRt_Solve_01_01.m ;
                            Ziele :
                   - neu genaue Doku, WELCHE Groessen WO und WIE NORMIERT sind (input und output) !
                   - neu fuer (nahezu) senkrechten Einfall : Bypass d. Algorithmus, EINFACHE LSG.
                        { zur numerischen Stabilitaet bei Freq. > 1.e17 Hz }
                     ==> Beginn Bypass : primitiv als exakt senkr. Einfall naehern, d.h. fuer kleine 
                                         alpha_e sagen :  psi_t = 0.  UND  alpha_t = 0.
                         { kleine Restfehler besser als Absturz; bessere Naeherungen spaeter ueberlegen }

                   
                    ALT :
 
        in kRt_Solve_01_01.m :

 03. Jun.  2017 :  - Code-Kosmetik (Header)
                   - Speed up : einige 'disp( )' auskommentiert

 16. Jan.  2017 :  - Beginn als Kopie von krt_Solve_01.m : 
                     Namen neu; function heisst nun kRt_Solve_01; neueste Version immer in gleichnamiges File kopieren
                                               { d.h. alle Aufrufe von extern DARAN anpassen }
                   - Beginn 'numerisch stabilisieren' :
                        a) indem 3 Sonderfaelle VORHER abgefragt werden : wirkungslos !
                        b) Analyse bei alpha_e = 50.75 Grad : angeblich erstmalig > alpha_e_krit ! ==> kRt VERSAGT
                     ==> Kriterium abgeaendert, ca. line 180 ! :
                            % ALT                             if( S_i <= ( 0.99999 * S_i_kritT ) )
                            %  VERSUCH 16. Jan. 2017 :        if( S_i <= S_i_kritT )
                     ==> Ausreisser in EW_o_ESN_HPT_2a2ad_04Rolf.m WEG !                               OK


                   ALT :

 08. Jan.  2017 :  - Einzel-Aussetzer in EW_o_ESN_HPT_2a2ad_04 bei alpha_e = 50.75 Grad NOCH FALSCH !!!

 07. Jan.  2017 :  - Korrektur DES FLAGS 'ungueltige Pseudo-Loesung' ;
 
 06. Feb.  2016 :  - Beginn als separate Funktion

 28. Aug.  2014 :  - Beginn Code ; zunaechst im Hauptprogramm

%}


% vorlaeufig fuer Flags :
True = 1;    False = 0;
None = False;

radw = pi / 180.;

k_20_q = k_20^2;
S_i = sin(alpha_e);	C_i = cos(alpha_e);


    %         neu Rolf 17.Aug.2018 :
    % winzige Einfallswinkel zu allererst abfangen :
    if( alpha_e < 1.e-5 )
        % (vorlaeufig) primitive Naeherung :
        psi_t = 0.;
    %#        kr^4 - k_20_q * kr^2 - p_25^2 = 0       ;  s.o. a)   ==>   kr^2 >= V
        k_R_t = sqrt( 0.5 * k_20_q  + sqrt(0.25 * k_20_q^2 + p_25^2) );
        k_I_t = -sqrt( k_R_t^2 - k_20_q);   % "Achtung : MINUSZEICHEN bei kI !"
        alpha_t = 0.;
        %return;        % Rolf 05.Okt. 2018 : WEG
    %
    %         weiter wie vor 17.Aug.2018 :
    %if( abs(C_i) > 1.e-5 )
    elseif( abs(C_i) > 1.e-5 )
        %
        %         Versuch  =  'k_R_t-Algorithmus' ; 15. Mar. 2014 :
        h7 = 0.5 * ( (k_R_e^2 + k_I_e^2) * S_i^2 + k_20_q );
        % 29. Aug. '14 :
        h8 = p_25^2 + ( 2. * p_25 * k_R_e * k_I_e - k_20_q * k_R_e^2 ) * S_i^2;
        %
        %  W^2 - 2 * W^1 * h7 - h8  =  0 :
        %
%{
        p3 = h7^2 + h8;
        disp('');
        disp(['  bei k_R_t  IN DER WURZEL  :  ', num2str(p3), '   :']);
        disp(' PAUSE !    Weiter mit Taste ...');
        pause();
        p3 = sqrt(p3);
%}
        p3 = sqrt(h7^2 + h8);
        %
        %       neu 16. Jan. 2017 :
        % { numerisch stabilisieren, indem 3 Sonderfaelle VORHER abgefragt werden }
            if( (abs(h8) > 1.e16 ) && (h7 >= 1.e16) )
                % Sonderfall 1 : Vorfaktor quadrat. Term winzig
                % disp('  bei k_R_t  Sonderfall 1  !');
                %  0-te Naeherung : 
                W0 = - h8 / ( 2. * h7 );
                %  1-te Naeherung { mit delta << W0 } : 
                delta_1 = h8 * h8 / ( 4. * h7 * ( 2. * h7 * h7 + h8 ) );
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            elseif( (abs(h8) >= 1. ) && (h7 <= 1.e-16) )
                % Sonderfall 2 : Vorfaktor lin. Term winzig
                %disp('  bei k_R_t  Sonderfall 2  !');
                %  0-te Naeherung : 
                W0 = sqrt( h8 );
                %  1-te Naeherung { mit delta << W0    wegen  delta =ca. h7 }: 
                delta_1 = W0 * h7 / ( W0 - h7 );
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            elseif( (abs(h8) <= 1.e-16 ) && (h7 >= 1.) )
                % Sonderfall 3 : absoluter Term winzig
                % disp('  bei k_R_t  Sonderfall 3  !');
                %  0-te Naeherung : 
                W0 = 2. * h7;
                %  1-te Naeherung ( NICHT mit p3 ; mit delta << W0   ) : 
                delta_1 = h8 / W0;
                W(1) = W0 + delta_1;    W(2) = W0 - delta_1;
            else
				%disp("if_4");
                % alter Code vor 16. Jan. 2017 :
                % disp('  bei k_R_t  Normalfall !');
                W(1) = h7 + p3;    W(2) = h7 - p3;
            endif
        %
        %       WEITER ALT (vor 16. Jan. 2017) :
        %    FALLS MEHRERE LOESUNGEN existieren mit 0 < k_20_q <= W  :
        W_L_k = k_20_q;
        [h iw] = size(W);
            for i_W = 1:iw
                h = W(i_W);
                hr = real(h);
                %
                if( (abs(imag(h)) < 1.e-10 ) && (hr >= k_20_q))
                    W_L = hr;
                    %disp('');
                    %disp(['  angebl. Loesung W  # ', num2str(i_W), '   :']);
                    W_valid = True; k_R_t_valid = True;

                    k_R_tT = sqrt(W_L);
                    k_I_tT = - sqrt( k_R_tT^2 - k_20_q );
                    h100 = sprintf('%.15f', k_R_tT^2);
                    %disp(["Here_1 k_R_tT^2:      ", h100]);
                    h100 = sprintf('%.15f', k_20_q);
                    %disp(["Here_1 k_20_q:      ", h100]);
                    h100 = sprintf('%.15f', k_I_tT^2);
                    %disp(["Here_1 k_I_tT:      ", h100]);
                    %
                    %     28. Aug. '14 / 6. Jan. 15 :
                    S_i_GrenzT = k_R_tT / k_R_e;
                        if( S_i_GrenzT < 1. )
                            alpha_e_GrenzT = asin( S_i_GrenzT );
                            %h3 = alpha_e_GrenzT / radw;
                            %h1 = sprintf('%12.5e', h3);
                            %disp('');
                            %disp(['laut k_R_t EXISTIERT  alpha_e_Grenz = ', h1, ' Grad']);
                                if( S_i < S_i_GrenzT )
                                    S_tT = S_i * k_R_e / k_R_tT;      
                                    % dies KANN UNGENAU werden fuer alpha_tT --> pi/2 :
                                    alpha_tT = asin(S_tT);	% nur pos. Hauptwert, OK
                                else
                                    % einzige Loesung ; zur Sicherheit ALLES NEU :
                                    k_R_tT = k_R_e * S_i;
                                    k_I_tT = - sqrt( k_R_tT^2 - k_20_q );
                                    %disp("Here_2");
                                    S_tT = 1.;      
                                    alpha_tT = 0.5 * pi + 1.e-6;
                                endif
                        else
                            S_i_GrenzT = 1.;
                            alpha_e_GrenzT = 0.5 * pi + 1.e-6;
                            S_tT = S_i * k_R_e / k_R_tT;      
                            % dies KANN UNGENAU werden fuer alpha_tT --> pi/2 :
                            alpha_tT = asin(S_tT);	% nur pos. Hauptwert, OK
%                            disp('');
%                            disp('es EXISTIERT KEIN alpha_e_Grenz');
                        endif
                    %     weiter ...
                    C_tT = cos(alpha_tT);
                    %
                    %     28. Aug. '14  /  06. Jan. 15 :
                    h = k_I_tT / k_I_e;		% spaeter fuer "alpha" Overflow abfangen ! 
                        if( h < 1. )
                            S_i_kritT = h;
                            alpha_e_kritT = asin( S_i_kritT );
                            %clear h1, h3;
                            h3 = alpha_e_kritT / radw;
                            h1 = sprintf('%12.5e', h3);
                            disp('');
                            disp(['es EXISTIERT  alpha_e_krit = ', h1, ' Grad']);
%   ALT :
%                           if( S_i <= ( 0.99999 * S_i_kritT ) )
%  VERSUCH 16. Jan. 2017 , stabiler :
                            if( S_i <= S_i_kritT )
                                % alt :
                                %psi_tT = alpha_tT - asin( S_i * k_I_e / k_I_tT );
                                % neu 6. Jan. 15 :
                                h3 = asin( S_i * k_I_e / k_I_tT );	% nur Hauptwert, | | < pi/2
                                % 2 moegliche Loesungen :
                                psi_tT1 = alpha_tT - h3;
                                psi_tT2 = alpha_tT - pi + h3;
                            else
                                disp(' UND  alpha_e > alpha_e_krit !');
                                % einzige Loesung ; zur Sicherheit ALLES NEU :
                                k_R_tT = k_R_e * S_i;
                                k_I_tT = - sqrt( k_R_tT^2 - k_20_q );
                                %disp("Here_3");
                                alpha_tT = 0.5 * pi + 1.e-6;
                                S_tT = 1;      C_tT = 0.;
                                psi_tT = 0.	%	= alpha_tT - .5 * pi;
                                psi_tT1 = 2. * pi;	% als ungueltig markieren
                            endif
                        else
                            alpha_e_kritT = .5 * pi + 1.e-6;
%                            disp('');
%                            disp('es EXISTIERT KEIN alpha_e_krit');
                            % alt :
                            %psi_tT = alpha_tT - asin( S_i * k_I_e / k_I_tT );
                            % neu 6. Jan. 15 :
                            h3 = asin( S_i * k_I_e / k_I_tT );	% nur Hauptwert, | | < pi/2
                            % 2 moegliche Loesungen :
                            psi_tT1 = alpha_tT - h3;
                            psi_tT2 = alpha_tT - pi + h3;
                        endif
                    %   neu  weiter ...
                        if( psi_tT1 < pi )
                            % AUSWAHL der korrekten psi_tT - Loesung ! :
                            C_psi_tT1 = cos( psi_tT1 );
                            C_psi_tT2 = cos( psi_tT2 );
                            h31 = k_I_tT * k_R_tT * C_psi_tT1 + p_25;
                            h32 = k_I_tT * k_R_tT * C_psi_tT2 + p_25;
                            %h1 = sprintf('%12.5e', h31);	h2 = sprintf('%12.5e', h32);
                            %disp(['k_R_t  sagt :   Residuum mit psi_tT1 = ', h1]);
                            %disp(['k_R_t  sagt :   Residuum mit psi_tT2 = ', h2]);
                                if( abs( h31) <= abs(h32) )
                                    psi_tT = psi_tT1;
                                    %h3 = psi_tT1 / radw;
                                    %h1 = sprintf('%12.5e', h3);
                                    %disp(['k_R_t  sagt : psi_tT1 in Grad = ', h1, '   GENOMMEN !']);
                                else
                                    psi_tT = psi_tT2;
                                    %h3 = psi_tT2 / radw;
                                    %h1 = sprintf('%12.5e', h3);
                                    %disp(['k_R_t  sagt : psi_tT2 in Grad = ', h1, '   GENOMMEN !']);
                                endif
                        endif
                    C_psi_tT = cos( psi_tT );
                    S_HT = sin( alpha_tT - psi_tT );
                    %
                    alpha_e_krit = alpha_e_kritT;
                    h3 = alpha_e_krit / radw;
                    h1 = sprintf('%12.5e', h3);
                    disp(['k_R_t  sagt :   alpha_e_krit  in Grad  = ', h1]);
                    %
                    h3 = k_R_tT * S_tT;
                    h4 = k_R_e * S_i;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_R_t * S_t = ', h1, '   ?=   ', h2, ' = k_r_i * S_i']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            disp('k_R_t  sagt : Gl. 1  Residuum zu gross ! UNGUELTIG');
                            W_valid = False;
                        endif
                    %
                    %clear h1, h2, h3, h4;
                    h3 = k_I_tT * S_HT;
                    h4 = k_I_e * S_i;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_I_t * S_H = ', h1, '   ?=   ', h2, ' = k_i_i * S_i']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            disp('k_R_t  sagt : Gl. 2  Residuum zu gross ! UNGUELTIG');
                            W_valid = False;
                        endif
                    %
                    h3 = k_R_tT^2 - k_I_tT^2;
                    h4 = k_20_q;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    %disp(['k_R_t^2 - k_I_t^2 = ', h1, '   ?=   ', h2, ' = k_20^2']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            disp('k_R_t  sagt : Gl. 3  Residuum zu gross ! UNGUELTIG');
                            W_valid = False;
                        endif
                    %
                    % 29. Aug. '14 :
                    h3 = k_I_tT * k_R_tT * C_psi_tT;
                    h4 = -p_25;
                    %h1 = sprintf('%12.5e', h3);
                    %h2 = sprintf('%12.5e', h4);
                    % 29. Aug.'14 :
                    %disp(['( k_I_t * k_R_t * C_psi_t ) = ', h1, '  ?=  ', h2, ' = -0.5 * p_20']);
                        if( abs( h3 - h4) > (1.e-5 * abs(h4)) )
                            disp('k_R_t  sagt : Gl. 4  Residuum zu gross ! UNGUELTIG');
                            W_valid = False;
                        endif
                        %
                        if( W_valid == True )
                            % als moegliche Loesung uebernehmen :
                            W_L_k = W_L;
                            k_R_t_valid = True;
                            %
                            h3 = alpha_tT / radw;
                            %h1 = sprintf('%12.5e', h3);
                            %disp(['k_R_t  sagt :   alpha_t  in Grad  = ', h1, '   GUELTIG !']);
                        % neu 07. Jan. 2017 :
                        else
                            k_R_t_valid = False;
                            disp(' k_R_t Pseudo-Loesung UNGUELTIG !');
                        endif
                    %{
                    % 05. Jan. 2015 :
                    %h3 = psi_tT / radw;
                    %h1 = sprintf('%12.5e', h3);
                    %disp(['k_R_t  sagt :   psi_t  in Grad  = ', h1, '  !']);
                    % Ende Einschub 05. Jan.
                    disp(' PAUSE !    Weiter mit Taste ...');
                    pause();
                    %}
                %else
                    %disp(['  Pseudo-Loesung W  # ', num2str(i_W), ' entfaellt !']);
                endif
            endfor

            if( k_R_t_valid == True)
                % disp(' k_R_t_valid = True !');
                k_R_t = k_R_tT;      
                k_I_t = k_I_tT;
                %disp(["Here_4 k_I_tT:      ", num2str(k_I_tT)]);
                alpha_t = alpha_tT;
                psi_t = psi_tT;
                alpha_H = alpha_t - psi_t;
                S_H = sin( alpha_H );    C_H = cos( alpha_H );
                %
                h3 = k_R_t;    h4 = k_I_t;
                h1 = sprintf('%12.5e', h3);	h2 = sprintf('%12.5e', h4);
                disp(['k_R_t  sagt :    k_R_t = ', h1, '   ;   k_I_t = ', h2]);
                h3 = alpha_t / radw;	h4 = psi_t / radw;
                h1 = sprintf('%12.5e', h3);	h2 = sprintf('%12.5e', h4);
                disp(['k_R_t  sagt :   alpha_t  in Grad  = ', h1, '   GENOMMEN !']);
                disp(['k_R_t  sagt :   psi_t  in Grad  = ', h2, '   GENOMMEN !']);
             else
                 disp(' VERSAGEN des k_R_t-Algorithmus WIRD IGNORIERT !');
                 k_R_t = k_R_tT;      
                 k_I_t = - sqrt( k_R_t^2 - k_20_q );
                 S_t = S_i * k_R_e / k_R_t;
                 alpha_t = asin(S_t);
                 C_t = cos(alpha_t);
                 %   neu 28. Aug. '14 :
                 % evtl. numerisch ungenauer 'asin' :
                 psi_t_h = alpha_t - asin( S_i * k_I_e / k_I_t );
                 % evtl. numerisch genauerer 'acos' :
                 C_psi_t = -p_25 / ( k_I_t * k_R_t );
                 psi_t = acos( C_psi_t );	% liefert NUR POSITIVE 'Loesg.' !
                     if( psi_t_h < 0.)
                         disp(' aus asin-Gl.  :   psi_t_h < 0. !');
                         disp('    ==> VZ psi_t UMDREHEN !');
                         psi_t *= (-1.);
                     endif
                 S_H = sin( alpha_t - psi_t );    C_H = cos( alpha_t - psi_t );
                     if( S_H < 0.)
                         disp(' MUELL !   S_H angeblich < 0. !');
                     elseif( S_H <= S_t )
                         disp(' S_H angeblich <= S_t !');
                         disp('    ==> psi_t MUESSTE >= 0. sein !');
                     else
                         disp(' S_H angeblich > S_t !');
                         disp('    ==> psi_t MUESSTE < 0. sein !');
                     endif
                 h3 = psi_t / radw;
                 h4 = psi_t_h / radw;
                 h1 = sprintf('%12.5e', h3);
                 h2 = sprintf('%12.5e', h4);
                 disp(['k_R_t  sagt :   psi_t  in Grad  = ', h1, '   GENOMMEN !']);
                 %disp(['k_R_t  sagt :   psi_t_h  in Grad  = ', h2, '   nur VZ !']);
             endif
    % bei alpha_t >= 89,999 Grad :
    else
        alpha_t = 90. * radw;
        k_R_t = S_i * k_R_e;
        k_I_t = - sqrt( k_R_t^2 - k_20_q );
        psi_t = alpha_t - asin( S_i * k_I_e / k_I_t );
    endif

endfunction
