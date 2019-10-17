function [kr kxi kyi] = k_Wave_cmpl_vector(om, eps, mue, kap, psi)
    %{  vektorielle komplexe Wellenzahl korrekt
    #           ( geeignet mindestens bei :
    #              -    Typ 2 , gebrochene , mit Daempfung )
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
 %}

    Cpsi = cos(psi);
    V = 0.5 * om^2 * mue * eps;
    W = 0.5 * om * mue * kap / Cpsi;
    krh = sqrt( V  + sqrt(V^2 + W^2) ); 
    ki = -W / krh;
% VZ's KOMPLIZIERT bei Komponenten des Imaginaerteils ! (Siehe "E_SN_Fall_1") :
kr = krh; 
kxi = ki * Cpsi;
kyi = -ki * sin(psi);
endfunction