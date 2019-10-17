function [kr ki] = k_Wave_cmpl_scalar(om, eps, mue, kap)
    %{  skalare komplexe Wellenzahl korrekt
    #           ( geeignet mindestens bei :
    #              -    Freiraum
    #              -    Typ 1 , einfallende , reflektierte )
    # 
    #    ( Laufrichtung Phase UND Daempfung : nach +x )
    # Rolf :
    #        (kr + J * ki)^2 = om^2 * mue * eps - J * om * mue * kap
    #        kr^2 - ki^2 - J * 2 * kr * ki = om^2 * mue * eps - J * om * mue * kap
    #            a)   kr^2 - ki^2 = om^2 * mue * eps
    #            b)   2 * kr * ki = - om * mue * kap
    #        ki = - (0.5 * om * mue *kap) / kr
    #              V = om * om * mue * eps          W = 0.5 * om * mue * kap     
    #        kr^2 - W^2 / kr^2 = V
    #        kr^4 - V * kr^2 - W^2 = 0       ;  s.o. a)   ==>   kr^2 >= V
    #        kr = sqrt( 0.5 * V  + sqrt(0.25 * V^2 + W^2) )
 %}

    V = 0.5 * om^2 * mue * eps;
    W = 0.5 * om * mue * kap;
kr = sqrt( V  + sqrt(V^2 + W^2) ); 
ki = -W / kr;
endfunction