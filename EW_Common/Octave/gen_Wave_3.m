function g = gen_Wave_3(X, Y, phi, Amp, k_r, k_i)
    %{        "transmittierte" Grenz-Welle ausbreitungsfaehig QUER-gedaempft 
    #           ( geeignet mindestens bei :
    #                E_senkr , vom dichten zum duennen VERLUSTLOSEN,
    #                          bei alpha > alpha_Grenz )
    #
    #  mit Anfangs-Amplitude und
    #  komplexer Wellenzahl ; e_Amp 90 Grad gedreht gegenueber e_Pha
    #  TEM ? eher nicht
    #    ( Laufrichtung Phase : nach  "+x" 
    #      Laufrichtung Daempfung : nach  " + k_i * y " )
    %}
%return Amp * exp(k_i * Y) * cos(phi - k_r * X)
% fuer Octave :
g = Amp .* exp(-k_i .* Y) .* cos(phi .- k_r .* X);
