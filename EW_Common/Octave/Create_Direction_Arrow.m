function [li_1, li_2, li_3, li_4] = Create_Direction_Arrow( x0, y0, 
                                 arlen, arwid, 
                                 arsepar, arpixw, aralpha, arcolor)
%{

(DOPPEL-) PFEIL PLOTTEN
       Rolf Poddig

    #           ( geeignet mindestens bei :
    #              - PLAIN WAVES   )
    # 
    #    ( Laufrichtung :  aralpha gegen -y-Achse !
    #                      nach +x und -y  )
    #
    #         Eingabe-Parameter :
    #  x0, y0
    #  arlen, arwid, arsepar, 
    #  arpixw 
    #  aralpha als Ausfallswinkel GEGEN -y !

Started on Okt. 30., 2017
Last Changes on Okt. 30., 2017
%}

%{
                       History :

 30. Okt.  2017 :  - Beginn
%}

S_a = sin(aralpha);     C_a = cos(aralpha);

arsep2 = 0.5 * arsepar; arwid2 = 0.5 * arwid;

h0 = arlen +arsep2;
h1 = h0 - arwid2;

h2C = arsep2 * C_a;     h2S = arsep2 * S_a;
h3C = h1 * C_a;         h3S = h1 * S_a;
h4C = arlen * C_a;      h4S = arlen * S_a;
h5C = arwid2 * C_a;     h5S = arwid2 * S_a;

x0o = x0 + h2C;
y0o = y0 + h2S;

xEo = x0o + h4S;
yEo = y0o - h4C;

x0u = x0 - h2C;
y0u = y0 - h2S;

xEu = x0u + h4S;
yEu = y0u - h4C;

xAo = x0 + h3S + h5C;
yAo = y0 + h5S - h3C;

xAu = x0 + h3S - h5C;
yAu = y0 - h5S - h3C;

xS = x0 + h0 * S_a;
yS = y0 - h0 * C_a;

li_1 = line( [x0o, xEo], [y0o, yEo], [0., 0.], ...
             "linewidth", arpixw, "color", arcolor);
li_2 = line( [x0u, xEu], [y0u, yEu], [0., 0.], ...
             "linewidth", arpixw, "color", arcolor);
li_3 = line( [xAo, xS], [yAo, yS], [0., 0.], ...
             "linewidth", arpixw, "color", arcolor);
li_4 = line( [xAu, xS], [yAu, yS], [0., 0.], ...
             "linewidth", arpixw, "color", arcolor);

endfunction
