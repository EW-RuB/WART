function g = gen_Wave_2(X, Y, phi, Amp, k_r, kx_i, ky_i)
    %{          transmittierte Welle ausbreitungsfaehig gedaempft 
    #           ( geeignet mindestens bei :
    #                E_senkr , vom duennen zum dichten MIT VERLUSTEN)
    #
    #  mit Anfangs-Amplitude und
    #  komplexer Wellenzahl ; e_Amp beliebig gedreht gegenueber e_Pha
    #  TEM ? generell nicht, sobald ky_i nicht Null ist
    #    ( Laufrichtung Phase : nach  "+x" 
    #      Laufrichtung Daempfung : nach " +kx_i * x + ky_i * y " )
    %}
g = Amp .* exp(kx_i .* X .+ ky_i .* Y) .* cos(phi .- k_r .* X);
