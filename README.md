### Einleitung

Dieses Projekt entstand 2014 an der Hochschule für angewandte Wissenschaften Würzburg-Schweinfurt als Demo für Studenten der Elektrotechnik. Es wurde seither sowohl von Prof. Dr. Poddig als auch in studentischen Bachelor- und Masterarbeiten weiterentwickelt. Ziel des Projektes war zunächst eine Demonstration -in (halbwegs) flüssiger 3D-Darstellung- der Reflexion und Brechung ebener elektromagnetischer Wellen an der Grenze zweier Medien mit unterschiedlichen Materialeigenschaften (Dielektrizität, Permeabilität, Leitfähigkeit). Die Materialgrößen -insbesondere die Leitfähigkeit-, die Frequenz und der Einfallswinkel sollten dabei beliebig bzw. frei wählbar sein. Das Programm war und ist konzipiert für "normale" PC's (Desktop, Laptop ...), wobei die Animation auf größeren Flächen (Bildschirm, Leinwand ...) ansprechender wirkt. Die Berechnugen werden in "Echtzeit" durchgeführt. Das bedeutet, dass diese definitiv nicht "vorher" aufgezeichnet und anschließend als "Video" abgespielt werden. 

### Bedienung

Das Programm lässt sich im Standalone- oder GUI-Modus starten. 
Im Standalone-Modus wird die Simulation aus der Octave-GUI gestartet, wobei alle Anpassparameter im Terminal und Skript festgelegt werden. Die entsprechenden Skripte befinden sich im Verzeichnis EW_TE -> TE_Common. 
Der GUI-Modus ermöglicht eine einfache Bedienung für Dritte. Hierzu stehen zwei Python-GUI's zur Verfügung (Demo und Advanced). Die Demo-GUI wurde rein zur Demonstrationszwecken entwickelt, weshalb die Materialeigenschaften aus einer Sammlung von fiktiven Werten bezogen werden. Die Advanced-GUI ist mit einer SQLite3-Datenbank verbunden, in welcher reale Materialeigenschaften enthalten sind. 
Der GUI-Modus des Programmes lässt sich wie folgt bedienen:

* Start_GUI ausführen
* Demo- oder Advanced-GUI wählen
* Im Reiter "Materialien" die gewünschten drei Medien festlegen
* Im Reiter "Hauptmenü" den Modus(Winkel-, Frequenzsweep oder fester Winkel/feste Frequenz), Frequenz und Winkel definieren
* Animation mit einem Klick auf "Start" starten


### Warum "Open-Source"?

* Zunächst ist es von Interesse, ob bzw. wie hilfreich oder sogar nützlich Anwender das Programm finden. 
* Weiterhin sind Verbesserungen und Erweiterungen bzw. Modifikationen durch andere Entwickler erwünscht.

### Anmerkungen

* Das Programm wurde ausschließlich unter Linux entwickelt und getestet.
* Falls Interesse am mathematischen bzw. physikalischen Modell des Programmes besteht, können ausführliche Informationen gerne erfragt werden. 
