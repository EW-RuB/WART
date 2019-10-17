function [p_handles, p_errors] = additional_Plots_TE_1( legend_flag, uv_1, uv_2, ...
                  k_r_t_normal, k_i_t_normal, alpha_t_normal, psi_t_normal, ...
                  Z_FW_t_tr, Z_FW_t_lo, ...
                  k_R_t2_normal, k_I_t2_normal, alpha_t2_normal, psi_t2_normal, ...
                  Z_FW_t2_tr, Z_FW_t2_lo, ...
                  r_normal, t_normal, r2_normal, t2_normal)
%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig

                       statische Plots fuer TE-Faelle : 
    #           ( geeignet mindestens bei :
    #              -    alle Faelle 'delta', d.h. DREI Medien mit Daempfung )
    # Rolf :
    # 
    #    Reflexions- und Transmissions-Koeffizienen, Winkel, Wellenzahlen, -Impedanzen
    #
    #
    #               PARAMETER Eingabe :
    #
    #  legend_flag als 1. Parameter :
    #     0    =    KEINE legends
    #     1    =    legends OHNE 'position'
    #     2    =    legends INCL 'position'
    #
    #  uv_1, uv_2        ===  alpha_e, alpha_e2 in rad
    #  k_r_t_normal, k_i_t_normal, alpha_t_normal, psi_t_normal, Z_FW_t_tr, Z_FW_t_lo
    #  k_R_t2_normal, k_I_t2_normal, alpha_t2_normal, psi_t2_normal, Z_FW_t2_tr, Z_FW_t2_lo
    #  r_normal, t_normal, r2_normal, t2_normal
    #
    #            ==> BISHER NICHT in Plots !  :
    #  k_R_e, k_I_e, Z_W_1       

Started on May 25., 2017
Last Changes on Oct. 27., 2018
%}

%{
                       History :

 27. Okt.  2018 :  - figures leicht größer

 27. Mai   2017 :  - Code-Kosmetik

 27. Mai   2017 :  - Plots neu sortiert (zuerst alle an Border # 1)

 25. Mai   2017 :  - Beginn der Auslagerung aus Kopie von EW_o_ESN_HPT_1b1bd_08R.m : FERTIG, OK
                     { incl. 'legend_flag ' ! Noetig u.a. für i7-5100M-Dell-Laptop und/oder Octave 3.8 }

%}

radw = pi / 180.;


%%                    # AB HIER ALLES NUR EINMAL und NUR WENN GEWUENSCHT :
%%              if ( (alpha_first_run == True)  && (static_plots == True) )
%%                  alpha_first_run = False;        # RESET
%%                  %
                    %figure(2);   alt
                    % 27. Okt. 2018 
                    %figM = figure(1, 'position', [0   10   1800   980]);
                    figure(2, 'position', [100   100   480   480]);
                    %
                    plot( uv_1, real(r_normal), 'r', "linewidth", 1.01  );
                    axis([0., 100., -1.1, 2.1]);
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('r-normal', "fontsize", 14);
                    hold on;
                    plot( uv_1, imag(r_normal), 'g', "linewidth", 1.01 );
                    title('r-normal ELEKTR.  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( "Re", "Im", "location", "east");
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend("Re", "Im");
                        endif
                    %
                    figure(3);
                    plot( uv_1, real(t_normal), 'm', "linewidth", 1.01  );
                    axis([0., 100., -1.1, 2.1]);
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('t-normal', "fontsize", 14);
                    hold on;
                    % 'cyan' am Beamer zu blass, 'red' besser :
                    plot( uv_1, imag(t_normal), 'r', "linewidth", 1.01  );
                    title('t-normal ELEKTR. Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(4);
                    plot( uv_1, abs(t_normal), 'm', "linewidth", 1.01  );
                    axis([0., 100., -0.1, 2.1]);
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('t- und r-normal', "fontsize", 14);
                    hold on;
                    plot( uv_1, abs(r_normal), 'r', "linewidth", 1.01 );
                    title('t- und r-normal TE  Betraege', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["t"; "r"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "t", "r");
                        endif
                    %
                    figure(5);
                    plot( uv_1, angle(t_normal) ./ radw, 'm', "linewidth", 1.01  );
                    axis([0., 100., -180., 180.]);
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('t- und r-normal', "fontsize", 14);
                    hold on;
                    plot( uv_1, angle(r_normal) ./ radw, 'r', "linewidth", 1.01  );
                    title('t- und r-normal TE  Phasen', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["t"; "r"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "t", "r");
                        endif
                    %
                    figure(6);
                    plot( uv_1, k_r_t_normal, 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('k-r-t und k-i-t', "fontsize", 14);
                    plot( uv_1, k_i_t_normal, 'g', "linewidth", 1.01  );
                    title('Wellenzahlen k-r-t und k-i-t', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(7);
                    plot( uv_1, alpha_t_normal ./ radw, 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('alpha-t und psi-t in Grad', "fontsize", 14);
                    plot( uv_1, psi_t_normal ./ radw, 'g', "linewidth", 1.01  );
                    title('Winkel alpha-t und psi-t', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["alpha-t"; "psi-t"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "alpha-t", "psi-t");
                        endif
                    %
                    figure(8);
                    plot( uv_1, real(Z_FW_t_tr), 'r', "linewidth", 1.01  );
                    hold on;                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('Z-FW-t-tr', "fontsize", 14);
                    plot( uv_1, imag(Z_FW_t_tr), 'g', "linewidth", 1.01  );
                    title('Z-FW-t-tr TE  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(9);
                    plot( uv_1, real(Z_FW_t_lo), 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e in Grad', "fontsize", 14);
                    ylabel('Z-FW-t-lo', "fontsize", 14);
                    plot( uv_1, imag(Z_FW_t_lo), 'g', "linewidth", 1.01  );
                    title('Z-FW-t-lo TE  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    
                    %         von David fuer Border # 2 :
                    %
                    % : uv_2 Endwert neu belegen :
                    % Rolf Versuch 1, primitiv :
                    [h, N_alpha_e] = size(uv_1)
                    [h, N_alpha_e2] = size(uv_2)
                    %  alt :
                    %uv_2(N_alpha_e + 1) = uv_2(N_alpha_e);
                    % Versuch 25. Mai 2017 (auch Schrott ? ) :
                    %uv_2(N_alpha_e) = uv_2(N_alpha_e - 1);
                    uv_2(N_alpha_e2) = uv_2(N_alpha_e2-1);
                    %%[uv_2_min, uv_2_max] = minmax(uv_2);
                    N_alpha_e2 = N_alpha_e;
                    %

                    figure(10);
                    plot( uv_2, real(r2_normal), 'r', "linewidth", 1.01  );
                    %axis([0., 100., -1.1, 2.1]);
                    axis([0., uv_2(N_alpha_e-1), -1.1, 2.1]);
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('r2-normal', "fontsize", 14);
                    hold on;
                    plot( uv_2, imag(r2_normal), 'g', "linewidth", 1.01 );
                    title('r2-normal ELEKTR.  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(11);
                    plot( uv_2, real(t2_normal), 'm', "linewidth", 1.01  );
                    axis([0., uv_2(N_alpha_e-1), -1.1, 2.1]);
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('t2-normal', "fontsize", 14);
                    hold on;
                    % 'cyan'  am Beamer zu blass ; 'rot' besser sichtbar :
                    %plot( uv_2, imag(t2_normal), 'c', "linewidth", 1.01  );
                    plot( uv_2, imag(t2_normal), 'r', "linewidth", 1.01  );
                    title('t2-normal ELEKTR.  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(12);
                    plot( uv_2, abs(t2_normal), 'm', "linewidth", 1.01  );
                    axis([0., uv_2(N_alpha_e-1), -0.1, 2.1]);
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('t2- und r2-normal', "fontsize", 14);
                    hold on;
                    plot( uv_2, abs(r2_normal), 'r', "linewidth", 1.01 );
                    title('t2- und r2-normal TE  Betraege', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["t2"; "r2"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "t2", "r2");
                        endif
                    %
                    figure(13);
                    plot( uv_2, angle(t2_normal) ./ radw, 'm', "linewidth", 1.01  );
                    axis([0., uv_2(N_alpha_e-1), -180., 180.]);
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('t2- und r2-normal', "fontsize", 14);
                    hold on;
                    plot( uv_2, angle(r2_normal) ./ radw, 'r', "linewidth", 1.01  );
                    title('t2- und r2-normal TE  Phasen', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["t2"; "r2"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "t2", "r2");
                        endif
                    %
                    figure(14);
                    plot( uv_2, k_R_t2_normal, 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('k-R-t2 und k-I-t2', "fontsize", 14);
                    plot( uv_2, k_I_t2_normal, 'g', "linewidth", 1.01  );
                    title('Wellenzahlen k-R-t2 und k-I-t2', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(15);
                    plot( uv_2, alpha_t2_normal ./ radw, 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('alpha-t2 und psi-t2 in Grad', "fontsize", 14);
                    plot( uv_2, psi_t2_normal ./ radw, 'g', "linewidth", 1.01  );
                    title('Winkel alpha-t2 und psi-t2', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["alpha-t2"; "psi-t2"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "alpha-t2", "psi-t2");
                        endif
                    %
                    figure(16);
                    plot( uv_2, real(Z_FW_t2_tr), 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('Z-FW-t2-tr', "fontsize", 14);
                    plot( uv_2, imag(Z_FW_t2_tr), 'g', "linewidth", 1.01  );
                    title('Z-FW-t2-tr TE  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %
                    figure(17);
                    plot( uv_2, real(Z_FW_t2_lo), 'r', "linewidth", 1.01  );
                    hold on;
                    xlabel('alpha-e2 in Grad', "fontsize", 14);
                    ylabel('Z-FW-t2-lo', "fontsize", 14);
                    plot( uv_2, imag(Z_FW_t2_lo), 'g', "linewidth", 1.01  );
                    title('Z-FW-t2-lo TE  Real- und Imaginaerteil', "fontsize", 14);
                        if (legend_flag == 2)
                            legend( ["Re"; "Im"], "location", "east");
                        elseif (legend_flag == 1)
                            legend( "Re", "Im");
                        endif
                    %

%%                    disp(' PAUSE !    Weiter mit Taste ...');
%%                    pause();


%%              endif


% vorlaeufig Dummies als Return-Parameter :
p_handles = 0;
p_errors  = 0;

endfunction
