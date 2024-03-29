function Text_HSN_EPT_Bo12_1()
%
disp([' ',
      ' Dies ist der Ansichts-Modus "HSN = H senkrecht, Sheet normal auf H"', 
      '                         und "EPT = E parallel, Sheet parallel zu E" !', 
      ' und zwar für eine aus einem Medium 1 einfallende "gewöhnliche" ebene Welle.',
      ' ',
      ' Die einfallende Welle sei linear polarisiert, wobei H "senkrecht" stehe (s.u.).',
      ' ',
      ' Sie wird an einer ersten ( unendlich ausgedehnten, ebenen ) Grenzfläche',
      ' reflektiert und gebrochen. Dahinter befindet sich ein Medium 2 mit',
      ' i.a. anderen Werten der Dielektrizität, der Leitfähigkeit u. ggfs. der',
      ' Permeabilität.',
      ' Die gebrochene Welle ist aber longitudinal elliptisch polarisiert in E.',
      ' Nur H steht weiterhin "senkrecht". Dieser Wellentyp heisst "TM".',
      ' ',
      ' Das Medium 2 bildet eine Schicht endlicher Dicke, an deren Hinterseite',
      ' ein zweiter, analoger Vorgang Reflexion zurück bzw. Brechung in ein Medium 3',
      ' hinein ( mit i.a. wiederum anderen Materialkonstanten ) bedeutet. ',
      ' Ein Beispiel sei "Luft  --> Glasscheibe --> Wasser". ',
      ' ',
      ' Zur vollständigen Beschreibung der Ausbreitung müssen alle Mehrfachreflexionen',
      ' innerhalb der Schicht 2 berücksichtigt werden.',
      ' ',
      ' Letztendlich kann das Schema auf Mehrfach-Schichten erweitert werden, z.B.auf',
      '   "Luft --> Lack --> Kunststoff --> Grundierung --> Lack --> Luft" , ',
      ' wie es oft bei Antennen hinter Verblendungen vorkommt (Radars am PKW).',
      ' ',
      ' Das magnetische Feld H wird hier besonders gut dargestellt, d.h. KORREKT',
      ' gezeichnet ! - "H senkrecht" bedeutet ja, dass H senkrecht auf der ', 
      ' "Einfallsebene" steht, also auf der "x-y-Ebene". Also gibt es nur H_z ! ', 
      ' Die H-Sheets stehen "je normal auf der magnetischen Feldstärke" !', 
      ' Darum SIEHT man sie wie "Wasserwellen" !', 
      ' Die E-Sheets liegen aber "je parallel zur elektrischen Feldstärke"', 
      ' Darum SIEHT man sie als "Scherwellen" ! ( gewöhnungsbedürftig )', 
      ' Leider kann man HIER nur H komplett darstellen !', 
      '               Für E gilt :',
      '    1) In EINEM EPT-Sheet kann man das GESAMTE E im "Betrag" zeigen;',
      '       Also geht KEINE Information über die Quer-Verteilung verloren',
      '       ( Besser als bei "EPN" )',
      '    2) Da die gebrochene Welle transversale UND longitudinale Anteile',
      '       NUR im E mit UNTERSCHIEDLICHEN Phasen enthält, wird hier auf',
      '       jede Darstellung der "longitudinalen Phase" verzichtet !',
      '       Die FARBEN im Sheet entsprechen der rein "transversalen Phase" .',
      ' ',
      ' Alle TM-Fälle werden HIER mit Transmissionsfaktoren für H berechnet !',
      ' Dies wird in der Literatur NICHT EINMAL ERWÄHNT, geschweige denn angewandt !',
      ' Für ein ELLIPTISCH polarisiertes Feld wie E müsste man DYADISCHE MATRIZEN definieren !',
      ' NUR FÜR H gibt es skalare Reflexions- und Transmissionsfaktoren !!!',
      ' ',]);
%
endfunction