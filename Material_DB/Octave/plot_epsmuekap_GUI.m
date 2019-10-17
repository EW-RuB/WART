addpath("../Octave/");

arg_list = argv();


emk_Data = zeros(20, 1, "double");


emk_Data(1,1) = str2num(arg_list{1});


for m = 1:20
	emk_Data(m) = str2num(arg_list{m});
endfor


f_low = emk_Data(19);	f_high = emk_Data(20);
N_Test = str2num(arg_list{21});


f_test = linspace( f_low, f_high, N_Test);

    for n = 1:N_Test
        %
        f_akt = f_test(n);
        %
        [eps_rO, mue_rO, kappaO] = build_epsmuekap_main_01( f_akt, emk_Data);
        %
        eps_r_1(n) = eps_rO;        mue_r_1(n) = mue_rO;         kappa_1(n) = kappaO;
    endfor

figure(1)
plot( f_test, eps_r_1, 'r');
title('eps_r_1');

figure(2)
plot( f_test, kappa_1, 'm');
title('kappa_1');

figure(3)
plot( f_test, mue_r_1, 'b');
title('mue_r_1')


pause();
