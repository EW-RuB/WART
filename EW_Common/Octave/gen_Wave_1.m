function g = gen_Wave_1(X, Y, phi, Amp, k_r, k_i)
    %{  TEM-simpel  ausbreitungsfaehig  gedaempft
    #           ( geeignet mindestens bei :
    #              -    Freiraum
    #              -    E_senkr , einfallende u. reflektierte )
    # 
    #  mit Anfangs-Amplitude u. komplexer Wellenzahl
    #    ( Laufrichtung Phase UND Daempfung : nach +x )
    %}
g = Amp .* exp(k_i .* X) .* cos(phi .- k_r .* X);
