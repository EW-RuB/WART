function [COLORMAP_Rolf_1, COLORS_bo0, dhco1] = Colors_2( i_phi)


% André: ohne cd kann Colormap nicht geöffnet werden!
curdir = cd('../../EW_Common/Octave');

COLORMAP_Rolf_1 = zeros(256, 3); COLORS_bo0 = zeros(15, 25);

% fuer "Border-Sheet" in GUI-Farben :
dhco1 = 1. / double(i_phi);
hco2 = 1. / 39.;

    for m = 1:15
        for k = 1:25
           COLORS_bo0(m, k) = double(m - k) * hco2;
        endfor
    endfor

COLORMAP_Rolf_1 = csvread( 'COLORMAP_Rolf_1.csv');

% wieder zurück (dir)
cd(curdir);

%{
%      Rolfs GUI = ERSTE 64 Farben (vorlaeufig auch border sheet) :
%%cmaph = colormap('bone');	% geht ; langweilige Grau-Toene
%%for i = 1:64
    %%COLORMAP_Rolf_1(i, 1:3) = cmaph(i, 1:3);
%%endfor
%
%disp("  1 ... 16  :  monoton ansteigende helle Grau-Toene");
for i = 1:16
    r = 0.5 + double(i-1) / 35.;
    g = 0.5 + double(i-1) / 40.;
    b = 0.5 + double(i-1) / 31.;
    COLORMAP_Rolf_1(i, 1:3) = [r, g, b];
    %h = COLORMAP_Rolf_1(i, 1:3);
    %disp([num2str(h)]);
endfor
%disp("  17 ... 32  :  monoton abfallende Stahlblau-Toene");
for i = 17:32
    r = 0.5 - double(i-17) / 50.;
    g = 0.4 - double(i-17) / 100.;
    b = 0.9 - double(i-17) / 50.;
    COLORMAP_Rolf_1(i, 1:3) = [r, g, b];
    %h = COLORMAP_Rolf_1(i, 1:3);
    %disp([num2str(h)]);
endfor
%disp("  33 ... 48  :  monoton ansteigende helle Blau-Violett-Toene");
for i = 33:48
    r = 0.3 + double(i-33) / 28.;
    g = 0.2 + double(i-33) / 100.;
    b = 0.5 + double(i-33) / 45.;
    COLORMAP_Rolf_1(i, 1:3) = [r, g, b];
    %h = COLORMAP_Rolf_1(i, 1:3);
    %disp([num2str(h)]);
endfor
%disp("  49 ... 64  :  monoton abfallende Grau-Violett-Toene");
for i = 49:64
    r = 0.8 - double(i-49) / 60.;
    g = 0.55 - double(i-49) / 120.;
    b = 0.8 - double(i-49) / 60.;
    COLORMAP_Rolf_1(i, 1:3) = [r, g, b];
    %h = COLORMAP_Rolf_1(i, 1:3);
    %disp([num2str(h)]);
endfor
%
%      einfallende :
cmaph = colormap('jet');
for i = 1:64
    COLORMAP_Rolf_1(i+64, 1:3) = cmaph(i, 1:3);
endfor
%
%      reflektierte :
%cmaph = colormap('pink');	% schlecht, kaum Farbkontrast selbst mit Faktor 2
%cmaph = colormap('spring');	% hell rosa bis orange, etwas besser (mit Faktor 2)
%cmaph = colormap('summer');	% hell gruen bis gelb, wenig Kontrast
% 2014 u. 2015 benutzt :
cmaph = colormap('hot');	% kraeftiges hell rot bis gelb , OK mit Faktor 2
for i = 1:64
    COLORMAP_Rolf_1(i+128, 1:3) = cmaph(i, 1:3);
endfor
% Feb. 2016  Modifikation : die Orange-Toene gut, Gelb aber zu kontrastarm auf Weiss :
% statt Gelb Gruen versuchen, ist schon im 1. Versuch besser :
%disp("  33 ... 64  :  monoton hellere und gruenere Toene");
r_0 = cmaph(32, 1);   g_0 = cmaph(32, 2);   b_0 = cmaph(32, 3);
for i = 33:64
    r = r_0 - double(i-32) / 50.;
    g = g_0 + double(i-32) / 50.;
    b = b_0 + double(i-32) / 100.;
    COLORMAP_Rolf_1(i+128, 1:3) = [r, g, b];
endfor
%
%      transmittierte / gebrochene :
cmaph = colormap('copper');	% schlecht, kaum Farbkontrast selbst mit Faktor 2
cmaph = colormap('cool'); 	% hell blau u pink, etwas besser, zumindest mit Faktor 2
%    geht :
%for i = 1:64
%    COLORMAP_Rolf_1(i+192, 1:3) = cmaph(i, 1:3);
%endfor
%    Versuch einer Kontrast-Erhoehung in den Blautoenen (erste 32 Werte) :
%         im Original : COLORMAP_Rolf_1 
%  (193, 1:3)  =   0         1         1
%  (203, 1:3)  =   0.15873   0.84127   1.0
%  (214, 1:3)  =   0.33333   0.66667   1.0
%  (224, 1:3)  =   0.49206   0.50794   1.0
for i = 1:32
    % von recht intensivem Hellblau zu Blau-Violett
    % Rot :
    % dunkler enden lassen :
    COLORMAP_Rolf_1(i+192, 1) = cmaph(i, 1) * 0.8;
    %COLORMAP_Rolf_1(i+192, 1) = cmaph(i, 1);
    % Gelb :
    % dunkler beginnen lassen :
    COLORMAP_Rolf_1(i+192, 2) = 0.4 * 0.508 + 0.6 * cmaph(i, 2);
    %COLORMAP_Rolf_1(i+192, 2) = cmaph(i, 2);
    % Blau :
    % dunkler beginnen lassen :
    COLORMAP_Rolf_1(i+192, 3) = 0.8 + double(i) / 160.01;
    %COLORMAP_Rolf_1(i+192, 3) = cmaph(i, 3);
endfor
%    Versuch einer Kontrast-Erhoehung in den Violett-Toenen (zweite 32 Werte) :
for i = 33:64
    COLORMAP_Rolf_1(i+192, 1:3) = cmaph(i, 1:3);
endfor
%}
%
endfunction
