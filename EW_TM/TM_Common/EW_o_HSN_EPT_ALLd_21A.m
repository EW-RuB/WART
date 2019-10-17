%
%{
      a 'correct' '3D animation' of 
PLANE WAVES, REFLECTION and REFRACTION  (stage 12)
       Rolf Poddig

HERE :  Border 1 : TEM incident , Case delta  ;  Border 2 : TM incident , Case delta
        E parall ( Sheets parallel );  H ortho ( Sheets normal )

Started on Jan. 07., 2019
Last Changes on Jan. 30., 2019
%}

%{
                       History :
                       
 19. Feb.  2019 :  - TM wird auf Stand von TE gebracht (Frequenz-Sweep!)
   
 30. Jan.  2019 :  - aktuelles Ziel : Werte alpha_t,21 u.  psi_t,21 Unsinn bei Rückwärts-Aufruf kRt2_Solve_01 ???
                        ==> von TE übernommen !  der Winkel psi_t,21 sollte IMMER 0 sein !!??
                        ==>     korrigiert :  kRt2_Solve_01( ..., k10, p15, ...)  mit Material #1 statt #2 !      OK


 07. Jan.  2019 : - Beginn als Kopie von EW_o_HSN_EPT_ALLd_14A  : weitermachen als Rolfs Variante
                  - History von Version André ergänzt
 
 
                             ALT in EW_o_HSN_EPT_ALLd_14A :

20. Dez.  2018 : - André Variante mit argv() fertig
28. Okt.  2018 : - Beginn als Kopie von EW_o_HSN_EPT_ALLd_13R  : André Variante mit argv()
 
                             ALT in EW_o_HSN_EPT_ALLd_13R :

 
 28. Okt.  2018 : - Angleichung an EW_o_ESN_HPT_ALLd_18R (Stand 28.Okt.'18)                             OK
                              ==> läuft wie TE mit 79 - 82 FPS                                          OK
                  - Verbesserungen / Tauschen : 
                    a) Texte 'Schichtdicke echt ...' und 'Winkel an Border ...' samt Zahlen :
                            ==> bei TM besser links <-> rechts                                          OK
                    b) Pfeil 'Schichtdicke' und 'Maßstab ...' samt Zahlen :
                            ==> bei TM besser in das linke E-Subplot                                    OK
                            ==> bei TE besser in das RECHTE H-Subplot !  (S. EW_o_ESN_HPT_ALLd_18R) !

 26. Okt.  2018 : - Beginn als Kopie von EW_o_HSN_EPT_ALLd_12R vorsichtshalber : nach fast 11 Monaten Pause
                    ==> Ziel : Umbau zur Angleichung an EW_o_ESN_HPT_ALLd_18R (Stand 26.Okt.'18)


                        ALT in EW_o_HSN_EPT_ALLd_12R :

 09. Dez.  2017 : - Beginn als Kopie von EW_o_HSN_EPT_ALLd_11R   vorsichtshalber :
                  - UMBAU Doppelpfeil ab ca. line 1754  ( wie in EW_o_ESN_HPT_ALLd_15R )                OK
                  - einige 'disp()' auskommentiert, neuere kRt2_Solve_01 und kRt_Solve_01


                        ALT in EW_o_HSN_EPT_ALLd_11R :

 20. Nov.  2017 :  - GROSSER UMBAU : ab ca. line 1100 ( 2. Runde )  FERTIG  !!
                        ==> laeuft incl. Pfeilen mit 84 - 86 FPS                                        OK
                        ==> noch Unsinn in den additional Plots ! ( alle r-s und t-s )
                   - Beginn als Kopie von EW_o_HSN_EPT_ALLd_10R   vorsichtshalber :
                        ALLES  an EW_o_ESN_HPT_ALLd_14R.m orientiert !

%}


more off;
clear all;


% vorläufig für Flags :
True = 1;    False = 0;
None = False;

%          zur Beschleunigung :
%
%  1)    ignore_function_time_stamp :
old_ifts = ignore_function_time_stamp;
ignore_function_time_stamp = "all";
%
%  2)    Just_In_Time octave compiler :
%    JIT FEHLT in der Octave-Version 4.2.2 noch ! (bei Ubuntu 18.04) !

radw = pi / 180.;
J = complex(0., 1.);        % Rolf : lieber großes J , das fällt auf

mue_0 = 1.2566370614e-6;	eps_0 = 8.854187817e-12;	c0 = 2.99792458e8;


% Frequenz :
%
freq_ref = c0;	% als REFERENZ ==> lamb_0_Freiraum = 1.0 m
%
%freq = 5.e05;        %  500  kHz
%freq = 1.5e07;       %   15  MHz

% 14. Nov. 18 André: Asukommentiert wegen argv()
%freq = freq_ref;     %  300  MHz

%freq = 1.1e10;       %   11  GHz
%freq = 3.e11;       %   300  GHz
%freq = 6.e14;        %  600  THz =     500 nm  =  blaues / gruenes Licht ?


%       Prinzipieller Programm-Mode { DEMO oder ECHTE MATERIALIEN u. DATEN } :
DEMO_or_TRUE_DATA = False;   % = DEMO Mode
sub_case_str = "";


% Neu André argv()-Funktion:		typeinfo(arg_list) = cell
arg_list = argv ();

% Neu André if:
%if (length(arg_list))
%if (nargin())
if (nargin() > 1)	
	if (strcmp(arg_list{1}, "Demo"))
	%demo_flag = 1;
		%disp('Demo-Mode');
		if (strcmp(arg_list{3}, "fWuF"))
			disp('fWuF');
			sub_case_str = arg_list{2};
			freq = str2double(arg_list{4});
			alpha_e_const = str2double(arg_list{5});
			%alpha_e_const *= radw;
			alpha_inc_flag = 0;
			freq_inc_flag = 0;
			inc_flag = 0;
			choice_mat = 0;
			view_mode = str2double(arg_list{6});
			static_plots = str2double(arg_list{7});
			legend_flag = str2double(arg_list{8});
		elseif (strcmp(arg_list{3}, "fF"))
			disp('fF');
			sub_case_str = arg_list{2};
			freq = str2double(arg_list{4});
			alpha_e_min = str2double(arg_list{5});
			alpha_e_min *= radw;
			alpha_e_max = str2double(arg_list{6});
			alpha_e_max *= radw;
			alpha_inc = str2double(arg_list{7});
			alpha_inc_flag = 1;
			freq_inc_flag = 0;
			choice_mat = 0;
			view_mode = str2double(arg_list{8});
			static_plots = str2double(arg_list{9});
			legend_flag = str2double(arg_list{10});
		endif;
	else
	%elseif (strcmp(arg_list{1}, "Expert"))
		%disp('Expert-Mode');
		% disp([arg_list{2}, '_FERTIG']);			%wird als String akzeptiert
		DEMO_or_TRUE_DATA = True;
		if (strcmp(arg_list{2}, "fW"))
			[medium_1, medium_2, medium_3] = getMaterialStruct(arg_list{3}, arg_list{4}, arg_list{5});
			f_start = str2num(arg_list{7});
			f_end = str2num(arg_list{8});
			freqWi_inc = str2num(arg_list{9});

			N_freq = ((f_end - f_start)/freqWi_inc) + 1;
			freq_array = linspace(f_start, f_end, N_freq);
			freq = freq_array(1);
			freq_inc_flag = 1;
			alpha_inc_flag = 0;
			alpha_e_const = str2num(arg_list{6});
			view_mode = str2double(arg_list{10});
			static_plots = str2double(arg_list{11});
			legend_flag = str2double(arg_list{12});
			%Für Medium 1
			for i = 1:length(freq_array)
				for m = 1:length(medium_1)
					if ( (freq_array(i) > medium_1(m).f_min) && (freq_array(i) <= medium_1(m).f_max) )
						[eps_r1_array(i), mue_r1_array(i), kap_1_array(i)] = build_epsmuekap( freq_array(i), medium_1(m));
					endif
				endfor
			endfor	
			%Für Medium 2
			for i = 1:length(freq_array)
				for m = 1:length(medium_2)
					if ( (freq_array(i) > medium_2(m).f_min) && (freq_array(i) <= medium_2(m).f_max) )
						[eps_r2_array(i), mue_r2_array(i), kap_2_array(i)] = build_epsmuekap( freq_array(i), medium_2(m));
					endif
				endfor
			endfor
			%Für Medium 3
			for i = 1:length(freq_array)
				%eps_r(i) = i;
				for m = 1:length(medium_3)
					if ( (freq_array(i) > medium_3(m).f_min) && (freq_array(i) <= medium_3(m).f_max) )
						[eps_r3_array(i), mue_r3_array(i), kap_3_array(i)] = build_epsmuekap( freq_array(i), medium_3(m));
					endif
				endfor
			endfor
		elseif (strcmp(arg_list{2}, "fF"))
			freq = str2double(arg_list{6});
			alpha_e_min = str2double(arg_list{7});
			alpha_e_min *= radw;
			alpha_e_max = str2double(arg_list{8});
			alpha_e_max *= radw;
			alpha_inc = str2double(arg_list{9});
			alpha_inc_flag = 1;
			freq_inc_flag = 0;
			choice_mat = 0;
			view_mode = str2double(arg_list{10});
			static_plots = str2double(arg_list{11});
			legend_flag = str2double(arg_list{12});
			[medium_1, medium_2, medium_3] = getMaterialStruct(arg_list{3}, arg_list{4}, arg_list{5});		
			
			%Für Medium 1
			for m = 1:length(medium_1)
				if ( (freq > medium_1(m).f_min) && (freq <= medium_1(m).f_max) )
					[eps_r1, mue_r1, kap_1] = build_epsmuekap( freq, medium_1(m));
				endif
			endfor
			%Für Medium 2 
			for m = 1:length(medium_2)
				if ( (freq > medium_2(m).f_min) && (freq <= medium_2(m).f_max) )
					[eps_r2, mue_r2, kap_2] = build_epsmuekap( freq, medium_2(m));
				endif
			endfor
			%Für Medium 3
			for m = 1:length(medium_3)
				if ( (freq > medium_3(m).f_min) && (freq <= medium_3(m).f_max) )
					[eps_r3, mue_r3, kap_3] = build_epsmuekap( freq, medium_3(m));
				endif
			endfor
		else
			freq = str2double(arg_list{6});
			alpha_e_const = str2double(arg_list{7});
			alpha_e12 = alpha_e_const * radw;
			view_mode = str2double(arg_list{8});
			static_plots = str2double(arg_list{9});
			legend_flag = str2double(arg_list{10});
			alpha_inc_flag = 0;
			freq_inc_flag = 0;
			inc_flag = 0;
			choice_mat = 0;
			[medium_1, medium_2, medium_3] = getMaterialStruct(arg_list{3}, arg_list{4}, arg_list{5});
			
			%Für Medium 1
			for m = 1:length(medium_1)
				if ( (freq > medium_1(m).f_min) && (freq <= medium_1(m).f_max) )
					[eps_r1, mue_r1, kap_1] = build_epsmuekap( freq, medium_1(m));
				endif
			endfor
			%Für Medium 2 
			for m = 1:length(medium_2)
				if ( (freq > medium_2(m).f_min) && (freq <= medium_2(m).f_max) )
					[eps_r2, mue_r2, kap_2] = build_epsmuekap( freq, medium_2(m));
				endif
			endfor
			%Für Medium 3
			medium_3
			for m = 1:length(medium_3)
				if ( (freq > medium_3(m).f_min) && (freq <= medium_3(m).f_max) )
					[eps_r3, mue_r3, kap_3] = build_epsmuekap( freq, medium_3(m));
				endif
			endfor
			%{
			disp(["eps_r1 = ", num2str(eps_r1)]);
			disp(["mue_r1 = ", num2str(mue_r1)]);
			disp(["kap_1 = ", num2str(kap_1)]);
			
			disp(["eps_r2 = ", num2str(eps_r2)]);
			disp(["mue_r2 = ", num2str(mue_r2)]);
			disp(["kap_2 = ", num2str(kap_2)]);
			
			disp(["eps_r3 = ", num2str(eps_r3)]);
			disp(["mue_r3 = ", num2str(mue_r3)]);
			disp(["kap_3 = ", num2str(kap_3)]);
			%}
		endif
	endif
	
	
	
	%elseif (arg_list{1} = "Expert")
	%	disp('Expert-Mode');
	
	%disp('Python-GUI');
	%disp(typeinfo(arg_list));
	%celldisp (arg_list);
	%arg1 = arg_list{1};
	%printf (" %s", arg1);
	%arg2 = arg_list{2};
	%printf (" %s", arg2);
else
	disp( "\t \t \t       Octave-GUI");
	disp( "\t \t { derzeit nur verfügbar im Demo-Mode ! }");
    %
	fflush (stdout);
	disp('                      Bitte einen Fall AUSWÄHLEN , d.h.');
	disp('              ZUERST die Polarisation  ==  TE  oder  TM');
	disp('              UND DANN  den Brechungstyp an beiden Grenzen  ==  _1a1a ... _2b2b');
	disp('    Bitte ALS EINEN STRING OHNE ANFÜHRUNGSZEICHEN EINGEBEN , also  TE_1a1a ... TM_2b2b  :');
	general_case_str = input( "         HIER  TM_1a1a ... TM_2b2b  >  ", "s");
	polaris_str = substr(general_case_str, 1, 2);
	sub_case_str = substr(general_case_str, 4, 4);
	% nur zur Kontrolle, funktioniert :
	%general_case_str_reconst = strcat( polaris_str, "_", sub_case_str)
	%
	disp(' ');
	disp('        zum gewünschten Fall passende Materialien auswählen :');
	disp('Bitte Auswahl-Integer EINGEBEN ;');
	disp('    0 = (jeweils geeignete) Defaults ;');
	disp('    1 ... N  =  weitere Beispiele , sofern in <Properties_Media_1> definiert !');
	fflush (stdout);
	choice_mat = input("         Materialwahl-Integer >  ");
	%
	%
	% 					Flags und Parameter:
	
	view_mode = 1;
	static_plots = 0;
	legend_flag = 2;
	alpha_inc_flag = 0;    freq_inc_flag = 0;
    %
    alpha_e_min = pi / 6.;	alpha_e_max = pi / 6.;   alpha_inc = 0.;   % (Inc. in Grad)
    %
	freq = 2.99792458e8;   % = freq_ref
	i_f_schritt = 200;    % Anzahl Frequenzen, falls sie laufen soll

	disp(' ');
	disp('        gewünschte Laufvariable wählen :');
	disp('    fFfW = feste Frequenz  ;  fester Einfallswinkel');
	disp('    fF = feste Frequenz  ;  Einfallswinkel variiert zwischen 0 und 90 Grad');
	disp('    fW = fester  Einfallswinkel  ;  Frequenz variiert zwischen 200 und 600 MHz');
	fflush (stdout);
	disp('    Bitte ALS EINEN STRING OHNE ANFÜHRUNGSZEICHEN EINGEBEN :');
	Laufvariable_str = input( "         HIER  fF , fW oder fWuF  >  ", "s");
    %
		if (strcmp( Laufvariable_str, "fF") )
            alpha_inc_flag = 1;
            alpha_e_min = 0.;	alpha_e_max = 0.5 * pi;   alpha_inc = 0.5;   % (Inc. in Grad)
			alpha_array = linspace( alpha_e_min, alpha_e_max, 
                                    ((alpha_e_max - alpha_e_min)/alpha_inc) + 1);
 		elseif (strcmp( Laufvariable_str, "fW") )
            freq_inc_flag = 1;
			f_start = 2.e8;      f_end = 6.e8;
			freq_array = linspace( f_start, f_end, i_f_schritt);
 		%elseif (strcmp( Laufvariable_str, "fWuF") )
        endif
endif


Text_HSN_EPT_Bo12_1();              % später überarbeiten ! nicht primär wichtig

if (! DEMO_or_TRUE_DATA)
	disp("Here DEMO Mode");
	Help_Case_Texts_1( sub_case_str);
endif

%{ 19. Feb. 2019
%          zur Beschleunigung :
%
%  1)    ignore_function_time_stamp :
old_ifts = ignore_function_time_stamp;
ignore_function_time_stamp = "all";
%
%  2)    Just_In_Time octave compiler :
%    JIT FEHLT in der Octave-Version 4.2.2 noch ! (bei Ubuntu 18.04) !
%}

%{ 19. Feb. 2019
radw = pi / 180.;
J = complex(0., 1.);        % Rolf : lieber großes J , das fällt auf

mue_0 = 1.2566370614e-6;	eps_0 = 8.854187817e-12;	c0 = 2.99792458e8;


% Frequenz :
%
freq_ref = c0;	% als REFERENZ ==> lamb_0_Freiraum = 1.0 m
%
%freq = 5.e05;        %  500  kHz
%freq = 1.5e07;       %   15  MHz

% 14. Nov. 18 André: Asukommentiert wegen argv()
%freq = freq_ref;     %  300  MHz

%freq = 1.1e10;       %   11  GHz
%freq = 3.e11;       %   300  GHz
%freq = 6.e14;        %  600  THz =     500 nm  =  blaues / gruenes Licht ?
%}

%{
% Daraus lambda_0  im Vakuum-Freiraum :
lamb_0 = c0 / freq;

% die Kreisfrequenz :
om = 2. * pi * freq;    om_ref = 2. * pi * freq_ref;
%
scl_om = om / om_ref;
%}

%   "zweite Skalierung" per Flag zuschaltbar    'Dicke des Mediums # 2' in Wellenlängen gemeint ! :
%auto_scl_lam = False;      % NICHT WEITER VERFOLGT mindestens bis Mai 2017 !
auto_scl_lam = True;		% so werden IMMER mindestens 4 Perioden räumlich in jedem Medium angezeigt

% 03. Sept. 14  :  "dritte Skalierung" per Flag zuschaltbar : 'gewünschte Frame-Rate' der Darstellung :
%       Eingabe ergibt mit i_phi multipliziert  die FPS ;  z.B. 0.5 ==>  50 FPS  bei i_phi = 100
%       { das ist immer die BERECHNETE FPS ; sie hat NICHTS mit der CRT-/LCD-Monitor-FPS zu tun }
%
%f_view_wanted = 0.25;    %  Nur zum Testen !!!        25 FPS  bei i_phi = 100
f_view_wanted = 0.35;    %  flüssige Bewegung        35 FPS  bei i_phi = 100
%f_view_wanted = 0.5;      %    50 FPS  bei i_phi = 100
%f_view_wanted = 0.65;    %   noch nicht zu hektisch !
%f_view_wanted = 0.85;    %   noch nicht zu hektisch ! Keine Detail-Studien (Ampl., Phase) möglich
%f_view_wanted = 2.0;     %  Test !       zu hektisch ?
%f_view_wanted = 4.0;     %  Test !       zu hektisch ?   Nein, beschleunigt derzeit auf Maximum
%
T_view_Pause = 1.e-9;   %  soll per default NICHT 'Bremsen' => so kurz wie möglich
%
% Soll T_view_Pause laufend angepasst werden, um die FPS dem Wunsch-Wert anzupassen ? :
%auto_spd_FPS = False;
auto_spd_FPS = True;

% 24. Jan. '15  :  "laufender Einfallswinkel" :
%alpha_inc_flag = 0;    % soll per default NICHT LAUFEN
% 14. Nov. 18 André: Asukommentiert wegen argv()
%alpha_inc_flag = 1; 	% bei alpha_e_min Grad beginnen, immer zwischen 0 und 90 Grad pendeln
%
%alpha_inc = 2. * radw;     %   Einfallswinkel-Inkrement = 2 Grad ; schnell, aber grob
%alpha_inc = 1. * radw;     %   Einfallswinkel-Inkrement = 1 Grad

% 14. Nov. 18 André: Asukommentiert wegen argv()
%alpha_inc = .5 * radw;     %   Einfallswinkel-Inkrement = 0.5 Grad
%14. Nov. 18 André Neu:
if (alpha_inc_flag)
	alpha_inc *= radw;
endif

%alpha_inc = .25 * radw;	%   Einfallswinkel-Inkrement in Grad ; langsam und sehr fein
%
iruns_inc = 2;	%  alle N Perioden Winkel ändern
%
% 14. Nov. 18 André: Asukommentiert wegen argv()
%alpha_e_min = 0.;	alpha_e_max = 0.5 * pi;
%
%       Inits :
N_periods = 0;
%alpha_e_end = alpha_e_max;
% 14. Nov. 18 André: Asukommentiert wegen argv()
	if (alpha_inc_flag)
        alpha_e_end = alpha_e_max;
        alpha_e12 = alpha_e_min;
        N_alpha_e = int16( (.001 + alpha_e_max - alpha_e_min) / alpha_inc );
        uv_1 = zeros(1, N_alpha_e);
        % 17. Januar 2019 André: i_alpha_e wird durch i_inc_var ersetzt (gilt für Frequenz und Winkel)  
        i_inc_var = 1;
        inc_flag = 1;
        first_run = True;        # yes
        % seltsamerweise 1 Wert zuviel :
        %alpha_e_end = alpha_e_end + .5 * alpha_inc;
        alpha_e12 -= alpha_inc;
        freqWi_min = alpha_e_min;
        freqWi_max = alpha_e_max;
    elseif (freq_inc_flag)
        freqWi_min = f_start;
        freqWi_max = f_end;
        uv_1 = zeros(1, N_freq);
        alpha_e12 = alpha_e_const * radw;
		i_inc_var = 1;
		freq_inc_var = 1;
		dfreq = 1;
		inc_flag = 1;
        first_run = True;
    endif


% neu Rolf 18.Nov.2017:
%       "geom_Reihe_flag" : Mit internen Mehrfach-Reflexionen -> geometr. Reihe ?
%                           ==>     1 = JA       0 = NEIN
geom_Reihe_flag = True;
%
% ( Code zur Auswertung FEHLTE  NOCH !!! S. unten IDEE )
%%    if (geom_Reihe_flag)
%%        %        Faktor für ein Durchlaufen Medium 2 :
%%        fakt_med_2 =  exp( ( k_I_t12_sc * C_psi_t12 - J * k_R_t12_sc ) * L_eff_2 );
%%        %        Faktor für einen Term in 'Reihe r1_ges'  :
%%        fakt_r1_ges = r23_par * r21_senkr * 2. * fakt_med_2;
%%        %        'Reihe r1_ges'  :
%%        r1_senkr_ges = r12_senkr * 1. / (1. - fakt_r1_ges); ;
%%        %        Faktor für einen Term in 'Reihe t3_ges'  :
%%        fakt_t3_ges = r23_senkr * r21_senkr * 2. * fakt_med_2;
%%        %        'Reihe t3_ges'  :
%%        t3_senkr_ges = t23_senkr * 1. / (1. - fakt_t3_ges); ;
%%    else
%%        r1_senkr_ges = r12_senkr;
%%        t3_senkr_ges = t23_senkr;
%%    endif


% neu Rolf 30.Okt.2017:
%       "Dir_Arrow_flag" : Mit Richtungspfeil zum echten Punkt an Border 2  ==>  ?
%                           ==>     1 = JA       0 = NEIN
%Dir_Arrow_flag = False;
Dir_Arrow_flag = True;


% Alle "Koordinaten" hier sind NORMIERT auf 'lambda_0' !

%    GLOBALE Koordinaten-Grenzen "Main Sheet" :
xG_Anf = -5.;		xG_End = 5.;
yG_Anf = -5.;		yG_End = 5.;
zG_Anf = -1.;		zG_End = 1.;
%
xG_cent = 0.5 * (xG_Anf+xG_End);
yG_cent = 0.5 * (yG_Anf+yG_End);
zG_cent = 0.5 * (zG_Anf+zG_End);
xG_len = xG_End - xG_Anf;	yG_len = yG_End - yG_Anf;	zG_len = zG_End - zG_Anf;
%
scl_zxG = zG_len / xG_len;


%       Rolf, 21. Aug. 2016 :    Beginn Border #2
%
layer2_width = 4.;      % "Dicke" der Zwischenschicht ( = Medium # 2 )
                        %       ACHTUNG, meist in Wellenlängen gemeint !!!


%              Fuer Sheets # 4 und 5  =  Medien-Grenzen :
%
% wirkt bei 'Border-Sheet per surf' besser OHNE 'Kanten' :
bo_edgealpha = 0.;
%
%     Border #1 :
xbo = linspace(xG_Anf, xG_End, 25);
zbo = linspace(zG_Anf+.25, zG_End-.25, 15);
%
[XBO, ZBO] = meshgrid(xbo, zbo);
YBO = zeros(15, 25);
COLORS_bo0 = zeros(15, 25);	COLORS_bo = zeros(15, 25);
%
%     Border #2 :
%       Rolf, 21. Aug. 2016 :    Beginn Border-Sheet #2
s_offset = 0.1;
%    experimentell :
xG_off_B2 = xG_cent;
yG_off_B2 = yG_cent - layer2_width - 8. * s_offset; 
%
XBO2 = XBO .+ xG_off_B2;
YBO2 = YBO .+ yG_off_B2;


%              Für alle 5 Sheets =  Wellen :

%    "Phi" mag die Bedeutung "omega * t" besitzen.
%     Man kann auch "Phi_0" als Offset benutzen.
phi_End = 2. * pi;
%
% ZEITLICHE "Auflösung / Feinheit" pro Periode :
i_phi = 100;     
d_phi = phi_End / (i_phi - 1);
%
% 03. Sept. '14  :  für "dritte Skalierung" :
FPS_wanted = i_phi * f_view_wanted;   %  maximale Framerate ; sonst zu hektisch !
T_frame_wanted = 1. / FPS_wanted;   %  minimale Framedauer ; sonst zu hektisch !
    if( auto_spd_FPS == True )
        h3 = FPS_wanted;    h4 = T_frame_wanted;
        h2 = sprintf('%12.5e', h4* 1.e3);
        disp('   Auto-Korrektur Framerate gewünscht :');
        disp([' FPS_wanted = ', num2str(h3), ' Frames Per Second   ;  Frame-Dauer ', h2, ' ms']);
    endif

%    Lokale Koordinaten pro Sheet :      ALLE normiert auf lambda_0 !
%    ( Laufrichtung : Phase : nach +x ; Dämpfung nach +x ,ggfs +-y )
x_Anf = 0.;	x_End = 4.;
y_Anf = -1.;	y_End = 1.;
% eigentlich nur für "Sheet tangential E :" 
y_extra_par = 0.5;
y_Anf_par = y_Anf - y_extra_par;    y_End_par = y_End + y_extra_par;
%
s_len = x_End - x_Anf;		s_wid = y_End - y_Anf;
s_lwa = s_len / s_wid;
%
%  heuristisch : Sheets etwas aus dem Mittelpunkt 'heraus ziehen' :
s_offset = 0.2;

% 19.Okt.2018 : 
% prozentualer y-Versatz NUR für Amplituden-Korrekturen der Quer-Dämpfung :
%    NUR dort  y  -->  y +- ( a_y_Feld_Versatz * 0.5 * s_wid )
%a_y_Feld_Versatz = 0.;  % = Minimum = KEINE Korrektur {= Default}
%a_y_Feld_Versatz = .5;  % = HALBE Korrektur
a_y_Feld_Versatz = 1.;  % = Maximum = VOLLE Korrektur       ==> EINZIGER SINNVOLLER WERT !!!


%
%      alt ;  gute Auflösung fuer  s_len = 4 * lambda   und   s_len / s_wid = 2 :
%i_x = 100;	i_y = 25;
%      dynamisch :
i_xd = 25. * s_len;    %  mit 'auto_scl_lam' ==> 25 Werte/Periode bei '4-lambda-Sheets'
i_yd = 12. * s_wid;   % Versuch am 06. Sept. '14  : flexibler teilbar !
%

%view_rstride = 6;    % nur jeden 6. "Strahl" zeigen  ;   ab 06. Sept. 2014  ==> quer SEHR GROB !
view_rstride = 4;    % nur jeden 4. "Strahl" zeigen   ;   ab 09. Okt. 2017  ==> quer BESSERE Auflösung !
%
%view_cstride = 2;    % nur jede 2. "Phasenfront" zeigen  ===> wäre ZWEIMAL schneller
view_cstride = 1;	% unter Octave sogar schnell genug !

% Integer-Index-Grenzen :
i_x = floor( i_xd / view_cstride + .5) ;	i_y = floor(i_yd / view_rstride + .5);


xs = linspace(x_Anf, x_End, i_x);	ys = linspace(y_Anf, y_End, i_y);
%
[XS, YS] = meshgrid(xs, ys);
%       für "E_parallel" :
[XS, ZH_e] = meshgrid(xs, ys);
#
%  aber Sheets viel zu "hoch" ==>
% alt : 
%ZH_e .*= 0.2;     % "Höhe" recht gut
ZH_e .*= scl_zxG;     % "Höhe" korrekt; wichtig für graphische Darst. der Longitudinal-Felder


% wirkt bei laufenden Wellen besser MIT 'Kanten' :
w_edgealpha = 1.;	% für surf() : MIT 'dunklen Kanten'
%w_edgealpha = 0.;	% für surf() : OHNE 'dunkle Kanten'


%   neu 27. Mai 2017 für alle Medien :
%      eps_r , mue_r und kappa zum jeweiligen Fall ( '1b1b' ) passend setzen :

%{
if (! DEMO_or_TRUE_DATA) 
	[eps_r1, mue_r1, kap_1, eps_r2, mue_r2, kap_2, eps_r3, mue_r3, kap_3] = ...
				Properties_Media_1( freq, choice_mat, sub_case_str);
endif
%}

%{
%              Für Sheet # 1  =  EINFALLENDE Welle :

eps_1 = eps_r1 * eps_0;		mue_1 = mue_r1 * mue_0;	
%
c_eps_1 = complex( eps_1, (-kap_1/om) );     % NICHT 'Frequenz-relativ'
%
Z_W_1 = sqrt( mue_1 / c_eps_1 );     % NICHT 'Frequenz-relativ'
%
%      Anfangs-Phase in "Grad * radw" :
%   logisch einfachster Wert als Default :
phi_0_e = 0. * radw;	% Default
%
%      Einfallswinkel in "Grad * radw" :
    if(alpha_inc_flag)
       alpha_e12 += alpha_inc;
    else
       %
       %    bis zu "senkrechter Inzidenz" incl. :
       %alpha_e12 = 0. * radw;
       %14. Nov. 18 André Neu:
       alpha_e12 = alpha_e_const * radw;
       %alpha_e12 = 25. * radw;       % Default , WILLKÜRLICH
       %alpha_e12 = 56.6020 * radw; % winzige Refl.,  Winkel (refl., gebr.) = 90°  Brewster ???
       %    bis zu "streifendem Einfall" :
       %alpha_e12 = 90. * radw;
    endif

%      (Anfangs)-Amplitude  incl. 'Null-Phase', WILLKUERLICH :
Amp_e = 0.8;
%	für H , WILLKUERLICH :
Amp_e_H = Amp_e;  	% nur ein 1. Versuch !     

%      Wellenzahl komplex :
[k_R_e12  k_I_e12] = k_Wave_cmpl_scalar(om, eps_1, mue_1, kap_1);
%  ÄNDERN in 'Frequenz-relativ' :
k_R_e12 /= scl_om;    k_I_e12 /= scl_om;
%
%
%k_10 = om * sqrt( mue_1 * eps_1 );	%    ALT   exakt
k_10 = om_ref * sqrt( mue_1 * eps_1 );	% verlustloser Anteil ; bei om_ref
k_10_q = k_10^2;
%p_10 = om * mue_1 * kap_1;	% Verlust-Anteil
p_10_ref = om_ref * mue_1 * kap_1;	% Verlust-Anteil == negativer Im-Teil ; bei om_ref
p_10 = p_10_ref / scl_om;      % 'Frequenz-relativ'
p_15 = 0.5 * p_10;	% Hilfsvariable
%
h3 = k_10_q;    h4 = p_10;
h1 = sprintf('%12.5e', h3);
h2 = sprintf('%12.5e', h4);
disp('   ACHTUNG, Fequenz-relative Werte :');
disp([' k_1_komplex^2  =  k_10^2 - J * p_10   =   ', h1, ' - J * ', h2]);

%      Wellenlänge (NICHT normiert) :
%lamb_e = 2. * pi / k_R_e12; %   ALT   korrekt
lamb_e = 2. * pi / ( scl_om * k_R_e12 );    % korrekt

%  für die zweite Skalierung :
h1 = 0.5 * k_10_q;
k_R_e12_SI = sqrt( h1 + sqrt( h1^2 + p_15^2 ) );
lamb_e12_SI = 2. * pi / ( scl_om * k_R_e12_SI );

%      Dämpfung, d.h. endliche Leitfähigkeit, Absorption etc :
%         exp( D_alpha * xx)  mit normierten xx
%            ==>  Dämpfung ist ebenfalls 'normiert'
%D_alpha_e12 = 0.0;         % ungedämpft
%D_alpha_e12 = -k_I_e12;	  %    ALT   korrekt , einfallende simple Welle "Typ 1"
D_alpha_e12 = -k_I_e12 * scl_om;  % korrekt , einfallende simple Welle "Typ 1" , NICHT 'Freq.-rel'
%

%              Für Sheet # 2  =  REFLEKTIERTE Welle :
%
%             "Reflexionsgesetze  für H_senkrecht" , Teil 1 :
%
%       Reflexionswinkel in "Grad * radw" :
%%alpha_r12 = alpha_e12;        % korrekt,  Zählweisen u. VZ's beachten
%
%      Wellenlänge ( nicht normiert) :
lamb_r = lamb_e;          % korrekt
%
%      Dämpfung Welle Typ 1:
D_alpha_r12 = D_alpha_e12;    % korrekt
%
%      Wellenzahl komplex Welle Typ 1 :
k_R_r12 = k_R_e12;	k_I_r12 = k_I_e12;	  % korrekt, reflektierte simple Welle "Typ 1"
%
%      (Anfangs)-Amplitude ; Phasendrehung incl. :
%  korrekte Formeln fuer r12_paral und t12_paral Siehe weiter unten


%              Für Sheet # 3  =  TRANSMITTIERTE Welle :

eps_2 = eps_r2 * eps_0;		mue_2 = mue_r2 * mue_0;	
%
c_eps_2 = complex( eps_2, (-kap_2/om) );     % NICHT 'Frequenz-relativ' !
%
Z_W_2 = sqrt( mue_2 / c_eps_2 );	% der 1. ganz NAIVE Versuch ! Ist in Wahrheit NICHT TEM

%  AENDERN in 'Frequenz-relative' Werte :
%k_20 = om * sqrt( mue_2 * eps_2 );	%   ALT   exakt
k_20 = om_ref * sqrt( mue_2 * eps_2 );	% verlustloser Anteil ;  bei om_ref
k_20_q = k_20^2;
%p_20 = om * mue_2 * kap_2;	    % ALT Verlust-Anteil == negativer Im-Teil
p_20_ref = om_ref * mue_2 * kap_2;	% Verlust-Anteil == negativer Im-Teil ; bei om_ref
p_20 = p_20_ref / scl_om;     % Frequenz-relativ
p_25 = 0.5 * p_20;              % für Formeln bequemer !
h3 = k_20_q;    h4 = p_20;
h1 = sprintf('%12.5e', h3);
h2 = sprintf('%12.5e', h4);
disp('  ACHTUNG, Frequenz-relative Werte :');
disp([' k_2_komplex^2  =  k_20^2 - J * p_20   =   ', h1, ' - J * ', h2]);


%                  für Medium 3 :

eps_3 = eps_r3 * eps_0;		mue_3 = mue_r3 * mue_0;
k_30 = om_ref * sqrt( mue_3 * eps_3 );
k_30_q = k_30^2;
p_30_ref = om_ref * mue_3 * kap_3;
p_30 = p_30_ref / scl_om;     % Frequenz-relativ
p_35 = 0.5 * p_30; 

c_eps_3 = complex( eps_3, (-kap_3/om) );

Z_W_3 = sqrt( mue_3 / c_eps_3 );	% der 1. ganz NAIVE Versuch ! Ist in Wahrheit NICHT TEM

h1 = sprintf('%12.5e', k_30_q);
h2 = sprintf('%12.5e', p_30);
disp('  ACHTUNG, Frequenz-relative Werte :');
disp([' k_3_komplex^2  =  k_30^2 - J * p_30   =   ', h1, ' - J * ', h2]);


%  für die zweite Skalierung :
h1 = 0.5 * k_20_q;
k_R_t12_SI = sqrt( h1 + sqrt( h1^2 + p_25^2 ) );
lamb_t12_SI = 2. * pi / ( scl_om * k_R_t12_SI );
%
%   Rolf, 19.Nov.17 um Medium 3 ergänzt :
h1 = 0.5 * k_30_q;
k_R_t23_SI = sqrt( h1 + sqrt( h1^2 + p_35^2 ) );
lamb_t23_SI = 2. * pi / ( scl_om * k_R_t23_SI );
%
scl_lam_1 = lamb_e12_SI / lamb_0;
scl_lam_2 = lamb_t12_SI / lamb_0;
scl_lam_3 = lamb_t23_SI / lamb_0;
h3 = scl_lam_1;
h4 = scl_lam_2;
h5 = scl_lam_3;
h1 = sprintf('%12.5e', h3);
h2 = sprintf('%12.5e', h4);
h6 = sprintf('%12.5e', h5);
disp(['scl_lam_1 = ', h1, '   ;   scl_lam_2 = ', h2, '   ;   scl_lam_3 = ', h6]);
%
scl_lam_123 = 1.;
%          Code noch FRAGWÜRDIG, daher VORLÄUFIG :
%  Anmerkung 23.Aug. 2017 : funktioniert so, aber Medium 3 wird bei dieser
%                           Methode ignoriert ! Dort also < 4 Wellen MÖGLICH
% 13.Oct. 2018 : Versuch 1 MIT Medium 3 
    if( auto_scl_lam)
        if( ( scl_lam_1 < scl_lam_2 ) && ( scl_lam_2 < .999 ) )
            disp('  FALL  scl_lam_1  <  scl_lam_2  <  1  !   Korrektur !');
            scl_lam_123 = scl_lam_2;
        elseif( ( scl_lam_2 < scl_lam_1 ) && ( scl_lam_1 < .999 ) )
            disp('  FALL  scl_lam_2  <  scl_lam_1  <  1  !   Korrektur !');
            scl_lam_123 = scl_lam_1;
        endif
% 11.11. 2017 : HIER MUSS DIE ERGÄNZUNG UM MEDIUM #3 HIN !
% 13.Oct.2018 : incl. Medium 3 :
%  wäre wohl falsch herum ? :
%        if( ( scl_lam_3 < scl_lam_123 ) && ( scl_lam_3 < .999 ) )
%            disp('  FALL  scl_lam_3  <  scl_lam_123  <  1  !   Korrektur !');
%
        if( ( scl_lam_123 < scl_lam_3 ) && ( scl_lam_3 < .999 ) )
            disp('  FALL  scl_lam_123  <  scl_lam_3  <  1  !   Korrektur !');
            scl_lam_123 = scl_lam_3;
        endif
    endif


%              Für Sheets # 2 und 3  =  REFLEKTIERTE und TRANSMITTIERTE Welle :

%      Anfangs-Phasen-Versatz beider Wellen durch Laufzeit der einfallenden :
%
% 11.11. 2017 : hiernach wird scl_lam_123 BENUTZT, muss also vorher fertig berechnet sein !
%   (evtl. incl. Medium #3)
%
%   ALT :   Dies war ABSOLUT korrekt, ohne 'Frequenz-relativ' o. ae. :
%phi_0_s = phi_0_e - k_R_e12 * lamb_0 * s_len;	%  in "rad"
% NEU, 31. Aug. '14 , wieder absolut :
phi_0_s = phi_0_e - scl_om * k_R_e12 * lamb_0 * scl_lam_123 * s_len;  %  in "rad"
%
h = 2. * pi;
    while( phi_0_s < 0. )
        phi_0_s += h;
    endwhile
    while( phi_0_s > h )
        phi_0_s -= h;
    endwhile
h1 = sprintf('%12.5e', phi_0_s/radw);
%disp(['phi_0_s  in Grad = ', h1, '  = phi_0_e - k_R_e12 * lamb_0 * s_len']);
disp(['phi_0_s  in Grad = ', h1, ' = phi_0_e - k_R_e12_ECHT * lamb_0 * s_len  * scl_lam_123']);
%
dphi_0_s_H = - angle(Z_W_1);  %  in "rad" ; Anfangs-Phasen-Versatz H gegen E
%
% 11.11. 2017 :
h1 = layer2_width * lamb_t12_SI * scl_lam_123;
h2 = sprintf('%12.5e', h1);
disp(['ECHTE Dicke des Mediums #2 in Metern = ', h2, ' = layer2_width * lamb_t12_SI * scl_lam_123']);
disp('Falls man die Schichtdicken-Anpassung NICHT wünscht, darf man auto_scl_lam nicht setzen !');
%
%}

%sheet_mode = 1;       # NORMAL auf E
sheet_mode = 2;       # TANGENTIAL an E

sheet_mode_H = 1;       # NORMAL auf H
%sheet_mode_H = 2;       # TANGENTIAL an H

E_visible = True;          # on

E_extra_fig = True;        # yes


% die Grenzflächen als Surface einzeichnen (verdecken dann dahinterliegende Wellen-Anteile) ? :
show_border_surf = False;



% die Schichtdicke und einen Maßstab einzeichnen (stören evtl. Wellen-Anteile) ? :
show_scale_and_width = True;


% die Wellen-Richtungs-Pfeile einzeichnen (stören evtl. Wellen-Anteile) ? :
show_direction_arrows = True;


% uralt, plottete ansonsten Farbbalken rechts ins Bild :
%  { war nur sinnvoll während der Paletten-Optimierung }
no_colorbar = True;

%
%static_plots = False;	%  soll per default mit hoher Framerate über viele Perioden DURCHLAUFEN
			%  ==> darf keine weiteren figures außer #1 erzeugen !
% 14. Nov. 18 André: Asukommentiert wegen argv()
%static_plots = True;	% bei Erreichen von alpha_e12 = 90 Grad EINMAL alle "static plots" erzeugen
			%  ==> Danach ist evtl. die Framerate im Eimer !
%
% 14. Nov. 18 André: Asukommentiert wegen argv()
%legend_flag = 2;        % ' legend (..., "location", "east" ) ' in allen static plots
%legend_flag = 1;        % ' legend (...) ' OHNE "location", "east" in allen static plots
%legend_flag = 0;        %  GANZ OHNE ' legend (...) ' in allen static plots


% für Octave :
%graphics_toolkit( 'gnuplot');        # grausig langsam, blinkend mit 6 FPS
graphics_toolkit( 'fltk');        # gut
%graphics_toolkit( 'qt');         # nur unter Windows ! Dann fast so gut wie fltk


COLORS_e = zeros(i_y, i_x);  COLORS_r = zeros(i_y, i_x);  COLORS_t = zeros(i_y, i_x);

hco1 = 25./39. - 1.01;


%H_plot = logical( logical( H_extra_fig) & logical( H_visible) );
E_plot = logical( logical( E_extra_fig) & logical( E_visible) );

figM = figure(1, 'position', [0   10   1800   980]);  %
%
%  Error ab Octave 4.0.0 :
%gui_mode("3d");		% älteres Octave : kein Error, aber hier wirkungslos !
% Rolf, 31.Okt.2017, schaltet korrekten 3D-Maus-Modus sofort ein :
pan( figM, "off");
zoom( figM, "on");
rotate3d( figM, "on");

  if( E_extra_fig)
    subplot(1, 2, 1);
    ax = axis([xG_Anf-0.01, 2.*xG_End+0.01, 2.*yG_Anf-0.01, yG_End+0.01, ...
               zG_Anf-0.01, zG_End+0.01]);
    %
    hax1 = gca();	% Handle fuer Subplot 1
    #
    % 24. Jun. 2017 : x- und y-Richtungen UNVERZERRT :
    set( hax1, "DataAspectRatio", [10. 10. 1.]);
    set( hax1, "DataAspectRatioMode", "manual");    % bedeutet FIXIERT ! NICHT 'manuell verstellbar' !
    %
    set(gca, 'fontsize', 14);
    title('TM ;  E parallel');
    set(gca, 'fontsize', 12);
    xlabel('globales x');
    % ylabel senkrecht schreiben : ! ?
    %set(gca,'fontangle', '20');
    %set(gca,'tickdir', 90);
    ylabel('y');	zlabel('z');

    % geht in Octave auch ; VIEL BESSER FUER "3D-Rotation" mit Maus :
    %view(40., 30.);	% "3D-Standard"
    view(0.1, 75.);		% passt zu Python-Ansicht

    caxis([-1. 7.]);	% entscheidend für COLORMAP_Rolf_1
    %[COLORMAP_Rolf_1, COLORS_bo0, dhco1] = Colors_1(i_phi);    % gibt HIER dauernd Absturz !?
    [COLORMAP_Rolf_1, COLORS_bo0, dhco1] = Colors_2(i_phi);	% geht hier nur per csvread !
    colormap(COLORMAP_Rolf_1);
    hco1 += dhco1;
    COLORS_bo = COLORS_bo0 .+ hco1;

    % neu 24.Jul.2016 : Border Sheets nur EINMAL generieren :
        if( E_visible)
            %subplot(1, 2, 1);
            if( show_border_surf)
                % Kanten OHNE 'dunkle Extra-Farben' : alpha=0.'
                Rframeb = surface( XBO, YBO, ZBO, COLORS_bo, ...
                                   "edgealpha", bo_edgealpha );
                Rframeb2 = surface( XBO2, YBO2, ZBO, COLORS_bo, ...
                                    "edgealpha", bo_edgealpha );
                %
                hidden('on');
            else
                Rframeb = surface( XBO, YBO, ZBO, COLORS_bo, ...
                                   "facecolor", "w", "edgecolor", "flat", "linewidth", 1.01);
                Rframeb2 = surface( XBO2, YBO2, ZBO, COLORS_bo, ...
                                    "facecolor", "w", "edgecolor", "flat", "linewidth", 1.01);
                %
                hidden('off');
            endif
          set(Rframeb, 'visible', 'on');  set(Rframeb2, 'visible', 'on');
        endif

    hold on;
  endif


subplot(1, 2, 2);

%  clipping='on' / 'off'
%  doublebuffer='on' / 'off'

%     Achsen und Skalierung :

ax = axis([xG_Anf-0.01, 2.*xG_End+0.01, 2.*yG_Anf-0.01, yG_End+0.01, zG_Anf-0.01, zG_End+0.01]);
%
hax2 = gca();	% handle für Subplot 2
%hg2 = hggroup( hax2);  % nicht benötigt
#
set( hax2, "DataAspectRatio", [10. 10. 1.]);
set( hax2, "DataAspectRatioMode", "manual");    % bedeutet FIXIERT ! NICHT 'manuell verstellbar' !
%
set(gca, 'fontsize', 14);
title('TM ;  H senkrecht');
set(gca, 'fontsize', 12);
xlabel('globales x');
ylabel('y');
% zlabel senkrecht schreiben : ! ?
%set(gca,'fontangle', '20');
%set(gca,'tickdir', 90);
zlabel('z');

% geht in Octave auch ; VIEL BESSER FUER "3D-Rotation" mit Maus :
%view(40., 30.);	% "3D-Standard"
view(0.1, 75.);		% passt zu Python-Ansicht

caxis([-1. 7.]);	% entscheidend fuer COLORMAP_Rolf_1
%
%[COLORMAP_Rolf_1, COLORS_bo0, dhco1] = Colors_1(i_phi);        % gibt HIER dauernd Absturz !?
[COLORMAP_Rolf_1, COLORS_bo0, dhco1] = Colors_2(i_phi);		% geht hier nur per csvread !
colormap(COLORMAP_Rolf_1);
hco1 = 25./39. - 1.01 + dhco1;
COLORS_bo = COLORS_bo0 .+ hco1;

    % neu 24.Jul.2016 : Border Sheets nur EINMAL generieren :
    if( show_border_surf)
        % Kanten OHNE 'dunkle Extra-Farben' : alpha=0.'
        RframebH = surface( XBO, YBO, ZBO, COLORS_bo, ...
                            "edgealpha", bo_edgealpha);
        RframebH2 = surface( XBO2, YBO2, ZBO, COLORS_bo, ...
                             "edgealpha", bo_edgealpha);
        %
        hidden('on');
    else
        RframebH = surface( XBO, YBO, ZBO, COLORS_bo, ...
                            "facecolor", "w", "edgecolor", "flat", "linewidth", 1.01);
        RframebH2 = surface( XBO2, YBO2, ZBO, COLORS_bo, ...
                             "facecolor", "w", "edgecolor", "flat", "linewidth", 1.01);
        %
        hidden('off');
    endif
set(RframebH, 'visible', 'on');  set(RframebH2, 'visible', 'on');

hold on;



% 19. Okt.2018 , Rolf , echte Schicht-Dicke in m :
%D_echt = layer2_width * scl_lam_123;
%
%
% Rolf ab 27.Sep. 2018 ;    3D-LINIEN und -Texte ins Bild :
%    a) SCHICHT-DICKE  :   IM 3D-Subplot weit links vertikale Linie (mit Pfeilen) zwischen Borders
%    b) Maßstab        :   IM 3D-Subplot z.B. unterhalb der x-Achse horizontale  Linie (mit Pfeilen) 
%
% beide in Subplot 1 besser aufgehoben bei TM !  (stören weniger)
%
% 28. Okt.2018 , Rolf ; bei TM Schicht-Pfeil und Maßstab besser im linken E-Subplot :
    if( (E_extra_fig) && (E_visible) )
        subplot(1, 2, 1);
    endif

%ax = axis([xG_Anf-0.01, 2.*xG_End+0.01, 2.*yG_Anf-0.01, yG_End+0.01, zG_Anf-0.01, zG_End+0.01]);
%
%
%    a) SCHICHT-DICKE  :   IM 3D-Subplot weit links vertikale Linie (mit Pfeilen) zwischen Borders
%
h1 = 2. * xG_End - xG_Anf +0.02;
h2 = yG_off_B2;
h3 = 0.015 * h1;
h4 = 1.3 * h3;
%
x_SCH_h1 = xG_Anf + 0.15 * h1;      y_SCH_h1 = h2;          z_SCH_h1 = zG_Anf + 0.15 * (zG_End - zG_Anf);
x_SCH_h2 = x_SCH_h1;                y_SCH_h2 = 0.;          z_SCH_h2 = z_SCH_h1;
%
line( [x_SCH_h1, x_SCH_h2], [y_SCH_h1, y_SCH_h2], [z_SCH_h1, z_SCH_h2], ...
                                         "linewidth", 2.0, "color", 'r');
%
line( [x_SCH_h1, x_SCH_h1 + h3], [y_SCH_h1, y_SCH_h1 + h4], [z_SCH_h1, z_SCH_h1], ...
                                         "linewidth", 2.0, "color", 'r');
line( [x_SCH_h1, x_SCH_h1 - h3], [y_SCH_h1, y_SCH_h1 + h4], [z_SCH_h1, z_SCH_h1], ...
                                         "linewidth", 2.0, "color", 'r');
%
line( [x_SCH_h2, x_SCH_h2 + h3], [y_SCH_h2, y_SCH_h2 - h4], [z_SCH_h2, z_SCH_h2], ...
                                         "linewidth", 2.0, "color", 'r');
%
line( [x_SCH_h2, x_SCH_h2 - h3], [y_SCH_h2, y_SCH_h2 - h4], [z_SCH_h2, z_SCH_h2], ...
                                         "linewidth", 2.0, "color", 'r');
%


%text( x_SCH_h1 - .05*h1, y_SCH_h1 + 0.05*h1, z_SCH_h1, "D", ...
%      "color", "r", "fontsize", 16 );
text( x_SCH_h1 - .05*h1, y_SCH_h1 - 0.45*h2, z_SCH_h1, "D", ...
      "color", "r", "fontsize", 16 );
%
%  28.Okt.2018 für TM verschobene Positionen :
%annot_10 = annotation( figM, "textbox", [0.1  0.02  0.4  0.03]);
annot_10 = annotation( figM, "textbox", [0.6  0.02  0.4  0.03]);
%
%set( annot_10, 'fontsize', 14, 'fontweight', 'bold', "textrotation", 90.);  % textrotation unbekannt
set( annot_10, 'fontsize', 14, 'fontweight', 'bold');
set( annot_10, 'horizontalalignment', 'left', 'verticalalignment', 'middle');
%
%{     Achtung ! Spätestens bei variabler Frequenz DYNAMISCHER UPDATE nötig ! (weiter unten) :
%h4 = [" Schichtdicke D als \"Explosionszeichnung\" übertrieben !    ECHTES D = " ...
%      sprintf('%11.4e', D_echt) " m "];
set( annot_10, "string", h4);
%}


%    b) Maßstab        :   IM 3D-Subplot z.B. unterhalb der x-Achse horizontale  Linie (mit Pfeilen) 
%
%             NOCH EXPERIMENTELL  !!
%
%     Achtung ! Spätestens bei variabler Frequenz DYNAMISCHER UPDATE nötig ! (weiter unten) :
%{
h1 = 2.*xG_End - xG_Anf;       h2 = yG_End - 2.*yG_Anf;       h3 = zG_End - zG_Anf;
D_h = layer2_width * scl_lam_123;
%
%    Versuch 1 :   FALSCHE LÄNGEN
%D_h2 = h1; 
%    Versuch 2 :
D_h2 = D_h; 
%
%
    if(D_h2 >= 1.e+04)
        h5 = 300;     h7 = 1.e+03;    h6 = "e+03m";
    elseif(D_h2 >= 3.e+03)
        h5 = 100;     h7 = 1.e+03;    h6 = "e+03m";
    elseif(D_h2 >= 1.e+03)
        h5 = 300;     h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 300.)
        h5 = 100;     h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 100.)
        h5 = 30;      h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 30.)
        h5 = 10;      h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 10.)
        h5 = 3;       h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 3.0)
        h5 = 1;       h7 = 1.;        h6 = "m";
    elseif(D_h2 >= 1.0)
         h5 = 300;    h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 0.3)
         h5 = 100;    h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 1.e-01)
         h5 = 30;     h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 3.e-02)
         h5 = 10;     h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 1.e-02)
         h5 = 3;      h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 3.e-03)
         h5 = 1;      h7 = 1.e-03;    h6 = "e-03 m";
    elseif(D_h2 >= 1.e-03)
         h5 = 300;    h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 3.e-04)
         h5 = 100;    h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 1.e-04)
         h5 = 30;     h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 3.e-05)
         h5 = 10;     h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 1.e-05)
         h5 = 3;      h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 3.e-06)
         h5 = 1;      h7 = 1.e-06;    h6 = "e-06 m";
    elseif(D_h2 >= 1.e-06)
         h5 = 300;    h7 = 1.e-09;    h6 = "e-09 m";
    elseif(D_h2 >= 3.e-07)
         h5 = 100;    h7 = 1.e-09;    h6 = "e-09 m";
    elseif(D_h2 >= 1.e-07)
         h5 = 30;     h7 = 1.e-09;    h6 = "e-09 m";
    elseif(D_h2 >= 3.e-08)
         h5 = 10;     h7 = 1.e-09;    h6 = "e-09 m";
    elseif(D_h2 >= 1.e-08)
         h5 = 3;      h7 = 1.e-09;    h6 = "e-09 m";
    elseif(D_h2 >= 3.e-09)
         h5 = 1;      h7 = 1.e-09;    h6 = "e-09 m";
    else
%    elseif(D_h2 >= 0.1)
%         h5 = 300;    h7 = 1.e-06;    h6 = "e-06 m";
%    else
%        ...........
    endif
%}

%
%Text_Mass = [ sprintf('%1d', h5) h6];
%
%    die eigentliche Berechnung der Linienlänge :
%
% 19. Oct.  2018 :  - Länge Maßstab korrigiert : Versuch 3     NOCH FEHLER ?
%h8 = (h5 * h7) * sheet_length / D_echt :
%h8 = (h5 * h7) * s_len / D_echt;
%
%  13.Okt.2018   Versuch 1 (rechts oben) :
%x_M_h1 = 2.*xG_End - h8;    y_M_h1 = yG_End - 0.05 * h2;    z_M_h1 = zG_End - 0.07 * h3;
%x_M_h2 = x_M_h1 + h8;       y_M_h2 = y_M_h1;                z_M_h2 = z_M_h1;
%  19.Okt.2018   Versuch 2 (links unten) :
%x_M_h1 = xG_Anf + 0.10 * h1;    y_M_h1 = 2. * yG_Anf + 0.08 * h2;    z_M_h1 = zG_Anf + 0.07 * h3;
%x_M_h2 = x_M_h1;       y_M_h2 = y_M_h1 + h8;                z_M_h2 = z_M_h1;
%
%{
%  13.Okt.2018   Versuch 1 (in x-Richtung ) :
mli_1 = line( [x_M_h1, x_M_h2], [y_M_h1, y_M_h2], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%
mli_2 = line( [x_M_h1, x_M_h1], [y_M_h1, y_M_h1 + 0.02*h2], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%
mli_3 = line( [x_M_h2, x_M_h2], [y_M_h1, y_M_h1 + 0.02*h2], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%
%  19.Okt.2018   Versuch 2 (in y-Richtung ) :
mli_1 = line( [x_M_h1, x_M_h2], [y_M_h1, y_M_h2], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%
mli_2 = line( [x_M_h1, x_M_h1 + 0.02*h1], [y_M_h1, y_M_h1], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%
mli_3 = line( [x_M_h2, x_M_h2 + 0.02*h1], [y_M_h2, y_M_h2], [z_M_h1, z_M_h2], ...
                "linewidth", 2.0, "color", 'r');
%}
% 07. Feb. 2019		Lines vorab definieren für set():
mli_1 = line( [0, 0], [0, 0], [0, 0], ...
                "linewidth", 2.0, "color", 'r');
%
mli_2 = line( [0, 0], [0, 0], [0, 0], ...
                "linewidth", 2.0, "color", 'r');
%
mli_3 = line( [0, 0], [0, 0], [0, 0], ...
                "linewidth", 2.0, "color", 'r');
%
%
%        falls mit annotation() :
%annot_M = annotation( figM, "textbox", [0.38  0.82  0.1  0.03]);
%set( annot_M, 'fontsize', 16, 'fontweight', 'bold', ...
%              'horizontalalignment', 'left', 'verticalalignment', 'middle');
%
%         falls mit text() :
%  13.Okt.2018   Versuch 1 (rechts oben) :
%x_M_h3 = x_M_h1 + .45 * h8;
%y_M_h3 = y_M_h1 - 0.05 * h2;
%hText_Mass = text( x_M_h1 + .45 * h8, y_M_h1 - 0.05 * h2, z_M_h1, Text_Mass, ...
%                   "color", "r", "fontsize", 16 );
%
%{
%  19.Okt.2018   Versuch 2 (links unten, ganz gut) :
x_M_h3 = x_M_h1 + 0.04 * h1;
y_M_h3 = y_M_h1 + .45 * h8;
hText_Mass = text( x_M_h3, y_M_h3, z_M_h1, Text_Mass, ...
                   "color", "r", "fontsize", 16 );
%}
%
%             SPÄTER dynamisch :
%
%        falls mit annotation() :
%set( annot_M, "position", [x2D_M_1   x2D_M_2  y2D_M_1  y2D_M_2], ...
%              "string", Text_Mass );
%
%         falls mit text() :
%set( hText_Mass, "string", Text_Mass );

% 07. Feb. 2019 DYNAMISCH:
hText_Mass = text( 0, 0, 0, "init", ...
                   "color", "r", "fontsize", 16 );

% 28. Okt.2018 , Rolf ; bei TM auf jeden Fall zurück zum rechten H-Subplot :
subplot(1, 2, 2);




%
% Rolf 25.Sep.2018 ;    fest im Plot stehende 2D-TEXTE ; auch dynamische Updates :
%
%   GESAMT : figM = figure(1, 'position', [0   10   1800   980]);  %
%

%     1.) Gesamt-Titel " Reflexion und Brechung ..."  :
annotation( figM, "textbox", [0.34  0.96  0.32  0.03], ...
           'fontsize', 18, 'fontweight', 'bold', 'fitboxtotext', 'off', ...
           'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
           "string", " Reflexion und Brechung   ;   Medien 1, 2 und 3 mit Verlusten " );

%     2.) aktuelle Frequenz :
annot_2 = annotation( figM, "textbox", [0.005  0.96  0.13  0.03], ...
                      'fontsize', 16, 'fontweight', 'bold', ...
                      'horizontalalignment', 'left', 'verticalalignment', 'middle' );                      
if(freq_inc_flag)
	h2 = [" Frequenz = " sprintf('%12.5e', f_start) " Hz "];
else
	h2 = [" Frequenz = " sprintf('%12.5e', freq) " Hz "];
endif
set( annot_2, "string", h2);

%     3.) aktueller Einfallswinkel :
annot_3 = annotation( figM, "textbox", [0.005 0.925  0.14  0.03]);        % links oben, unter Frequenz
set( annot_3, 'horizontalalignment', 'left', 'verticalalignment', 'middle');
set( annot_3, 'fontsize', 16, 'fontweight', 'bold');
h2 = [" Einfallswinkel = " sprintf('%9.3f', alpha_e12/radw) " Grad "];
set( annot_3, "string", h2);

%     4.) aktuelle Berechnungs-Framerate :
%annot_4 = annotation( figM, "textbox", [0.01  0.01  0.1  0.03]);   % links unten
%annot_4 = annotation( figM, "textbox", [0.91  0.94  0.07  0.03]);    % rechts oben
annot_4 = annotation( figM, "textbox", [0.91  0.94  0.07  0.03], ...
                      'fontsize', 16, 'fontweight', 'bold', ...
                      'horizontalalignment', 'left', 'verticalalignment', 'middle', ...
                      "string", " FPS :  0.00 1/s " );
FPS_str = ' FPS : 0.0';

%     5.) eps_r-1 , mü_r,1 und kappa_1 :
%
% 10.Okt.2018 mit Tex :
annot_5 = annotation( figM, "textbox", [0.004  0.68  0.084  0.12] );
set( annot_5, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
%
set( annot_5, 'fontsize', 12, 'fontweight', 'normal', 'interpreter', 'tex');
%
%                VERSUCHE MIT Tex :
%{
% Versuch 1  ,  geht NICHT, ganzes Bild UNSICHTBAR ??? :
set( annot_5, 'string', [
              [' \epsilon_{ r,1} = ' sprintf('%9.3f', eps_r1) ' ']; ...
              ' '; ...
              [' \mu_{ r,1} = ' sprintf('%9.3f', mue_r1) ' ']; ...
              ' '; ...
              [' \kappa_{ 1} = ' sprintf('%11.4e', kap_1) ' Ohm*m ']  ]);
%}
%           Versuch 2  ,  OK :
if(freq_inc_flag)
	h2 = [ sprintf('%9.3f', eps_r1_array(1)) ' '];
	h3 = [ sprintf('%9.3f', mue_r1_array(1)) ' '];
	h4 = [ sprintf('%11.4e', kap_1_array(1)) ' Ohm*m '];
else
	h2 = [ sprintf('%9.3f', eps_r1) ' '];
	h3 = [ sprintf('%9.3f', mue_r1) ' '];
	h4 = [ sprintf('%11.4e', kap_1) ' Ohm*m '];
endif
%
set( annot_5, 'string', [ 
              [' \epsilon_{ r,1} = ' h2 ]; ...
              ' '; ...
              [' \mu_{ r,1} = ' h3 ]; ...
              ' '; ...
              [' \kappa_{ 1} = ' h4 ];...
               ' ' ] );

%     6.) eps_r-2 , mü_r,2 und kappa_2 :
annot_6 = annotation( figM, "textbox", [0.004  0.46  0.084  0.12]);
set( annot_6, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
set( annot_6, 'fontsize', 12, 'fontweight', 'normal', 'interpreter', 'tex');
%
if(freq_inc_flag)
	h2 = [ sprintf('%9.3f', eps_r2_array(1)) ' '];
	h3 = [ sprintf('%9.3f', mue_r2_array(1)) ' '];
	h4 = [ sprintf('%11.4e', kap_2_array(1)) ' Ohm*m '];
else
	h2 = [ sprintf('%9.3f', eps_r2) ' '];
	h3 = [ sprintf('%9.3f', mue_r2) ' '];
	h4 = [ sprintf('%11.4e', kap_2) ' Ohm*m '];
endif
%
set( annot_6, 'string', [ 
              [' \epsilon_{ r,2} = ' h2 ]; ...
              ' '; ...
              [' \mu_{ r,2} = ' h3 ]; ...
              ' '; ...
              [' \kappa_{ 2} = ' h4 ];...
               ' '  ] );

%     7.) eps_r-3 , mü_r,3 und kappa_3 :
annot_7 = annotation( figM, "textbox", [0.004  0.24  0.084  0.12]);
set( annot_7, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
set( annot_7, 'fontsize', 12, 'fontweight', 'normal', 'interpreter', 'tex');
%
if(freq_inc_flag)
	h2 = [ sprintf('%9.3f', eps_r3_array(1)) ' '];
	h3 = [ sprintf('%9.3f', mue_r3_array(1)) ' '];
	h4 = [ sprintf('%11.4e', kap_3_array(1)) ' Ohm*m '];
else
	h2 = [ sprintf('%9.3f', eps_r3) ' '];
	h3 = [ sprintf('%9.3f', mue_r3) ' '];
	h4 = [ sprintf('%11.4e', kap_3) ' Ohm*m '];
endif
%
set( annot_7, 'string', [ 
              [' \epsilon_{ r,3} = ' h2 ]; ...
              ' '; ...
              [' \mu_{ r,3} = ' h3 ]; ...
              ' '; ...
              [' \kappa_{ 3} = ' h4 ];...
               ' '  ] );

%     8.) alle Winkel an Border # 1 :
%  28.Okt.2018 für TM verschobene Positionen :
%annotation( figM, "textbox", [0.56  0.053  0.11  0.07],...
annotation( figM, "textbox", [0.06  0.053  0.11  0.07],...
           'fontsize', 14, 'fontweight', 'bold', ...
           'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
           "string", [" Winkel an Grenze 1 "; "   in Grad : "] );
% annot_8 variabel für später :
%    mit Tex :
%  28.Okt.2018 für TM verschobene Positionen :
%annot_8 = annotation( figM, "textbox", [0.645  0.008  0.1  0.16]);
annot_8 = annotation( figM, "textbox", [0.145  0.008  0.1  0.16]);
set( annot_8, 'fontsize', 12, 'fontweight', 'normal', 'interpreter', 'tex');
%set( annot_8, 'horizontalalignment', 'center', 'verticalalignment', 'middle');
set( annot_8, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
% set annot_8 variabel erst später !

%     9.) alle Winkel an Border # 2 :
%  28.Okt.2018 für TM verschobene Positionen :
%annotation( figM, "textbox", [0.79  0.053  0.11  0.07],...
annotation( figM, "textbox", [0.29  0.053  0.11  0.07],...
           'fontsize', 14, 'fontweight', 'bold', ...
           'horizontalalignment', 'center', 'verticalalignment', 'middle', ...
           "string", [" Winkel an Grenze 2 "; "   in Grad : "] );
%     annot_9 variabel für später :
%  28.Okt.2018 fuer TM verschobene Positionen :
%annot_9 = annotation( figM, "textbox", [0.875  0.008  0.1  0.16]);
annot_9 = annotation( figM, "textbox", [0.375  0.008  0.1  0.16]);
set( annot_9, 'fontsize', 12, 'fontweight', 'normal', 'interpreter', 'tex');
%set( annot_9, 'horizontalalignment', 'center', 'verticalalignment', 'middle');     % Octave ab 4.2.2
set( annot_9, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
% set annot_9 variabel erst später !



%  sinnvoll nur WÄHREND der Gestaltung der obigen Texte
%fflush( stdin);
%disp("PAUSE  !!!     WEITER MIT TASTE ...");
%pause();




% VORAB Definitionen möglichst ALLER Matrizen :
%
ZE_0 = zeros(i_y, i_x, 'double');
YS_t = zeros(i_y, i_x, 'double');
YS_r2 = zeros(i_y, i_x, 'double');
YS_t2 = zeros(i_y, i_x, 'double');
A1_e12_exp = zeros(i_y, i_x, 'double');	A2_e12_cos = zeros(i_y, i_x, 'double');
A1_r12_exp = zeros(i_y, i_x, 'double');	A2_r12_cos = zeros(i_y, i_x, 'double');
A1_t12_exp = zeros(i_y, i_x, 'double');	A2_t12_cos = zeros(i_y, i_x, 'double');
% Rolf, 19.Nov.2017 , fehlten :
A1_r23_exp = zeros(i_y, i_x, 'double');	A2_r23_cos = zeros(i_y, i_x, 'double');
A1_t23_exp = zeros(i_y, i_x, 'double');	A2_t23_cos = zeros(i_y, i_x, 'double');
% 19.Nov.2017 ; sollte damit schneller werden ! :
xs_h = zeros(i_y, i_x, 'double');	ys_tr_h = zeros(i_y, i_x, 'double');
%
%
% für HSN :
%    3 grosse 3D-arrays mit ALLEN Werten;
%    nur im 1. Durchlauf BERECHNEN, bei Wiederholungen nur PLOTTEN
%
ZH_e_ges = zeros(i_phi, i_y, i_x, 'double');
ZH_r_ges = zeros(i_phi, i_y, i_x, 'double');
ZH_t_ges = zeros(i_phi, i_y, i_x, 'double');
% 20. Mai 2017 ; FEHLTEN bisher :
ZH_r2_ges = zeros(i_phi, i_y, i_x, 'double');
ZH_t2_ges = zeros(i_phi, i_y, i_x, 'double');
%
% % 7 kleine weitere :
HGT = zeros(i_x, i_y, 'double');  % Index-Reihenfolge beachten !
XG_e = zeros(i_y, i_x, 'double');		YG_e = zeros(i_y, i_x, 'double');
XG_r = zeros(i_y, i_x, 'double');		YG_r = zeros(i_y, i_x, 'double');
XG_t = zeros(i_y, i_x, 'double');		YG_t = zeros(i_y, i_x, 'double');
% 01. Jan 2015 ; FEHLTEN bisher immer ! :
ZH_e = zeros(i_y, i_x, 'double');	ZH_r = zeros(i_y, i_x, 'double');
ZH_t = zeros(i_y, i_x, 'double');
% 20. Mai 2017 ; FEHLTEN bisher :
XG_r2 = zeros(i_y, i_x, 'double');		YG_r2 = zeros(i_y, i_x, 'double');
XG_t2 = zeros(i_y, i_x, 'double');		YG_t2 = zeros(i_y, i_x, 'double');
%
%
% für EPT :
%    6 grosse 3D-arrays mit ALLEN Werten;
%    nur im 1. Durchlauf BERECHNEN, bei Wiederholungen nur PLOTTEN
%
XP_e_ges = zeros(i_phi, i_y, i_x, 'double');
YP_e_ges = zeros(i_phi, i_y, i_x, 'double');
XP_r_ges = zeros(i_phi, i_y, i_x, 'double');
YP_r_ges = zeros(i_phi, i_y, i_x, 'double');
XP_t_ges = zeros(i_phi, i_y, i_x, 'double');
YP_t_ges = zeros(i_phi, i_y, i_x, 'double');
% neu 22. Apr. 2017 für die zweite Reflektierte und Transmittierte :
XP_r2_ges = zeros(i_phi, i_y, i_x, 'double');
YP_r2_ges = zeros(i_phi, i_y, i_x, 'double');
XP_t2_ges = zeros(i_phi, i_y, i_x, 'double');
YP_t2_ges = zeros(i_phi, i_y, i_x, 'double');

% 10 kleine :
XP_e = zeros(i_y, i_x, 'double');  YP_e = zeros(i_y, i_x, 'double');  ZP_e = zeros(i_y, i_x, 'double');
XP_r = zeros(i_y, i_x, 'double');  YP_r = zeros(i_y, i_x, 'double');  ZP_r = zeros(i_y, i_x, 'double');
XP_t = zeros(i_y, i_x, 'double');  YP_t = zeros(i_y, i_x, 'double');
ZP_tr_t = zeros(i_y, i_x, 'double');    ZP_lo_t = zeros(i_y, i_x, 'double');
%
% 7 kleine weitere NEUE NAMEN , oben schon bei HSN ?
HGTE = zeros(i_x, i_y, 'double');  % Index-Reihenfolge beachten !
XGE_e = zeros(i_y, i_x, 'double');		YGE_e = zeros(i_y, i_x, 'double');
XGE_r = zeros(i_y, i_x, 'double');		YGE_r = zeros(i_y, i_x, 'double');
XGE_t = zeros(i_y, i_x, 'double');		YGE_t = zeros(i_y, i_x, 'double');
%
%
%  2 neue Matrizen xs_h und ys_tr_h EINMAL vorab :
xs_h = repmat( xs, i_y, 1);      ys_tr_h = repmat( ys', 1, i_x);

%{
k_R_e12_sc = scl_lam_123 * k_R_e12;		k_I_e12_sc = scl_lam_123 * k_I_e12;
k_R_r12_sc = scl_lam_123 * k_R_r12;		k_I_r12_sc = scl_lam_123 * k_I_r12;


%            ZE_e = Amp_e .* exp( k_I_e12_sc .* XS) .* cos(phi_e .- k_R_e12_sc .* XS);
A1_e12_exp = exp( k_I_e12_sc .* XS);	A2_e12_cos = k_R_e12_sc .* XS;
A1_r12_exp = exp( k_I_r12_sc .* XS);	A2_r12_cos = k_R_r12_sc .* XS;
%}

upd_BSe = True;		upd_BSr = True;		upd_BSt = True;
upd_ZHe = True;		upd_ZHr = True;		upd_ZHt = True;
freq_eq = True;

% 14. Nov. 18 André: Asukommentiert wegen argv()
%view_mode = 1;       % "mesh" = Wireframes i_x X i_y
%view_mode = 2;       % Surfaces

generate_Pictures = 0;	% 0 = off    1 = on, automatisch     2 = Einzelbild

first_Period = True;	compute_Sheets = True;
N_periods = N_periods_2 = 0;
FPS_Max = FPS_Avg = FPS = 0.;
FPS_Max_2 = FPS_Avg_2 = 0.;
FPS_Min = FPS_Min_2 = 1000;

Rframee = False;    Rframer = False;	Rframet = False;
Rframer2 = False;	Rframet2 = False;
%Rframeb = False;


%	!!!!!!!!	Beginn der 'Dauer-Viewing-Loop'		 !!!!!!!!

while( view_mode > 0)

	if(compute_Sheets)
		%{
		# Umrechnung der 3 Sheet-Koords in GLOBALE Koord-meshgrids :
		#             VOR der "for i"-loop ! :        
		#   ( nur bei ÄNDERUNGEN an Offsets/Winkel nötig )
		#    ==> DANN NUR xy-KOORDS aller 3 Sheets neu
		%}
		% Neu 06. Feb. 2019: Frequenz-Sweep####################################################################################################################
		while(freq_eq)
			% Daraus lambda_0  im Vakuum-Freiraum :
			lamb_0 = c0 / freq;

			% die Kreisfrequenz :
			om = 2. * pi * freq;    om_ref = 2. * pi * freq_ref;
			%
			scl_om = om / om_ref;
			
			if (! DEMO_or_TRUE_DATA) 
				[eps_r1, mue_r1, kap_1, eps_r2, mue_r2, kap_2, eps_r3, mue_r3, kap_3] = ...
				Properties_Media_1( freq, choice_mat, sub_case_str);
			endif
			
			if (freq_inc_flag)
				disp(["inc_var: ", num2str(i_inc_var)]);
				disp(["freq_inc_var: ", num2str(freq_inc_var)]);
				eps_r1 = eps_r1_array(freq_inc_var);
				mue_r1 = mue_r1_array(freq_inc_var);
				kap_1 = kap_1_array(freq_inc_var);
				eps_r2 = eps_r2_array(freq_inc_var);
				mue_r2 = mue_r2_array(freq_inc_var);
				kap_2 = kap_2_array(freq_inc_var);
				eps_r3 = eps_r3_array(freq_inc_var);
				mue_r3 = mue_r3_array(freq_inc_var); 
				kap_3 = kap_3_array(freq_inc_var); 
			endif
			
			%              Für Sheet # 1  =  EINFALLENDE Welle :

			eps_1 = eps_r1 * eps_0;		mue_1 = mue_r1 * mue_0;	
			%
			c_eps_1 = complex( eps_1, (-kap_1/om) );     % NICHT 'Frequenz-relativ'
			%
			Z_W_1 = sqrt( mue_1 / c_eps_1 );     % NICHT 'Frequenz-relativ'
			%
			%      Anfangs-Phase in "Grad * radw" :
			%   logisch einfachster Wert als Default :
			phi_0_e = 0. * radw;	% Default
			%
			%      Einfallswinkel in "Grad * radw" :
				if(alpha_inc_flag)
				   alpha_e12 += alpha_inc;
				else
				   %
				   %    bis zu "senkrechter Inzidenz" incl. :
				   %alpha_e12 = 0. * radw;
				   %14. Nov. 18 André Neu:
				   alpha_e12 = alpha_e_const * radw;
				   %alpha_e12 = 25. * radw;       % Default , WILLKÜRLICH
				   %alpha_e12 = 56.6020 * radw; % winzige Refl.,  Winkel (refl., gebr.) = 90°  Brewster ???
				   %    bis zu "streifendem Einfall" :
				   %alpha_e12 = 90. * radw;
				endif

			%      (Anfangs)-Amplitude  incl. 'Null-Phase', WILLKUERLICH :
			Amp_e = 0.8;
			%	für H , WILLKUERLICH :
			Amp_e_H = Amp_e;  	% nur ein 1. Versuch !     

			%      Wellenzahl komplex :
			[k_R_e12  k_I_e12] = k_Wave_cmpl_scalar(om, eps_1, mue_1, kap_1);
			%  ÄNDERN in 'Frequenz-relativ' :
			k_R_e12 /= scl_om;    k_I_e12 /= scl_om;
			%
			%
			%k_10 = om * sqrt( mue_1 * eps_1 );	%    ALT   exakt
			k_10 = om_ref * sqrt( mue_1 * eps_1 );	% verlustloser Anteil ; bei om_ref
			k_10_q = k_10^2;
			%p_10 = om * mue_1 * kap_1;	% Verlust-Anteil
			p_10_ref = om_ref * mue_1 * kap_1;	% Verlust-Anteil == negativer Im-Teil ; bei om_ref
			p_10 = p_10_ref / scl_om;      % 'Frequenz-relativ'
			p_15 = 0.5 * p_10;	% Hilfsvariable
			%
			h3 = k_10_q;    h4 = p_10;
			h1 = sprintf('%12.5e', h3);
			h2 = sprintf('%12.5e', h4);
			disp('   ACHTUNG, Fequenz-relative Werte :');
			disp([' k_1_komplex^2  =  k_10^2 - J * p_10   =   ', h1, ' - J * ', h2]);

			%      Wellenlänge (NICHT normiert) :
			%lamb_e = 2. * pi / k_R_e12; %   ALT   korrekt
			lamb_e = 2. * pi / ( scl_om * k_R_e12 );    % korrekt

			%  für die zweite Skalierung :
			h1 = 0.5 * k_10_q;
			k_R_e12_SI = sqrt( h1 + sqrt( h1^2 + p_15^2 ) );
			lamb_e12_SI = 2. * pi / ( scl_om * k_R_e12_SI );

			%      Dämpfung, d.h. endliche Leitfähigkeit, Absorption etc :
			%         exp( D_alpha * xx)  mit normierten xx
			%            ==>  Dämpfung ist ebenfalls 'normiert'
			%D_alpha_e12 = 0.0;         % ungedämpft
			%D_alpha_e12 = -k_I_e12;	  %    ALT   korrekt , einfallende simple Welle "Typ 1"
			D_alpha_e12 = -k_I_e12 * scl_om;  % korrekt , einfallende simple Welle "Typ 1" , NICHT 'Freq.-rel'
			%

			%              Für Sheet # 2  =  REFLEKTIERTE Welle :
			%
			%             "Reflexionsgesetze  für H_senkrecht" , Teil 1 :
			%
			%       Reflexionswinkel in "Grad * radw" :
			%%alpha_r12 = alpha_e12;        % korrekt,  Zählweisen u. VZ's beachten
			%
			%      Wellenlänge ( nicht normiert) :
			lamb_r = lamb_e;          % korrekt
			%
			%      Dämpfung Welle Typ 1:
			D_alpha_r12 = D_alpha_e12;    % korrekt
			%
			%      Wellenzahl komplex Welle Typ 1 :
			k_R_r12 = k_R_e12;	k_I_r12 = k_I_e12;	  % korrekt, reflektierte simple Welle "Typ 1"
			%
			%      (Anfangs)-Amplitude ; Phasendrehung incl. :
			%  korrekte Formeln fuer r12_paral und t12_paral Siehe weiter unten


			%              Für Sheet # 3  =  TRANSMITTIERTE Welle :

			eps_2 = eps_r2 * eps_0;		mue_2 = mue_r2 * mue_0;	
			%
			c_eps_2 = complex( eps_2, (-kap_2/om) );     % NICHT 'Frequenz-relativ' !
			%
			Z_W_2 = sqrt( mue_2 / c_eps_2 );	% der 1. ganz NAIVE Versuch ! Ist in Wahrheit NICHT TEM

			%  AENDERN in 'Frequenz-relative' Werte :
			%k_20 = om * sqrt( mue_2 * eps_2 );	%   ALT   exakt
			k_20 = om_ref * sqrt( mue_2 * eps_2 );	% verlustloser Anteil ;  bei om_ref
			k_20_q = k_20^2;
			%p_20 = om * mue_2 * kap_2;	    % ALT Verlust-Anteil == negativer Im-Teil
			p_20_ref = om_ref * mue_2 * kap_2;	% Verlust-Anteil == negativer Im-Teil ; bei om_ref
			p_20 = p_20_ref / scl_om;     % Frequenz-relativ
			p_25 = 0.5 * p_20;              % für Formeln bequemer !
			h3 = k_20_q;    h4 = p_20;
			h1 = sprintf('%12.5e', h3);
			h2 = sprintf('%12.5e', h4);
			disp('  ACHTUNG, Frequenz-relative Werte :');
			disp([' k_2_komplex^2  =  k_20^2 - J * p_20   =   ', h1, ' - J * ', h2]);


			%                  für Medium 3 :

			eps_3 = eps_r3 * eps_0;		mue_3 = mue_r3 * mue_0;
			k_30 = om_ref * sqrt( mue_3 * eps_3 );
			k_30_q = k_30^2;
			p_30_ref = om_ref * mue_3 * kap_3;
			p_30 = p_30_ref / scl_om;     % Frequenz-relativ
			p_35 = 0.5 * p_30; 

			c_eps_3 = complex( eps_3, (-kap_3/om) );

			Z_W_3 = sqrt( mue_3 / c_eps_3 );	% der 1. ganz NAIVE Versuch ! Ist in Wahrheit NICHT TEM

			h1 = sprintf('%12.5e', k_30_q);
			h2 = sprintf('%12.5e', p_30);
			disp('  ACHTUNG, Frequenz-relative Werte :');
			disp([' k_3_komplex^2  =  k_30^2 - J * p_30   =   ', h1, ' - J * ', h2]);


			%  für die zweite Skalierung :
			h1 = 0.5 * k_20_q;
			k_R_t12_SI = sqrt( h1 + sqrt( h1^2 + p_25^2 ) );
			lamb_t12_SI = 2. * pi / ( scl_om * k_R_t12_SI );
			%
			%   Rolf, 19.Nov.17 um Medium 3 ergänzt :
			h1 = 0.5 * k_30_q;
			k_R_t23_SI = sqrt( h1 + sqrt( h1^2 + p_35^2 ) );
			lamb_t23_SI = 2. * pi / ( scl_om * k_R_t23_SI );
			%
			scl_lam_1 = lamb_e12_SI / lamb_0;
			scl_lam_2 = lamb_t12_SI / lamb_0;
			scl_lam_3 = lamb_t23_SI / lamb_0;
			h3 = scl_lam_1;
			h4 = scl_lam_2;
			h5 = scl_lam_3;
			h1 = sprintf('%12.5e', h3);
			h2 = sprintf('%12.5e', h4);
			h6 = sprintf('%12.5e', h5);
			disp(['scl_lam_1 = ', h1, '   ;   scl_lam_2 = ', h2, '   ;   scl_lam_3 = ', h6]);
			%
			scl_lam_123 = 1.;
			%          Code noch FRAGWÜRDIG, daher VORLÄUFIG :
			%  Anmerkung 23.Aug. 2017 : funktioniert so, aber Medium 3 wird bei dieser
			%                           Methode ignoriert ! Dort also < 4 Wellen MÖGLICH
			% 13.Oct. 2018 : Versuch 1 MIT Medium 3 
				if( auto_scl_lam)
					if( ( scl_lam_1 < scl_lam_2 ) && ( scl_lam_2 < .999 ) )
						disp('  FALL  scl_lam_1  <  scl_lam_2  <  1  !   Korrektur !');
						scl_lam_123 = scl_lam_2;
					elseif( ( scl_lam_2 < scl_lam_1 ) && ( scl_lam_1 < .999 ) )
						disp('  FALL  scl_lam_2  <  scl_lam_1  <  1  !   Korrektur !');
						scl_lam_123 = scl_lam_1;
					endif
			% 11.11. 2017 : HIER MUSS DIE ERGÄNZUNG UM MEDIUM #3 HIN !
			% 13.Oct.2018 : incl. Medium 3 :
			%  wäre wohl falsch herum ? :
			%        if( ( scl_lam_3 < scl_lam_123 ) && ( scl_lam_3 < .999 ) )
			%            disp('  FALL  scl_lam_3  <  scl_lam_123  <  1  !   Korrektur !');
			%
					if( ( scl_lam_123 < scl_lam_3 ) && ( scl_lam_3 < .999 ) )
						disp('  FALL  scl_lam_123  <  scl_lam_3  <  1  !   Korrektur !');
						scl_lam_123 = scl_lam_3;
					endif
				endif


			%              Für Sheets # 2 und 3  =  REFLEKTIERTE und TRANSMITTIERTE Welle :

			%      Anfangs-Phasen-Versatz beider Wellen durch Laufzeit der einfallenden :
			%
			% 11.11. 2017 : hiernach wird scl_lam_123 BENUTZT, muss also vorher fertig berechnet sein !
			%   (evtl. incl. Medium #3)
			%
			%   ALT :   Dies war ABSOLUT korrekt, ohne 'Frequenz-relativ' o. ae. :
			%phi_0_s = phi_0_e - k_R_e12 * lamb_0 * s_len;	%  in "rad"
			% NEU, 31. Aug. '14 , wieder absolut :
			phi_0_s = phi_0_e - scl_om * k_R_e12 * lamb_0 * scl_lam_123 * s_len;  %  in "rad"
			%
			h = 2. * pi;
				while( phi_0_s < 0. )
					phi_0_s += h;
				endwhile
				while( phi_0_s > h )
					phi_0_s -= h;
				endwhile
			h1 = sprintf('%12.5e', phi_0_s/radw);
			%disp(['phi_0_s  in Grad = ', h1, '  = phi_0_e - k_R_e12 * lamb_0 * s_len']);
			disp(['phi_0_s  in Grad = ', h1, ' = phi_0_e - k_R_e12_ECHT * lamb_0 * s_len  * scl_lam_123']);
			%
			dphi_0_s_H = - angle(Z_W_1);  %  in "rad" ; Anfangs-Phasen-Versatz H gegen E
			%
			% 11.11. 2017 :
			h1 = layer2_width * lamb_t12_SI * scl_lam_123;
			h2 = sprintf('%12.5e', h1);
			disp(['ECHTE Dicke des Mediums #2 in Metern = ', h2, ' = layer2_width * lamb_t12_SI * scl_lam_123']);
			disp('Falls man die Schichtdicken-Anpassung NICHT wünscht, darf man auto_scl_lam nicht setzen !');
			%
			
			% 19. Okt.2018 , Rolf , echte Schicht-Dicke in m :
			D_echt = layer2_width * scl_lam_123;
			
			h4 = [" Schichtdicke D als \"Explosionszeichnung\" übertrieben !    ECHTES D = " ...
			sprintf('%11.4e', D_echt) " m "];
			set( annot_10, "string", h4);
			
			%    b) Maßstab        :   IM 3D-Subplot z.B. unterhalb der x-Achse horizontale  Linie (mit Pfeilen) 
			%
			%             NOCH EXPERIMENTELL  !!
			%
			h1 = 2.*xG_End - xG_Anf;       h2 = yG_End - 2.*yG_Anf;       h3 = zG_End - zG_Anf;
			D_h = layer2_width * scl_lam_123;
			%
			%    Versuch 1 :   FALSCHE LÄNGEN
			%D_h2 = h1; 
			%    Versuch 2 :
			D_h2 = D_h; 
			%
			%
				if(D_h2 >= 1.e+04)
					h5 = 300;     h7 = 1.e+03;    h6 = "e+03m";
				elseif(D_h2 >= 3.e+03)
					h5 = 100;     h7 = 1.e+03;    h6 = "e+03m";
				elseif(D_h2 >= 1.e+03)
					h5 = 300;     h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 300.)
					h5 = 100;     h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 100.)
					h5 = 30;      h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 30.)
					h5 = 10;      h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 10.)
					h5 = 3;       h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 3.0)
					h5 = 1;       h7 = 1.;        h6 = "m";
				elseif(D_h2 >= 1.0)
					 h5 = 300;    h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 0.3)
					 h5 = 100;    h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 1.e-01)
					 h5 = 30;     h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 3.e-02)
					 h5 = 10;     h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 1.e-02)
					 h5 = 3;      h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 3.e-03)
					 h5 = 1;      h7 = 1.e-03;    h6 = "e-03 m";
				elseif(D_h2 >= 1.e-03)
					 h5 = 300;    h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 3.e-04)
					 h5 = 100;    h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 1.e-04)
					 h5 = 30;     h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 3.e-05)
					 h5 = 10;     h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 1.e-05)
					 h5 = 3;      h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 3.e-06)
					 h5 = 1;      h7 = 1.e-06;    h6 = "e-06 m";
				elseif(D_h2 >= 1.e-06)
					 h5 = 300;    h7 = 1.e-09;    h6 = "e-09 m";
				elseif(D_h2 >= 3.e-07)
					 h5 = 100;    h7 = 1.e-09;    h6 = "e-09 m";
				elseif(D_h2 >= 1.e-07)
					 h5 = 30;     h7 = 1.e-09;    h6 = "e-09 m";
				elseif(D_h2 >= 3.e-08)
					 h5 = 10;     h7 = 1.e-09;    h6 = "e-09 m";
				elseif(D_h2 >= 1.e-08)
					 h5 = 3;      h7 = 1.e-09;    h6 = "e-09 m";
				elseif(D_h2 >= 3.e-09)
					 h5 = 1;      h7 = 1.e-09;    h6 = "e-09 m";
				else
			%    elseif(D_h2 >= 0.1)
			%         h5 = 300;    h7 = 1.e-06;    h6 = "e-06 m";
			%    else
			%        ...........
				endif
			%
			
			Text_Mass = [ sprintf('%1d', h5) h6];
			
			% 19. Oct.  2018 :  - Länge Maßstab korrigiert : Versuch 3     NOCH FEHLER ?
			%h8 = (h5 * h7) * sheet_length / D_echt :
			h8 = (h5 * h7) * s_len / D_echt;
			
			%  13.Okt.2018   Versuch 1 (rechts oben) :
			%x_M_h1 = 2.*xG_End - h8;    y_M_h1 = yG_End - 0.05 * h2;    z_M_h1 = zG_End - 0.07 * h3;
			%x_M_h2 = x_M_h1 + h8;       y_M_h2 = y_M_h1;                z_M_h2 = z_M_h1;
			%  19.Okt.2018   Versuch 2 (links unten) :
			x_M_h1 = xG_Anf + 0.10 * h1;    y_M_h1 = 2. * yG_Anf + 0.08 * h2;    z_M_h1 = zG_Anf + 0.07 * h3;
			x_M_h2 = x_M_h1;       y_M_h2 = y_M_h1 + h8;                z_M_h2 = z_M_h1;
			
			% 07. Feb. 2019 Lines für Maßstab ab jetzt dynamisch mit set():
			set(mli_1, "xdata", [x_M_h1, x_M_h2], "ydata", [y_M_h1, y_M_h2], "zdata", [z_M_h1, z_M_h2]);
			set(mli_2, "xdata", [x_M_h1, x_M_h1 + 0.02*h1], "ydata", [y_M_h1, y_M_h1], "zdata", [z_M_h1, z_M_h2]);
			set(mli_3, "xdata", [x_M_h2, x_M_h2 + 0.02*h1], "ydata", [y_M_h2, y_M_h2], "zdata", [z_M_h1, z_M_h2]);
			
			
			x_M_h3 = x_M_h1 + 0.04 * h1;
			y_M_h3 = y_M_h1 + .45 * h8;
			%hText_Mass = text( x_M_h3, y_M_h3, z_M_h1, Text_Mass, ...
			%		"color", "r", "fontsize", 16 );
			set(hText_Mass, "position", [x_M_h3, y_M_h3, z_M_h1], "String", Text_Mass);
			
			k_R_e12_sc = scl_lam_123 * k_R_e12;		k_I_e12_sc = scl_lam_123 * k_I_e12;
			k_R_r12_sc = scl_lam_123 * k_R_r12;		k_I_r12_sc = scl_lam_123 * k_I_r12;


			%            ZE_e = Amp_e .* exp( k_I_e12_sc .* XS) .* cos(phi_e .- k_R_e12_sc .* XS);
			A1_e12_exp = exp( k_I_e12_sc .* XS);	A2_e12_cos = k_R_e12_sc .* XS;
			A1_r12_exp = exp( k_I_r12_sc .* XS);	A2_r12_cos = k_R_r12_sc .* XS;
			
			freq_eq = False;
		endwhile
		%######################################################################################################################################################
		while(upd_BSe)
			%		HIER aller 'alpha_e12' - abhängige Code !
			%		  { sonst kein 'alpha_e12 sweep' möglich }
			%
			%             "Reflexions- und Brechungsgesetze  fuer H_senkrecht" :
			%                       ( Brechungsswinkel etc. berechnen )
			%
			%      Reflexionswinkel in "Grad * radw" :
			alpha_r12 = alpha_e12;        % korrekt,  Zählweisen u. VZ's beachten
			%
			disp('');
			h3 = alpha_e12 / radw;
			h1 = sprintf('%12.5e', h3);
			disp(['***  NEUES alpha_e12  in Grad  = ', h1]);
			%
			C_i = cos(alpha_e12);	S_i = sin(alpha_e12);
			%
			%   Abschätzung 'Grenzwinkel' (scharf existent nur bei alpha) :
			%      k_R_t12 * S_t = k_R_e12 * S_i
			%      S_t = k_R_e12 * S_i / k_R_t12   muss <= 1 sein
			%      1 = k_R_e12 * S_i12_Grenz / k_R_t12   muss = 1 sein
			%        ==> S_i12_Grenz = k_R_t12 / k_R_e12
			%
			k_R_t12T = k_20;		% 1. Abschätzung !  ( ==> k_I_t12 MUESSTE dann 0 sein )
			%
			h = k_R_t12T / k_R_e12;
				if( h > 1. )
					disp('  ==> sicher normale Brechung');
					S_i12_GrenzT = 1.;
					alpha_e12_GrenzT = 0.5 * pi + 1.e-6;
				else
					disp('  ==> mögliche Totalreflexion mit Filmwelle');
					S_i12_GrenzT = h;
					alpha_e12_GrenzT = asin( S_i12_GrenzT );
				endif
			%h3 = alpha_e12_GrenzT / radw;
			%h1 = sprintf('%12.5e', h3);
			%disp('');
			%disp(['  1. Abschätzung   alpha_e12_Grenz = ', h1, ' Grad']);
				if( alpha_e12 < alpha_e12_GrenzT )
					disp('  ==> vermutlich normale Brechung');
				else
					disp('  ==> eventuell Totalreflexion mit Filmwelle');
				endif

			%

			%  Sinn Zeile hierunter ???????? :
			C_t_valid = False;    k_R_t12_valid = False;


			%  24. Apr. 2016 hier neu :
			%      krt_Solver als separate Funktion :
			[k_R_t12, k_I_t12, alpha_t12, psi_t12] = kRt_Solve_01( ...
								   k_R_e12, k_I_e12, k_20, p_25, alpha_e12);

			psi_e12 = psi_r12 = 0.;

			% set annot_8 variabel hier (mit TeX) :
			%
			h2 = [ sprintf('%8.3f', alpha_e12/radw) ' '];
			h3 = [ sprintf('%8.3f', alpha_t12/radw) ' '];
			h4 = [ sprintf('%+9.3f', psi_t12/radw) ' '];
			%
			set( annot_8, 'string', [ 
						  [' \alpha_{e,12} = ' h2 ]; ...
						  ' '; ...
						  [' \alpha_{t,12} = ' h3 ]; ...
						  ' '; ...
						  [' \psi_{t,12} = ' h4 ]; ...
						  ' '   ] );



			%        An dieser Stelle beginnen die Berechnungen für Border 2 

			alpha_e23 = alpha_t12;     psi_e23 = psi_t12;
			k_R_e23 = k_R_t12;         k_I_e23 = k_I_t12;

			% Folgerung aus den RBs (mit leichten Bauchschmerzen) :
			alpha_r23 = alpha_e23;    psi_r23 = psi_e23;
			k_R_r23 = k_R_e23;        k_I_r23 = k_I_e23;


			[k_R_t23, k_I_t23, alpha_t23, psi_t23] = kRt2_Solve_01( ...
								   k_R_e23, k_I_e23, k_30, p_35, alpha_e23, psi_e23);

			% set annot_9 variabel hier (10. Okt.2018 mit Tex) :
			%
			h2 = [ sprintf('%8.3f', alpha_e23/radw) ' '];
			h3 = [ sprintf('%8.3f', alpha_t23/radw) ' '];
			h4 = [ sprintf('%+9.3f', psi_t23/radw) ' '];
			%
			set( annot_9, 'string', [ 
						  [' \alpha_{e,23} = ' h2 ]; ...
						  ' '; ...
						  [' \alpha_{t,23} = ' h3 ]; ...
						  ' '; ...
						  [' \psi_{t,23} = ' h4 ]; ...
						  ' '   ] );



			%   für geom. Reihe , an Border 1 rückwärts  (Rolf, 19.Nov.2017) :

			alpha_e21 = alpha_r23;      psi_e21 = psi_r23;
			k_R_e21 = k_R_r23;          k_I_e21 = k_I_r23;
			%
			% 30.Jan.2019    Rolf Korrektur  :   hier mit k10, p15 aufrufen !! :
			%%[k_R_t21, k_I_t21, alpha_t21 , psi_t21] = kRt2_Solve_01( ...
			%%                       k_R_e21, k_I_e21, k_20, p_25, alpha_e21, psi_e21);
			[k_R_t21, k_I_t21, alpha_t21 , psi_t21] = kRt2_Solve_01( ...
								   k_R_e21, k_I_e21, k_10, p_15, alpha_e21, psi_e21);
			%
			alpha_r21 = alpha_e21; % wegen der RBs (Bauchschmerzen s.o.)
			k_R_r21 = k_R_e21;    k_I_r21 = k_I_e21;
			psi_r21 = psi_e21;      %  ??? Rolf


			%        !!!!!!!!!!  LÖSUNGEN SIND KOMPLETT  incl 2 -> 1 rückwärts !!!!!!!!!!!!
			%

			%           an Border 1 :
			%
			Cae12 = cos(alpha_e12); 	Sae12 = sin(alpha_e12);
			Car12 = cos(alpha_r12); 	Sar12 = sin(alpha_r12);
			Cat12 = cos(alpha_t12); 	Sat12 = sin(alpha_t12);
			C_t = Cat12;    S_t = Sat12;
			%
			S_psi_t12 = sin( psi_t12 );     C_psi_t12 = cos( psi_t12 );
			S_H = sin( alpha_t12 - psi_t12 );    C_H = cos( alpha_t12 - psi_t12 );
			%
			S_beta_e = sin( alpha_e12 - psi_e12 );    C_beta_e = cos( alpha_e12 - psi_e12 );
			S_beta_r = sin( alpha_r12 - psi_r12 );    C_beta_r = cos( alpha_r12 - psi_r12 );
			S_beta_t = sin( alpha_t12 - psi_t12 );    C_beta_t = cos( alpha_t12 - psi_t12 );
			S_H = S_beta_t;    C_H = C_beta_t;
			%     alt :  S_H = sin( alpha_t12 - psi_t12 );    C_H = cos( alpha_t12 - psi_t12 );

			%                  Border 2 :
			%
			Cae23 = cos(alpha_e23);	    Sae23 = sin(alpha_e23);
			Car23 = cos(alpha_r23);	    Sar23 = sin(alpha_r23);
			Cat23 = cos(alpha_t23);	    Sat23 = sin(alpha_t23);
			%
			C_i2 = Cae23;	S_i2 = Sae23;       %NOETIG ???
			C_t2 = Cat23;   S_t2 = Sat23;
			%
			C_psi_r23 = cos( psi_r23 );     S_psi_r23 = sin( psi_r23 );
			C_psi_t23 = cos( psi_t23 );     S_psi_t23 = sin( psi_t23 );
			S_beta_e23 = sin( alpha_e23 - psi_e23 );    C_beta_e23 = cos( alpha_e23 - psi_e23 );
			S_beta_r23 = sin( alpha_r23 - psi_r23 );    C_beta_r23 = cos( alpha_r23 - psi_r23 );
			S_beta_t23 = sin( alpha_t23 - psi_t23 );    C_beta_t23 = cos( alpha_t23 - psi_t23 );
			C_H2 = C_beta_t23;

			%   19. Nov.2017 rückwärts an Border 1 :
			%  ( SPÄTER ÜBERPRÜFEN ! WELCHE BRAUCHT MAN DAVON ??? )
			Cae21 = cos(alpha_e21); 	Sae21 = sin(alpha_e21);
			Car21 = cos(alpha_r21); 	Sar21 = sin(alpha_r21);
			Cat21 = cos(alpha_t21); 	Sat21 = sin(alpha_t21);
			%
			S_psi_r21 = sin( psi_r21 );     C_psi_r21 = cos( psi_r21 );
			S_psi_t21 = sin( psi_t21 );     C_psi_t21 = cos( psi_t21 );
			S_beta_e21 = sin( alpha_e21 - psi_e21 );    C_beta_e21 = cos( alpha_e21 - psi_e21 );
			S_beta_r21 = sin( alpha_r21 - psi_r21 );    C_beta_r21 = cos( alpha_r21 - psi_r21 );
			S_beta_t21 = sin( alpha_t21 - psi_t21 );    C_beta_t21 = cos( alpha_t21 - psi_t21 );



			%      exakter Grenzwinkel Totalreflexion (nur bei Fall alpha) :
			S_i12_Grenz = k_R_t12 / k_R_e12;
			alpha_e12_Grenz = asin( S_i12_Grenz );
			%h3 = alpha_e12_Grenz / radw;
			%h1 = sprintf('%12.5e', h3);
			%disp('');
			%disp(['  genaue Lösung VERLUSTLOS alpha_e12_Grenz = ', h1, ' Grad']);
			%

			%      Komponenten von k_I_t12 longitudinal und transversal ( 'Frequenz-relativ' ) :
			kx_I_t12 = k_I_t12 * C_psi_t12;	    ky_I_t12 = - k_I_t12 * S_psi_t12;
			kx_I_r23 = k_I_r23 * C_psi_r23;	    ky_I_r23 = k_I_r23 * S_psi_r23;
			kx_I_t23 = k_I_t23 * C_psi_t23;	    ky_I_t23 = - k_I_t23 * S_psi_t23;

			%
			%      Wellenlänge ( NICHT 'Frequenz-relativ' ) :
			%lamb_t = 2. * pi / k_R_t12; %   ALT korrekt
			lamb_t = 2. * pi / ( scl_om * k_R_t12);    % korrekt
			lamb_t2 = 2. * pi / ( scl_om * k_R_t23);    % korrekt
			%
			%      Dämpfung Welle Typ 2 ( NICHT 'Frequenz-relativ' ) :
			%D_alpha_t12 = -k_I_t12;   %   ALT  korrekt
			D_alpha_t12 = -scl_om * k_I_t12;
			D_alpha_t23 = -scl_om * k_I_t23;        % Achtung, nicht rein longitudinal !
			D_alpha_t21 = -scl_om * k_I_t21;        % Achtung, sollte rein longitudinal sein !
			%

			%
			%                  Wellenwiderstände gebrochene :
			%       exakt für rein transversales H :
			%Z_W_2_tr = ( k_R_t12 + J * k_I_t12 * C_psi_t12 ) / ( om * c_eps_2 );    %   ALT   korrekt
			Z_W_2_tr = scl_om * ( k_R_t12 + J * k_I_t12 * C_psi_t12 ) / ( om * c_eps_2 );
			Z_W_3_tr = scl_om * ( k_R_t23 + J * k_I_t23 * C_psi_t23 ) / ( om * c_eps_3 );
			%
				if( kap_2 > 1.e-20 )
			%       exakt für longitudinales E :
					%Z_W_2_lo = J *( k_I_t12 * sin(psi_t12) ) / ( om * c_eps_2 ;  %   ALT   korrekt
					Z_W_2_lo = scl_om * J *( k_I_t12 * sin(psi_t12) ) / ( om * c_eps_2 );
				else
			%       Pseudo für kap_2 = 0 :     KORREKT FÜR TM ???
					Z_W_2_lo = 1.e20;
				endif
			%
			%
				if( kap_3 > 1.e-20 )
			%       exakt für longitudinales E :
					%Z_W_3_lo = J *( k_I_t23 * sin(psi_t23) ) / ( om * c_eps_3 ;  %   ALT   korrekt
					Z_W_3_lo = scl_om * J *( k_I_t23 * sin(psi_t23) ) / ( om * c_eps_3 );
				else
			%       Pseudo für kap_3 = 0 :     KORREKT FÜR TM ???
					Z_W_3_lo = 1.e20;
				endif
			%

			%  JETZT ERST    (Anfangs)-Amplituden ; Phasensprünge/-Drehungen incl. :

			%                HIER FÜR 'Border 1' :
			%
			%           ACHTUNG, HIER VIEL KOMPLIZIERTER !!!
			%
			%      MÜSSEN NICHT HIER DYADEN REIN  ---  ODER ALLES FÜR H STATT E  ???           JA !!!
			%
			%            ANDERS ALS IN DER LITERATUR !!!   'r' und 't' FÜR 'H'   !!!   MAGNETISCH  !!!
			%
			% 08. Mai 2017    Versuch 2 :
			%
				if( S_i < .9999999 )	% kein 'streifender Einfall'
					%
					%  bei "E_parallel" ; skalar nur für MAGNETFELD :
					% ALT, FEHLER Diplomarbeit David in Gl. (4.6.9) !!! :
					%m_12 = ( kap_2 + J * om * eps_2 ) / ( kap_1 + J * om * eps_1 );
					% NEU 15. Mai 2017 Rolf :
					m_12 = ( kap_1 + J * om * eps_1 ) / ( kap_2 + J * om * eps_2 );
					%
					F_12_paral = m_12 * ( k_I_t12 * C_beta_t - J * k_R_t12 * Cat12 ) / ...
									   ( k_I_e12 * C_beta_e - J * k_R_e12 * Cae12 );
				else
				% 'streifender Einfall' :    ACHTUNG ! CODE NOCH FALSCH ???????????????????????? :
					%  angebl. echt r12_paral = -1. ; t12_paral = 0. :            ?????????????????
					F_12_paral = 1.e40;
				endif
			%
			%
			%    meine Lieblings-Schreibweise, erinnert an Leitungstheorie / S-Parameter :
			%       ALLES ANALOG ZU 'E_senkr' :
			r12_paral = (1. - F_12_paral) / (1. + F_12_paral);
			%
			%    EINE (korrekte !) Möglichkeit :
			%t12_paral = 2. / ( 1. + F_12_paral);
			%    ZWEITE (korrekte) Möglichkeit { Achtung, für H nur bei 'E_paral' ! } :
			t12_paral = 1. + r12_paral;
			%

			%
			%                HIER FÜR 'Border 2 vorwärts'  :
			%
			% 08. Mai 2017 :
			%
				if( Sae23 < .9999999 )	% kein 'streifender Einfall'
					%
					%  bei "E_parallel" ; skalar nur für MAGNETFELD :
					% NEU 15. Mai 2017 Rolf  ( korrigierte  Gl. (4.6.9) von David ) :
					m_23 = ( kap_2 + J * om * eps_2 ) / ( kap_3 + J * om * eps_3 );
					%
					F_23_paral = m_23 * ( k_I_t23 * C_beta_t23 - J * k_R_t23 * C_t2 ) / ...
										( k_I_e23 * C_beta_e23 - J * k_R_e23 * C_i2 );
				else
				% 'streifender Einfall' :    ACHTUNG ! CODE NOCH FALSCH ???????????????????????? :
					%  angeblich echt r2 = -1. ; t2 = 0. :            ?????????????????
					F_23_paral = 1.e40;
				endif
			%
			%
			%    meine Lieblings-Schreibweise, erinnert an Leitungstheorie / S-Parameter :
			%       ANALOG ZU 'E_senkr' :
			r23_paral = (1. - F_23_paral) / (1. + F_23_paral);
			%
			%    EINE (korrekte !) Möglichkeit :
			%t23_paral = 2. / ( 1. + F_23_paral);
			%    ZWEITE (korrekte) Möglichkeit { Achtung, für H nur bei 'E_paral' ! } :
			t23_paral = 1. + r23_paral;
			%


			%
			%                HIER FÜR 'Border 1 rückwärts'  :
			%
			% 19. Nov. 2017 :
			%
				if( Sae21 < .9999999 )	% kein 'streifender Einfall'
					%
					%  bei "E_parallel" ; skalar nur für MAGNETFELD :
					% Rolf  ( korrigierte  Gl. (4.6.9) von David ) :
					m_21 = ( kap_2 + J * om * eps_2 ) / ( kap_1 + J * om * eps_1 );
					%
					F_21_paral = m_21 * ( k_I_t21 * C_beta_t21 - J * k_R_t21 * Cat21 ) / ...
										( k_I_e21 * C_beta_e21 - J * k_R_e21 * Cae21 );
				else
				% 'streifender Einfall' :    ACHTUNG ! CODE NOCH FALSCH ???????????????????????? :
					%  angeblich echt r21 = -1. ; t21 = 0. :            ?????????????????
					F_21_paral = 1.e40;
				endif
			%
			%
			%    meine Lieblings-Schreibweise, erinnert an Leitungstheorie / S-Parameter :
			%       ANALOG ZU 'E_senkr' :
			r21_paral = (1. - F_21_paral) / (1. + F_21_paral);
			%
			%    EINE (korrekte !) Möglichkeit :
			%t21_paral = 2. / ( 1. + F_21_paral);
			%    ZWEITE (korrekte) Möglichkeit { Achtung, für H nur bei 'E_paral' ! } :
			t21_paral = 1. + r21_paral;
			%


			%     sowieso WILLKÜRLICHE Anfangs-Amplitude ggfs. reduzieren, damit 
			%     gebrochene/Film- Welle graphisch dargestellt werden kann :
			h = abs(t12_paral * Amp_e);
				if( h > 1. )
					Amp_e /= h;     Amp_e_H /= h;
				endif
			%
			%%           nur zum Vergleich ; vom 24. Apr. 2016 für "E_senkrecht" :
			%%  c_Amp_r12 = r12_senkr * Amp_e * exp( k_I_e12_sc * s_len + J * phi_0_s );
			%%  c_Amp_t12 = t12_senkr * Amp_e * exp( k_I_e12_sc * s_len + J * phi_0_s );
			%
			%   korrekte komplexe Werte für "H_senkrecht" :
			%    neu 20. Nov. 2017 Rolf :
			hc = Amp_e_H * exp(k_I_e12 * s_len * scl_lam_123 + J * (phi_0_s + dphi_0_s_H ));
			c_Amp_r_H = r12_paral * hc;      c_Amp_t_H = t12_paral * hc;
			%
			% Die korrekten Phasen werden nun mit dargestellt
			%
			c_Amp_r = c_Amp_r_H / exp(J * dphi_0_s_H );      %  OHNE  ' * Z_W_1 ' im Nenner !
			%
			hc = 1. / ( Z_W_1 * exp(J * dphi_0_s_H ));
			c_Amp_t_tr = c_Amp_t_H * Z_W_2_tr * hc;		%  ???   konsequent :
			c_Amp_t_lo = c_Amp_t_H * Z_W_2_lo * hc;		%  ???   E zu KLEIN !
			%
			%    ==> Faktor 'Z_W_1' berücksichtigt, dass ZUR DARSTELLUNG
			%        willkürlich 'Amp_e_H = Amp_e' gesetzt wurde !
			%    ==> ist hier konsequent !  Nur sind dann ALLE WERTE / BETRÄGE von H um Z_W_1 zu groß !
			%
			%                 SIND DAMIT AUCH ALLE H-PHASEN FALSCH ???
			%
			Amp_r_H = abs(c_Amp_r_H);   	phase_Amp_r_H = angle(c_Amp_r_H);
			Amp_t_H = abs(c_Amp_t_H);   	phase_Amp_t_H = angle(c_Amp_t_H);
			Amp_r = abs(c_Amp_r);       	phase_Amp_r = angle(c_Amp_r);
			Amp_t_tr = abs(c_Amp_t_tr); 	phase_Amp_t_tr = angle(c_Amp_t_tr);
			Amp_t_lo = abs(c_Amp_t_lo); 	phase_Amp_t_lo = angle(c_Amp_t_lo);


			%               Neu 15. May 2017 :
			%
			%          korrekte komplexe Werte an Border # 2 :
			%
			%  1. Versuch, heuristisch gegen Filmwellen incl. Annäherung :
			LW2_max_factor = 1.e5;
				if( Cat12 > (1. / LW2_max_factor) )
				   L_eff_2 = layer2_width / Cat12;
				else
				   L_eff_2 = layer2_width *  LW2_max_factor;
				endif
			%
			k_R_t12_sc = scl_lam_123 * k_R_t12;      k_I_t12_sc = scl_lam_123 * k_I_t12;

			c_Amp_e20_H = c_Amp_t_H * exp( ( k_I_t12_sc - J * k_R_t12_sc ) * L_eff_2 );
			%
			c_Amp_r2_H = r23_paral * c_Amp_e20_H;       c_Amp_t2_H = t23_paral * c_Amp_e20_H;
			%
			%
			%  OHNE  ' * Z_W_1 '   !? :
			hc = 1. / ( Z_W_1 * exp(J * dphi_0_s_H ));
			c_Amp_r2_tr = c_Amp_r2_H * Z_W_2_tr * hc;		%  ???   konsequent :
			c_Amp_r2_lo = c_Amp_r2_H * Z_W_2_lo * hc;		%  ???   E zu KLEIN !
			%
			c_Amp_t2_tr = c_Amp_t2_H * Z_W_3_tr * hc;		%  ???   konsequent :
			c_Amp_t2_lo = c_Amp_t2_H * Z_W_3_lo * hc;		%  ???   E zu KLEIN !
			%
			Amp_r2_H = abs(c_Amp_r2_H); 	phase_Amp_r2_H = angle(c_Amp_r2_H);
			Amp_t2_H = abs(c_Amp_t2_H); 	phase_Amp_t2_H = angle(c_Amp_t2_H);
			Amp_r2_tr = abs(c_Amp_r2_tr);	phase_Amp_r2_tr = angle(c_Amp_r2_tr);
			Amp_r2_lo = abs(c_Amp_r2_lo);	phase_Amp_r2_lo = angle(c_Amp_r2_lo);
			Amp_t2_tr = abs(c_Amp_t2_tr);	phase_Amp_t2_tr = angle(c_Amp_t2_tr);
			Amp_t2_lo = abs(c_Amp_t2_lo);	phase_Amp_t2_lo = angle(c_Amp_t2_lo);


			% Rolf, 04.Jan.2017, Fall-angepasste Verschiebung der y-Bereiche-lokal :
			%     ==> hier in der loop HINTER kRt2_Solve_01 !
			%       an Border # 1 ;    % vom VZ von psi_t12 abhängig :
				if( psi_t12 < 0. )
					YS_t = YS .- y_Anf;
				else
					YS_t = YS .- y_End;
				endif
			%       an Border # 2 :
			YS_r2 = YS_t;           % vermutlich immer korrekt
			% am kompliziertesten, da vom VZ von psi_t23 abhängig :
				if( psi_t23 < 0. )
					YS_t2 = YS .- y_Anf;
				else
					YS_t2 = YS .- y_End;
				endif


			% 16. Okt.2017 :
			%  1. Versuch zur Auswertung der geometrischen Reihe / Mehrfach-Reflexionen :
				if (geom_Reihe_flag == True)
					%        Faktor für EIN Durchlaufen von Medium 2 :
					fakt_med_2 =  exp( ( k_I_t12_sc * C_psi_t12 - J * k_R_t12_sc ) * L_eff_2 );
					%        Faktor für einen Term in 'Reihen r1_ges und t3_ges'  :
					fakt_r1t3_ges = r23_paral * r21_paral * 2. * fakt_med_2;
					%        'Reihe r1_ges'  :
					r1_paral_ges = r12_paral / (1. - fakt_r1t3_ges);
					%        'Reihe t3_ges'  :
					t3_paral_ges = t23_paral / (1. - fakt_r1t3_ges);
				else
					r1_paral_ges = r12_paral;
					t3_paral_ges = t23_paral;
				endif
			%
			%  damit alle Amplituden / Phasen NEU !!!


			%
			% Versuch der Farb-Kontrast-Erhöhung :
			color_Factor_r = 1.;
			h = abs(Amp_r);
				if( h > 0.05)
					color_Factor_r = 0.95 / abs(Amp_r);
				endif
			% Palette ist so gut genug, Spreizung begrenzen :
				if( color_Factor_r > 2.)
					color_Factor_r = 2.;
				endif
			%
			color_Factor_t = 1.;
			h = abs(Amp_t_tr);
				if( h > 0.05)
					color_Factor_t = 0.95 / abs(Amp_t_tr);
				endif
			% Palette ist so gut genug, Spreizung begrenzen :
				if( color_Factor_t > 2.)
					color_Factor_t = 2.;
				endif


			%         "Start-Position" der Sheets an Border 1 :
			%    Versuch :  alle mit "s_wid*0.5" 
			%        ist SEHR GUT für :  
			%        s_wid = 2 , s_len = 4 ,  s_offset = 0.2 ;
			%        ==> alpha_e12 = 0 ... 90 ,  alpha_t12 = 0 ... 33,5
			h = 0.5 * s_wid;
			xG_off_e = xG_cent - s_len * Sae12 - h * Cae12 - s_offset;
			yG_off_e = yG_cent + s_len * Cae12 + h * Sae12 + s_offset;
			xG_off_r = xG_cent + s_offset + h * Car12;
			yG_off_r = yG_cent + s_offset + h * Sar12;
			%  Sheet-Ecke etwas weg von Border :
			xG_off_t = xG_cent + 0.1 + s_offset * Cat12;
			yG_off_t = yG_cent - 0.1 - (s_offset + h) * Sat12;


			%         "Start-Position" der Sheets an Border 2 :
			%
			%    Versuch : y statisch , nur x dynamisch :
			%   neu 20.Nov.2017 :
				if( Cat12 > (1./sqrt(2.)) )
				   xG_off_B2 = xG_cent + s_len  * Sat12 / Cat12;    % echter Offset bis 45 Grad
				   xG_off_flag = True;
				else
				   %xG_off_B2 = xG_cent + s_len  * xB2_max_factor;   % Limit für Offset
				   xG_off_B2 = xG_cent + s_len;   % Limit für Offset
				   xG_off_flag = False;
				endif
			%
			XBO2 = XBO .+ xG_off_B2;
			%   fest :
			%YBO2 = YBO .+ yG_off_B2;
			%
			%
			% dann Position der neuen R2- und T2-Sheets :
			h = 0.5 * s_wid;
			%xG_off_r2 = xG_off_B2 + 1.5 + s_offset + h * Car23;        % alt, ging
			% 11. Nov. 2017 :
			h2 = .75 * s_wid;       % wie alt : so überlappen die sheets wenig !
			xG_off_r2 = xG_off_B2 + h2 + s_offset + h * Car23;
			%  Start bei Alpha-e = 0 ok, wandert aber mit steigendem Aplha-e nach oben :
			yG_off_r2 = yG_off_B2 + s_offset + h * Sar23;
			%  Sheet-Ecke etwas weg von Border :
			xG_off_t2 = xG_off_B2 + 1.5 + s_offset * Cat23;        % alt, ging
			% 11. Nov. 2017 :
			xG_off_t2 = xG_off_B2 + h2 + s_offset * Cat23;
			yG_off_t2 = yG_off_B2 - 0.1 - (s_offset + h) * Sat23;
			% neu 20. Nov. 2017 :
			%    ( xs_h = repmat( xs, i_y, 1);      ys_tr_h = repmat( ys', 1, i_x); )
			%  mit 2 neuen Matrizen xs_h und ys_tr_h :
			%
			% HSN :
			XG_e = ys_tr_h .* Cae12 + xs_h .* Sae12 .+ xG_off_e;
			YG_e = ys_tr_h .* Sae12 - xs_h .* Cae12 .+ yG_off_e;
			% EPT :
			XGE_e = XG_e;
			YGE_e = YG_e;
			upd_BSe = False;
		endwhile
		%##
		while(upd_BSr)
			% HSN :
			XG_r = ys_tr_h .* (-Car12) + xs_h .* Sar12 .+ xG_off_r;
			YG_r = ys_tr_h .* Sar12 + xs_h .* Car12 .+ yG_off_r;
			% EPT :
			XGE_r = XG_r;
			YGE_r = YG_r;
			upd_BSr = False;
		endwhile
		%##
		while(upd_BSt)
			% HSN :
			XG_t = ys_tr_h .* Cat12 + xs_h .* Sat12 .+ xG_off_t;
			YG_t = ys_tr_h .* Sat12 - xs_h .* Cat12 .+ yG_off_t;
			% EPT :
			XGE_t = XG_t;
			YGE_t = YG_t;
			%
			% Neu 20. Nov. 2017 :
			% HSN :
			XG_r2 = ys_tr_h .* (-Car23) + xs_h .* Sar23 .+ xG_off_r2;
			YG_r2 = ys_tr_h .* Sar23 + xs_h .* Car23 .+ yG_off_r2;
			XG_t2 = ys_tr_h .* Cat23 + xs_h .* Sat23 .+ xG_off_t2;
			YG_t2 = ys_tr_h .* Sat23 - xs_h .* Cat23 .+ yG_off_t2;
			% EPT :
			XGE_r2 = XG_r2;
			YGE_r2 = YG_r2;
			XGE_t2 = XG_t2;
			YGE_t2 = YG_t2;
			upd_BSt = False;
		endwhile

    %
    % bleiben hier :
    k_R_t12_sc = scl_lam_123 * k_R_t12;
    kx_I_t12_sc = scl_lam_123 * kx_I_t12;   ky_I_t12_sc = scl_lam_123 * ky_I_t12;
    k_R_r23_sc = scl_lam_123 * k_R_r23;
    kx_I_r23_sc = scl_lam_123 * kx_I_r23;   ky_I_r23_sc = scl_lam_123 * ky_I_r23;
    k_R_t23_sc = scl_lam_123 * k_R_t23;
    kx_I_t23_sc = scl_lam_123 * kx_I_t23;   ky_I_t23_sc = scl_lam_123 * ky_I_t23;

    %      Palette einfallender Wellen :
    phih_COLORS_e = .6 * pi - k_R_e12_sc .* XS;   % Lage Rot besser auf Maxima  als mit 0.5
    %      Paletten reflektierter Wellen :
    %phih_COLORS_r = - k_R_r12_sc .* XS;   % ohne Verschiebg : scharfe Paletten-Kante Grün ganz unten
    phih_COLORS_r = -0.25 * pi - k_R_r12_sc .* XS;   % Rot recht gut auf Maxima
    % neu 21. Jan. 2017 :
    phih_COLORS_r2 = -0.25 * pi - k_R_r23_sc .* XS;   % Rot recht gut auf Maxima
    %      Paletten gebrochener Wellen :
    %phih_COLORS_t = .5 * pi - k_R_t12_sc .* XS;  % Violett besser auf Maxima als ganz ohne
    phih_COLORS_t = .425 * pi - k_R_t12_sc .* XS;   % Violett sehr gut auf Maxima
    % neu 21. Jan. 2017 :
    phih_COLORS_t2 = .425 * pi - k_R_t23_sc .* XS;   % Violett sehr gut auf Maxima


    hco1 = 25./39. - 1.01;

    phi = 0.;

    % alt, fuer 'CPU-time' geeignet :
    %tstart = time();
    % neu 04. Mar. 2016, Echtzeit :
    tstart = clock();

    for ip = 1:i_phi
        %
        hco1 += dhco1;  
        %
        %     Generiere neue "lokale Sheets" "zum Zeitpunkt i" :
        %
        phi_e = phi+phi_0_e;        		phi_eH = phi + phi_0_e + dphi_0_s_H;
        phi_rE = phi + phase_Amp_r;     	phi_rH = phi + phase_Amp_r_H;
        phi_tH = phi + phase_Amp_t_H;
        phi_tE_tr = phi + phase_Amp_t_tr;    phi_tE_lo = phi + phase_Amp_t_lo;
        %
        % Neu 15. May 2017 für Border # 2   bei TM :
        %    Frage 20. Mai 2017  ' angle( exp( J .* ... '  schneller ersetzen durch ???
        phi_0_e2H = phase_Amp_t_H + angle( exp( J * k_R_t12_sc * L_eff_2 ));
        phi_e2H = phi+phi_0_e2H;		phi_e2 = phi + phi_0_e2H - dphi_0_s_H;
        %
        phi_r2H = phi + phase_Amp_r2_H;
        phi_t2H = phi + phase_Amp_t2_H;
        phi_r2E_tr = phi + phase_Amp_r2_tr;    phi_r2E_lo = phi + phase_Amp_r2_lo;
        phi_t2E_tr = phi + phase_Amp_t2_tr;    phi_t2E_lo = phi + phase_Amp_t2_lo;
        % Ende neu


        if(upd_ZHe)
            % HSN :
            ZH_e = Amp_e_H .* A1_e12_exp .* cos(phi_eH .- A2_e12_cos);
            %
            ZH_e_ges(ip, 1:i_y, 1:i_x) = ZH_e(1:i_y, 1:i_x);
            % EPT :
            ZP_e = Amp_e .* A1_e12_exp .* cos(phi_e .- A2_e12_cos);
            %      Bei "E-parallel, Sheet parallel" :
            %   dies Sheet muss global werden :
            %
            XP_e = ZP_e .* Cae12 .+ XGE_e;       YP_e = ZP_e .* Sae12 .+ YGE_e;
            %
            XP_e_ges(ip, 1:i_y, 1:i_x) = XP_e(1:i_y, 1:i_x);
            YP_e_ges(ip, 1:i_y, 1:i_x) = YP_e(1:i_y, 1:i_x);
       else    % (upd_ZHe == False):
            % HSN :
            ZH_e(1:i_y, 1:i_x) = ZH_e_ges(ip, 1:i_y, 1:i_x);
            % EPT :
            XP_e(1:i_y, 1:i_x) = XP_e_ges(ip, 1:i_y, 1:i_x);
            YP_e(1:i_y, 1:i_x) = YP_e_ges(ip, 1:i_y, 1:i_x);
        endif
        %          Farben echt nach Phase :
        %   neu 05.Nov.2016 :
        COLORS_eE = 2. .+ angle( exp( J .* ( phi_e .+ phih_COLORS_e ) ) ) ./ pi;
        COLORS_eH = 2. .+ angle( exp( J .* ( phi_eH .+ phih_COLORS_e ) ) ) ./ pi;
        % Frage 20. Mai 2017  ' angle( exp( J .* ... '  WIE SCHNELLER                   ???
        %   ==> VERSAGT SO ,                Fehler in der HALBEN Farb-Palette :
        %COLORS_eE = 2. .+ ( ( phi_e .+ phih_COLORS_e ) ./ pi );
        %COLORS_eH = 2. .+ ( ( phi_eH .+ phih_COLORS_e ) ./ pi );
        %
        if(upd_ZHr)
            % HSN :
            ZH_r = Amp_r_H .* A1_r12_exp .* cos(phi_rH .- A2_r12_cos);
            %
            ZH_r_ges(ip, 1:i_y, 1:i_x) = ZH_r(1:i_y, 1:i_x);
            % EPT :
            ZP_r = Amp_r .* A1_r12_exp .* cos(phi_rE .- A2_r12_cos);
            %      Bei "E-parallel, Sheet parallel" :
            %   dies Sheet muss GLOBAL werden :
            %
            XP_r = -ZP_r .* Car12 .+ XGE_r;    YP_r = ZP_r .* Sar12 .+ YGE_r;
            %
            XP_r_ges(ip, 1:i_y, 1:i_x) = XP_r(1:i_y, 1:i_x);
            YP_r_ges(ip, 1:i_y, 1:i_x) = YP_r(1:i_y, 1:i_x);
        else   % (upd_ZHr == False):
            % HSN :
            ZH_r(1:i_y, 1:i_x) = ZH_r_ges(ip, 1:i_y, 1:i_x);
            % EPT :
            XP_r(1:i_y, 1:i_x) = XP_r_ges(ip, 1:i_y, 1:i_x);
            YP_r(1:i_y, 1:i_x) = YP_r_ges(ip, 1:i_y, 1:i_x);
        endif
        %          Farben echt nach Phase neu 05.Nov.2016 :
        COLORS_rE = 4. .+ angle( exp( J .* ( phi_rE .+ phih_COLORS_r ) ) ) ./ pi;
        COLORS_rH = 4. .+ angle( exp( J .* ( phi_rH .+ phih_COLORS_r ) ) ) ./ pi;
        %
        if(upd_ZHt)
            % HSN  'delta' :
            A1_t12_exp = exp( kx_I_t12_sc .* XS + ky_I_t12_sc .* YS_t);
            A2_t12_cos = k_R_t12_sc .* XS;
            %
            ZH_t = Amp_t_H .* A1_t12_exp .* cos(phi_tH .- A2_t12_cos);
            %
            % Neu für Border 2 am 15. May 2017 :
            A1_r2_exp = exp( kx_I_r23_sc .* XS + ky_I_r23_sc .* YS_r2);
            A2_r2_cos = k_R_r23_sc .* XS;
            A1_t2_exp = exp( kx_I_t23_sc .* XS + ky_I_t23_sc .* YS_t2);
            A2_t2_cos = k_R_t23_sc .* XS;
            %
            ZH_r2 = Amp_r2_H .* A1_r2_exp .* cos(phi_r2H .- A2_r2_cos);
            ZH_t2 = Amp_t2_H .* A1_t2_exp .* cos(phi_t2H .- A2_t2_cos);

            %
            % EPT :
            % neu 05. Sept. '14 : ZWEI 'Wellen generieren' :
            % dabei FÜR EPT-DARSTELLUNG  E_t  'kx_I_t12' und 'ky_I_t12' wichtig !
            % daher 'Typ 2' :
            ZP_tr_t = Amp_t_tr .* A1_t12_exp .* cos(phi_tE_tr .- A2_t12_cos);
            % neu 20. Mai 2017 , für Border #2 :
            ZP_tr_r2 = Amp_r2_tr .* A1_r2_exp .* cos(phi_r2E_tr .- A2_r2_cos);
            ZP_tr_t2 = Amp_t2_tr .* A1_t2_exp .* cos(phi_t2E_tr .- A2_t2_cos);
            % die longitudinale Welle ist AUCH vom 'Typ 2' :
            ZP_lo_t = Amp_t_lo .* A1_t12_exp .* cos(phi_tE_lo .- A2_t12_cos);
            % neu 20. Mai 2017 , für Border #2 :
            ZP_lo_r2 = Amp_r2_lo .* A1_r2_exp .* cos(phi_r2E_lo .- A2_r2_cos);
            ZP_lo_t2 = Amp_t2_lo .* A1_t2_exp .* cos(phi_t2E_lo .- A2_t2_cos);
            #
            # Das Sheet muss umgerechnet und "addiert"  werden " :
            %
            %      neu  05. Sept. '14 :
            %  die 'alte transversale' E_y-Komponente 
            %         UND
            %  die 'longitudinale' E_x-Komponente :
            %Ca *= scl_zxG;    Sa *= scl_zxG;     % falls die Amplituden zu groß werden
            %
            % incl. globaler Translation :
            XP_t = ZP_tr_t .* Cat12 + ZP_lo_t .* Sat12 .+ XGE_t;
            YP_t = ZP_tr_t .* Sat12 - ZP_lo_t .* Cat12 .+ YGE_t;
            % neu 20. Mai 2017 , für Border #2 :
            XP_r2 = ZP_tr_r2 .* (-Car23) + ZP_lo_r2 .* Sar23 .+ XGE_r2;
            YP_r2 = ZP_tr_r2 .* Sar23 + ZP_lo_r2 .* Car23 .+ YGE_r2;
            %
            XP_t2 = ZP_tr_t2 .* Cat23 + ZP_lo_t2 .* Sat23 .+ XGE_t2;
            YP_t2 = ZP_tr_t2 .* Sat23 - ZP_lo_t2 .* Cat23 .+ YGE_t2;
            %
            %          speichern :
            %
            % HSN :
            ZH_t_ges(ip, 1:i_y, 1:i_x) = ZH_t(1:i_y, 1:i_x);
            % neu 20. Mai 2017 , für Border #2 :
            ZH_r2_ges(ip, 1:i_y, 1:i_x) = ZH_r2(1:i_y, 1:i_x);
            ZH_t2_ges(ip, 1:i_y, 1:i_x) = ZH_t2(1:i_y, 1:i_x);
            % EPT :
            XP_t_ges(ip, 1:i_y, 1:i_x) = XP_t(1:i_y, 1:i_x);
            YP_t_ges(ip, 1:i_y, 1:i_x) = YP_t(1:i_y, 1:i_x);
            % neu 20. Mai 2017 , für Border #2 :
            XP_r2_ges(ip, 1:i_y, 1:i_x) = XP_r2(1:i_y, 1:i_x);
            YP_r2_ges(ip, 1:i_y, 1:i_x) = YP_r2(1:i_y, 1:i_x);
            XP_t2_ges(ip, 1:i_y, 1:i_x) = XP_t2(1:i_y, 1:i_x);
            YP_t2_ges(ip, 1:i_y, 1:i_x) = YP_t2(1:i_y, 1:i_x);
        else    % (upd_ZHt == False):
            % HSN :
            ZH_t(1:i_y, 1:i_x) = ZH_t_ges(ip, 1:i_y, 1:i_x);
            % neu 20. Mai 2017 , für Border #2 :
            ZH_r2(1:i_y, 1:i_x) = ZH_r2_ges(ip, 1:i_y, 1:i_x);
            ZH_t2(1:i_y, 1:i_x) = ZH_t2_ges(ip, 1:i_y, 1:i_x);
            % EPT :
            XP_t(1:i_y, 1:i_x) = XP_t_ges(ip, 1:i_y, 1:i_x);
            YP_t(1:i_y, 1:i_x) = YP_t_ges(ip, 1:i_y, 1:i_x);
            % neu 20. Mai 2017 , für Border #2 :
            XP_r2(1:i_y, 1:i_x) = XP_r2_ges(ip, 1:i_y, 1:i_x);
            YP_r2(1:i_y, 1:i_x) = YP_r2_ges(ip, 1:i_y, 1:i_x);
            XP_t2(1:i_y, 1:i_x) = XP_t2_ges(ip, 1:i_y, 1:i_x);
            YP_t2(1:i_y, 1:i_x) = YP_t2_ges(ip, 1:i_y, 1:i_x);
        endif
        %          Farben echt nach Phase neu 05.Nov.2016 :
        COLORS_tH = 6. .+ angle( exp( J .* ( phi_tH .+ phih_COLORS_t ) ) ) ./ pi;
        COLORS_tE = 6. .+ angle( exp( J .* ( phi_tE_tr .+ phih_COLORS_t ) ) ) ./ pi;
        % neu 20. Mai 2017 :
        COLORS_r2H = 4. .+ angle( exp( J .* ( phi_r2H .+ phih_COLORS_r2 ) ) ) ./ pi;
        COLORS_r2E = 4. .+ angle( exp( J .* ( phi_r2E_tr .+ phih_COLORS_r2 ) ) ) ./ pi;
        COLORS_t2H = 6. .+ angle( exp( J .* ( phi_t2H .+ phih_COLORS_t2 ) ) ) ./ pi;
        COLORS_t2E = 6. .+ angle( exp( J .* ( phi_t2E_tr .+ phih_COLORS_t2 ) ) ) ./ pi;
        %

        % für Octave :
        pause(T_view_Pause);	% plottet sonst NICHTS SICHTBARES !

        oldcol = Rframee;

          %               nur EINMAL generieren :
          if (oldcol == None)
              if( E_extra_fig)
                subplot(1, 2, 1);
                hax = hax1;
                  if( E_visible)
                    % Den '1. roten Doppel-Pfeil' HIER EINMAL generieren ! :
                    %     Pfeil-Anfang etwas hinter das Sheet t_12 : :
                    %xG_off_t = xG_cent + 0.1 + s_offset * Cat12;
                    %yG_off_t = yG_cent - 0.1 - (s_offset + h) * Sat12;
                    %    Versuch 2 :
                    xG_off_DirArrow = xG_cent + 0.1 + ...
                                      (s_offset + s_len + 0.1) * Sat12;
                    yG_off_DirArrow = yG_cent - 0.2 - 0.5 * s_wid * Sat12 - ...
                                      (s_offset + s_len + 0.1) * Cat12;
                    %  vorläufig geraten; sieht brauchbar aus :
                    arlen = 0.45; arwid = 0.3; arsepar = 0.1;
                    arpixw = 2; arcolor = 'r';
                    %
                    arsep2 = 0.5 * arsepar;     arwid2 = 0.5 * arwid;
                    har0 = arlen +arsep2;
                    har1 = har0 - arwid2;
                    %
                    %                11.11. 2017 'Pfeil #2' :
                    %     Pfeil-Ende FEST, etwas links oberhalb schieben :
                    % ( komplizierte x-Pos. : Sheet-Mitte bei 45 Grad und
                    %                         Rechts-Schieben an Border 2 gegen Überlappungen )
                    % Versuch 1 :
                    xarS2 = xG_cent + xG_off_B2 + s_len * scl_lam_123 + ...
                            s_wid * .5 /sqrt(2.)  + .75 * s_wid - .1;               % zu weit rechts ?
                    % Versuch 2 :
                    %xarS2 = xG_cent + xG_off_B2 + s_len * scl_lam_123 + ...
                    %        s_wid * .5 /sqrt(2.)  + .5 * s_wid - .1;           % NOCH zu weit rechts
                    yarS2 = yG_cent + yG_off_B2 + .1;
                    %
                    %     Pfeil-Anfang also bei :
                    xG_off2_DirArrow = xarS2 - har0 * Sat12;
                    yG_off2_DirArrow = yarS2 + har0 * Cat12;
                    %
                    %
                    %        Generiere Handle(s) und Arrow(s) :
                    %subplot(1, 2, 1);
                    [ali_11, ali_12, ali_13, ali_14] = Create_Direction_Arrow( ...
                                    xG_off_DirArrow, yG_off_DirArrow, ...
                                    arlen, arwid, ...
                                    arsepar, arpixw, alpha_t12, 'r');
                    [ali_21, ali_22, ali_23, ali_24] = Create_Direction_Arrow( ...
                                    xG_off2_DirArrow, yG_off2_DirArrow, ...
                                    arlen, arwid, ...
                                    arsepar, arpixw, alpha_t12, 'r');
                    %
                    %  Pfeil(e) auch in Subplot 2 ? erst einmal NICHT :
                    %subplot(1, 2, 2);
                    %[ali_31, ali_32, ali_33, ali_34] = Create_Direction_Arrow( ...
                    %                        xG_off_DirArrow, yG_off_DirArrow, ...
                    %                        arlen, arwid, ...
                    %                        arsepar, arpixw, alpha_t12, 'r');
                    %subplot(1, 2, 1);
                    %
                    % zunächst unsichtbar :
                    set(ali_11, 'visible', 'off');      set(ali_12, 'visible', 'off');
                    set(ali_13, 'visible', 'off');      set(ali_14, 'visible', 'off');
                    set(ali_21, 'visible', 'off');      set(ali_22, 'visible', 'off');
                    set(ali_23, 'visible', 'off');      set(ali_24, 'visible', 'off');
                    %

                  endif
              endif

            if (view_mode == 1)
              %
              if( E_extra_fig)
                subplot(1, 2, 1);
                %hax = hax1;
                  if( E_visible)
                      Rframee = surface( XP_e, YP_e, ZE_0, COLORS_eE, ...
                                         "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
                      set(Rframee, 'visible', 'on');
                      %
                      Rframer = surface( XP_r, YP_r, ZE_0, COLORS_rE, ...
                                         "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
                      set(Rframer, 'visible', 'on');
                      %
                      Rframet = surface( XP_t, YP_t, ZE_0, COLORS_tE, ...
                                         "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
                      set(Rframet, 'visible', 'on');
                      %
                      Rframer2 = surface( XP_r2, YP_r2, ZE_0, COLORS_r2E, ...
                                         "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
                      set(Rframer2, 'visible', 'on');
                      %
                      Rframet2 = surface( XP_t2, YP_t2, ZE_0, COLORS_t2E, ...
                                         "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
                      set(Rframet2, 'visible', 'on');
                      %
                      hidden('off');
                      %
                  endif
              endif
              %
              subplot(1, 2, 2);
              %hax = hax2;
              RframeeH = surface( XG_e, YG_e, ZH_e, COLORS_eH, ...
                                  "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
              set(RframeeH, 'visible', 'on');
              %
              RframerH = surface( XG_r, YG_r, ZH_r, COLORS_rH, ...
                                  "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
              set(RframerH, 'visible', 'on');
              %
              RframetH = surface( XG_t, YG_t, ZH_t, COLORS_tH, ...
                                  "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
              set(RframetH, 'visible', 'on');
              %
              Rframer2H = surface( XG_r2, YG_r2, ZH_r2, COLORS_r2H, ...
                                   "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
              set(Rframer2H, 'visible', 'on');
              %
              Rframet2H = surface( XG_t2, YG_t2, ZH_t2, COLORS_t2H, ...
                                   "facecolor", "w","edgecolor", "flat", "linewidth", 1.01 );
              set(Rframet2H, 'visible', 'on');
              %
              hidden('off');
              %
              subplot(1, 2, 1);
            %
            else
            %       d.h. if (view_mode == 2)
              %
              if( E_extra_fig)
                subplot(1, 2, 1);
                hax = hax1;
                  if( E_visible)
                      Rframee = surface( XP_e, YP_e, ZE_0, COLORS_eE, ...
                                         "edgealpha", w_edgealpha );
                      set(Rframee, 'visible', 'on');
                      %
                      Rframer = surface( XP_r, YP_r, ZE_0, COLORS_rE, ...
                                         "edgealpha", w_edgealpha );
                      set(Rframer, 'visible', 'on');
                      %
                      Rframet = surface( XP_t, YP_t, ZE_0, COLORS_tE, ...
                                         "edgealpha", w_edgealpha );
                      set(Rframet, 'visible', 'on');
                      %
                      Rframer2 = surface( XP_r2, YP_r2, ZE_0, COLORS_r2E, ...
                                          "edgealpha", w_edgealpha );
                      set(Rframer2, 'visible', 'on');
                      %
                      Rframet2 = surface( XP_t2, YP_t2, ZE_0, COLORS_t2E, ...
                                          "edgealpha", w_edgealpha );
                      set(Rframet2, 'visible', 'on');
                      %
                      hidden('on');
                      %
                  endif
              endif
              %
              %subplot(1, 2, 2);
              %hax = hax2;
%
              RframeeH = surface( XG_e, YG_e, ZH_e, COLORS_eH, ...
                                  "edgealpha", w_edgealpha );
              set(RframeeH, 'visible', 'on');
              %
              RframerH = surface( XG_r, YG_r, ZH_r, COLORS_rH, ...
                                  "edgealpha", w_edgealpha );
              set(RframerH, 'visible', 'on');
              %
              RframetH = surface( XG_t, YG_t, ZH_t, COLORS_tH, ...
                                  "edgealpha", w_edgealpha );
              set(RframetH, 'visible', 'on');
              %
              Rframer2H = surface( XG_r2, YG_r2, ZH_r2, COLORS_r2H, ...
                                   "edgealpha", w_edgealpha );
              set(Rframer2H, 'visible', 'on');
              %
              Rframet2H = surface( XG_t2, YG_t2, ZH_t2, COLORS_t2H, ...
                                   "edgealpha", w_edgealpha );
              set(Rframet2H, 'visible', 'on');
              %
              hidden('on');
              subplot(1, 2, 1);
              %hax = hax1;
            %
            endif
          endif

        hax = hax1;

        %
        %           neue globale Sheets plotten :
        %{
        % zuerst die Grenzflächen je zwischen zwei Medien einblenden :
        %   HIER "dynamisch" möglich	==>  z.B. Farben ändern
               es erleichtert mir u.a. das Erkennen der Phasenlagen aller Wellen,
               wenn in der ansonsten 'stetigen, ruhigen' Border-Palette 
               pro Periode EIN auffälliger 'Sprung diagonal durchläuft' :
        %}
        COLORS_bo = COLORS_bo0 .+ hco1;
        %
        % neu 24.Jul.2016 :
        set( RframebH, "cdata", COLORS_bo );
        % set( RframebH2, "cdata", COLORS_bo, "xdata", XBO2 ); % Diese 5 Zeilen verursachen handle Fehler !!!!!
        set( RframebH2, "cdata", COLORS_bo); % NUR 1. set
        set( RframebH2, "xdata", XBO2 ); % NUR 2. set
            if( ( E_extra_fig == True ) && ( E_visible == True ) )
                set( Rframeb, "cdata", COLORS_bo );
                %set( Rframeb2, "cdata", COLORS_bo, "xdata", XBO2 );
                set( Rframeb2, "cdata", COLORS_bo); % NUR 1. set
                set( Rframeb2, "xdata", XBO2 ); % NUR 2. set
            endif

        %
        % neu 30. Jul. 2016 :
        if (oldcol != None)
            %
              if( ( E_extra_fig) && ( E_visible) )
                    %
                    set(Rframee, "xdata", XP_e, "ydata", YP_e, "cdata", COLORS_eE);
                    %
                    set(Rframer, "xdata", XP_r, "ydata", YP_r, "cdata", COLORS_rE);
                    %
                    set(Rframet, "xdata", XP_t, "ydata", YP_t, "cdata", COLORS_tE);
                    %
                    set(Rframer2, "xdata", XP_r2, "ydata", YP_r2, "cdata", COLORS_r2E);
                    %
                    set(Rframet2, "xdata", XP_t2, "ydata", YP_t2, "cdata", COLORS_t2E);
                    %

                    %           Doppelpfeil ,  30.Okt.2017 = HIER ALT ! WIRD DANN FÜR JEDEN FRAME AUFGERUFEN !:
                    %       09.Dez.2017 : HINTER die for-loop ausgelagert
              endif
            %
            %
            set(RframeeH, "xdata", XG_e, "ydata", YG_e, "zdata", ZH_e, "cdata", COLORS_eH);
            %
            set(RframerH, "xdata", XG_r, "ydata", YG_r, "zdata", ZH_r, "cdata", COLORS_rH);
            %
            set(RframetH, "xdata", XG_t, "ydata", YG_t, "zdata", ZH_t, "cdata", COLORS_tH);
            %
            set(Rframer2H, "xdata", XG_r2, "ydata", YG_r2, "zdata", ZH_r2, "cdata", COLORS_r2H);
            %
            set(Rframet2H, "xdata", XG_t2, "ydata", YG_t2, "zdata", ZH_t2, "cdata", COLORS_t2H);
            %
        endif

        phi += d_phi;
    endfor


% Anfang neu 09. Dez.. 2017 :
    %Versuch 1, den/die Doppelpfeile aus der Phasen-for-loop herauszunehmen (DAHINTER) :

              if( ( (E_extra_fig) && ( E_visible) ) && ( Dir_Arrow_flag) )
                    if( xG_off_flag)
                        %                Aktionen  im Fall 'kein Pfeil' :
                        %
                        %                Versuche 1-B und 2  im Fall 'kein Pfeil' :
                        %   eigene Funktion Create_Direction_Arrow :
                        set(ali_11, 'visible', 'off');      set(ali_12, 'visible', 'off');
                        set(ali_13, 'visible', 'off');      set(ali_14, 'visible', 'off');
                        set(ali_21, 'visible', 'off');      set(ali_22, 'visible', 'off');
                        set(ali_23, 'visible', 'off');      set(ali_24, 'visible', 'off');
                        %
                    else
                        %                Aktionen  im Fall 'Pfeil zeigen' :
                        %
                        xG_off_DA = xar0 = xG_cent + 0.1 + ...
                                         (s_offset + s_len + 0.1) * Sat12;
                        yG_off_DA = yar0 = yG_cent - 0.2 - 0.5 * s_wid * Sat12 - ...
                                         (s_offset + s_len + 0.1) * Cat12;
                        %
                        % 11. Nov. 2017 Pfeil 2 :
                        % Spitze fest (xarS2, yarS2) :
                        xG_off2_DA = xar20 = xarS2 - har0 * Sat12;
                        yG_off2_DA = yar20 = yarS2 + har0 * Cat12;
                        %
                        aralpha = alpha_t12;
                        %
                        %                Versuch 1-B                  BEGINN  :
                        %   eigene Funktion Create_Direction_Arrow  HIER ALS 'inline Octave' :
                        %%
                        h2C = arsep2 * Cat12;     h2S = arsep2 * Sat12;
                        h3C = har1 * Cat12;       h3S = har1 * Sat12;
                        h4C = arlen * Cat12;      h4S = arlen * Sat12;
                        h5C = arwid2 * Cat12;     h5S = arwid2 * Sat12;
                        %%
                        x0o = xar0 + h2C;         y0o = yar0 + h2S;
                        xEo = x0o + h4S;          yEo = y0o - h4C;
                        %%
                        x0u = xar0 - h2C;         y0u = yar0 - h2S;
                        xEu = x0u + h4S;          yEu = y0u - h4C;
                        %%
                        xAo = xar0 + h3S + h5C;   yAo = yar0 + h5S - h3C;
                        xAu = xar0 + h3S - h5C;   yAu = yar0 - h5S - h3C;
                        %%
                        xarS = xar0 + har0 * Sat12;     yarS = yar0 - har0 * Cat12;
                        %%
                        %
                        % 11. Nov. 2017 Pfeil 2 :
                        %%
                        x02o = xar20 + h2C;         y02o = yar20 + h2S;
                        xE2o = x02o + h4S;          yE2o = y02o - h4C;
                        %%
                        x02u = xar20 - h2C;         y02u = yar20 - h2S;
                        xE2u = x02u + h4S;          yE2u = y02u - h4C;
                        %%
                        xA2o = xar20 + h3S + h5C;   yA2o = yar20 + h5S - h3C;
                        xA2u = xar20 + h3S - h5C;   yA2u = yar20 - h5S - h3C;
                        %
                        %                Versuch 1-B    INLINE        ENDE
                        %
                        %            Versuch 2                        BEGINN :
                        %
                        set(ali_11, "xdata", [x0o, xEo], "ydata", [y0o, yEo], "visible", "on" );
                        set(ali_12, "xdata", [x0u, xEu], "ydata", [y0u, yEu], "visible", "on" );
                        set(ali_13, "xdata", [xAo, xarS], "ydata", [yAo, yarS], "visible", "on" );
                        set(ali_14, "xdata", [xAu, xarS], "ydata", [yAu, yarS], "visible", "on" );
                        %
                        % 11. Nov. 2017 Pfeil 2 :
                        %
                        set(ali_21, "xdata", [x02o, xE2o], "ydata", [y02o, yE2o], "visible", "on" );
                        set(ali_22, "xdata", [x02u, xE2u], "ydata", [y02u, yE2u], "visible", "on" );
                        set(ali_23, "xdata", [xA2o, xarS2], "ydata", [yA2o, yarS2], "visible", "on" );
                        set(ali_24, "xdata", [xA2u, xarS2], "ydata", [yA2u, yarS2], "visible", "on" );
                        %
                        %            Versuch 2                        ENDE
                    endif
              endif


    % Speed :
    % alt, für 'CPU-time geeignet :
    %FPS = i_phi / ( time() - tstart );
    % neu 04. Mar. 2016, für Echtzeit :
    FPS = i_phi / etime (clock (), tstart);
    disp(['   FPS : ', num2str( FPS)]);
    %
    % FPS im BILD einblenden : 
    %        Rolf, 25.Sep.2018 :
    %h2 = [" FPS : " sprintf('%9.2f', FPS) " 1/s "];
    %set( annot_4, "string", h2);
    set( annot_4, "string", [" FPS : " sprintf('%9.2f', FPS) " 1/s "]);

    % gehören hierher, hinter die "for ip"-loop : 
    N_periods += 1;
    FPS_Avg = ( (N_periods -1) * FPS_Avg + FPS ) / N_periods;
    FPS_Max = max(FPS, FPS_Max);    FPS_Min = min(FPS, FPS_Min);
    %
    %    Darstellungs-Framerate, ggfs. Anpassung :
    N_periods_2 +=1;
    FPS_Avg_2 = ( (N_periods_2 -1) * FPS_Avg_2 + FPS ) / N_periods_2;
    FPS_Max_2 = max(FPS, FPS_Max_2);    FPS_Min_2 = min(FPS, FPS_Min_2);
        if( ( auto_spd_FPS == True ) && ( N_periods_2 > 10 ) )
          % bekannt :  T_frame_wanted = 1. / FPS_wanted
            if( FPS_Avg_2 > ( 1.005 * FPS_wanted ) )
                %       'speed down' ;  'sinnvoll berechnen' :
                %     [ ignoriert Max, Min, Streuung etc. ]
                h1 =  T_frame_wanted - 1. / FPS_Avg_2;
                T_view_Pause += h1;
            elseif( ( FPS_Avg_2 < ( 0.995 * FPS_wanted ) ) && ( T_view_Pause > 1.5e-9 ) )
                %       'speed up' ;  'sinnvoll berechnen' 04. Aug. 2016 :
                %     [ ignoriert Max, Min, Streuung etc. ]
                h1 = T_frame_wanted - 1. / FPS_Avg_2;
                T_view_Pause += h1;
            endif
            % Reset :
            N_periods_2 = 0;
            FPS_Max_2 = FPS_Avg_2 = 0;    FPS_Min_2 = 1000;
        endif

    first_Period = False;
    %compute_Sheets = False;
    upd_ZHe = False;	upd_ZHr = False;	upd_ZHt = False;

      if(inc_flag)   
		if(alpha_inc_flag)
            freqWi_current = alpha_e12;
        elseif(freq_inc_flag)
            freqWi_current = freq;
        endif
          if( !mod(N_periods, iruns_inc) )	%  alle 'iruns_inc Perioden' Winkel ändern
              if (first_run)
				  %        Variable für 'static plots' in Vektoren sammeln :
                  if (alpha_inc_flag)
                        uv_1(i_inc_var) = alpha_e12 / radw;
                  elseif (freq_inc_flag)
                        uv_1(i_inc_var) = freqWi_current;
                  endif
                  k_R_t12_paral(i_inc_var) = k_R_t12 * scl_om;     % wieder die echte Bedeutung
                  k_I_t12_paral(i_inc_var) = k_I_t12 * scl_om;
                  alpha_t12_paral(i_inc_var) = alpha_t12;
                  psi_t12_paral(i_inc_var) = psi_t12;
                  r12_paral(i_inc_var) = r12_paral;
                  t12_paral(i_inc_var) = t12_paral;
                  Z_FW_t_tr(i_inc_var) = Z_W_2_tr;
                  Z_FW_t_lo(i_inc_var) = Z_W_2_lo;
                  %   Neu 20. Mai 2017 fuer Border # 2 :
                  if (alpha_inc_flag)
                        uv_2(i_inc_var) = alpha_e23 / radw;
                  elseif (freq_inc_flag)
						uv_2(i_inc_var) = freqWi_current;
                  endif;
                  k_R_t23_paral(i_inc_var) = k_R_t23 * scl_om;     % wieder die echte Bedeutung
                  k_I_t23_paral(i_inc_var) = k_I_t23 * scl_om;
                  alpha_t23_paral(i_inc_var) = alpha_t23;
                  psi_t23_paral(i_inc_var) = psi_t23;
                  r23_paral(i_inc_var) = r23_paral;
                  t23_paral(i_inc_var) = t23_paral;
                  Z_FW_t2_tr(i_inc_var) = Z_W_3_tr;
                  Z_FW_t2_lo(i_inc_var) = Z_W_3_lo;
                  %    ende Neu
                  i_inc_var += 1;
              endif
              if ( (freqWi_current >= freqWi_max) && (freqWi_inc > 0.) )
                  freqWi_inc *= -1.;		% Richtung Winkel-Änderung umkehren
                  dfreq *= -1.;			 % Richtung Frequenz-Änderung umkehren
                    # AB HIER ALLES NUR EINMAL und NUR WENN GEWÜNSCHT :
                    if ( (first_run == True)  && (static_plots == True) )
                      [p_handles, p_errors] = additional_Plots_TM_1( legend_flag, uv_1, uv_2, ...
                           k_R_t12_paral, k_I_t12_paral, alpha_t12_paral, psi_t12_paral, ...
                           Z_FW_t_tr, Z_FW_t_lo, ...
                           k_R_t23_paral, k_I_t23_paral, alpha_t23_paral, psi_t23_paral, ...
                           Z_FW_t2_tr, Z_FW_t2_lo, ...
                           r12_paral, t12_paral, r23_paral, t23_paral);
                      %
                      disp(' PAUSE !    Weiter mit Taste ...');
                      pause();
                      % reset focus to figure 1 :
                      figure(1);
                      % hiernach ist manchmal die Framerate im Eimer !
                      %graphics_toolkit( 'fltk');        # ein Versuch ! (nutzlos)
                      % Test ==> man muss evtl. manuell alle figures 2 ... 17 wieder LÖSCHEN,  FPS schnell !
                      %
                      first_run = False;        # RESET
                    endif
              elseif ( (freqWi_current <= freqWi_min) && (freqWi_inc < 0.) )
                  freqWi_inc *= -1.;     % Richtung Winkel-Änderung umkehren
                  dfreq *= -1.;			 % Richtung Frequenz-Änderung umkehren
              endif

			% 17. Jan. 2019 André: erweitert um if-Bedingung (für freq und Wi)
			if (alpha_inc_flag)
				alpha_e12 += freqWi_inc;
				set( annot_3, "string", [" Einfallswinkel = " sprintf('%9.2f', alpha_e12/radw) " Grad "] );
			elseif (freq_inc_flag)
				freq_inc_var += dfreq;
				freq += freqWi_inc;
				% Frequenz aktualisieren:
				set( annot_2, "string", [" Frequenz = " sprintf('%12.5e', freq) " Hz "]);
				% Material 1 aktualisieren:
				h2 = [ sprintf('%9.3f', eps_r1_array(freq_inc_var)) ' '];
				h3 = [ sprintf('%9.3f', mue_r1_array(freq_inc_var)) ' '];
				h4 = [ sprintf('%11.4e', kap_1_array(freq_inc_var)) ' Ohm*m '];
				set( annot_5, 'string', [ 
							  [' \epsilon_{ r,1} = ' h2 ]; ...
							  ' '; ...
							  [' \mu_{ r,1} = ' h3 ]; ...
							  ' '; ...
							  [' \kappa_{ 1} = ' h4 ];...
							   ' ' ] );
				% Material 2 aktualisieren:
				h2 = [ sprintf('%9.3f', eps_r2_array(freq_inc_var)) ' '];
				h3 = [ sprintf('%9.3f', mue_r2_array(freq_inc_var)) ' '];
				h4 = [ sprintf('%11.4e', kap_2_array(freq_inc_var)) ' Ohm*m '];
				set( annot_6, 'string', [ 
							  [' \epsilon_{ r,2} = ' h2 ]; ...
							  ' '; ...
							  [' \mu_{ r,2} = ' h3 ]; ...
							  ' '; ...
							  [' \kappa_{ 2} = ' h4 ];...
							   ' '  ] );
				% Material 3 aktualisieren:
				h2 = [ sprintf('%9.3f', eps_r3_array(freq_inc_var)) ' '];
				h3 = [ sprintf('%9.3f', mue_r3_array(freq_inc_var)) ' '];
				h4 = [ sprintf('%11.4e', kap_3_array(freq_inc_var)) ' Ohm*m '];
				set( annot_7, 'string', [ 
							  [' \epsilon_{ r,3} = ' h2 ]; ...
							  ' '; ...
							  [' \mu_{ r,3} = ' h3 ]; ...
							  ' '; ...
							  [' \kappa_{ 3} = ' h4 ];...
							   ' '  ] );		
				freq_eq = True	
			endif

            %h2 = strcat( " Einfallswinkel in Grad = ", sprintf('%9.2f', alpha_e12/radw), " ");
            %set( annot_3, "string", h2);
            %set( annot_3, "string", [" Einfallswinkel = " sprintf('%9.2f', alpha_e12/radw) " Grad "] );

            upd_BSe = True; 	upd_BSr = True;		upd_BSt = True;
            upd_ZHe = True; 	upd_ZHr = True;		upd_ZHt = True;
          endif
      endif
    %

  %else     %   (compute_Sheets == False)
    %XY = num2str(s_len);
    %out_f_NAME = "./SN_1_" + XY + "_blabla.asc";
    %out_f_name = open(out_f_NAME, 'w');
    %in_f_NAME = "./mp_Koeffs_" + XY + "_blabla.asc";
    %in_f_name = open(in_f_NAME, 'r');
    %
  endif

  endwhile