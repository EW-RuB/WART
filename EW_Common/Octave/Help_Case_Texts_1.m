function Help_Case_Texts_1( sub_case_str)

%{

PLANE WAVES, REFLECTION and REFRACTION
       Rolf Poddig
       
                     Brechungs-Fall-abhaengige Hilfstexte ausgeben 
    # Rolf :
    # 
    #    je fuer Border #1 und #2 und je fuer Fall a oder b passende Texte
%

Started on Jun.  02., 2017
Last Changes on Jun.  04., 2017
%}

%{
                       History :

 04. Jun.  2017 :  - Code Strings weiter

 02. Jun.  2017 :  - Beginn als Auslagerung 
%}



% neu 02. Jun. 2017 :
%   Fall-abhaengige Texte automatisch auswaehlen und darstellen :

case_bo_1 = substr(sub_case_str, 1, 2);     case_bo_2 = substr(sub_case_str, 3, 2);


    if ( case_bo_1 == '1a' )
        disp([' ', 
              '              Beginn Fall 1_a_delta an Border 1 :',
              '"Fall 1" bedeutet Brechung zum Lot HIN ,',
              '             und']);
        Text_Fall_a_1();
    elseif ( case_bo_1 == '1b' )
        disp([' ', 
              '              Beginn Fall 1_b_delta an Border 1 :',
              '"Fall 1" bedeutet Brechung zum Lot HIN ,',
              '             und']);
        Text_Fall_b_1();
    elseif ( case_bo_1 == '2a' )
        disp([' ', 
              '              Beginn Fall 2_a_delta an Border 1 :',
              '"Fall 2" bedeutet Brechung vom Lot WEG ,',
              '             und']);
        Text_Fall_a_1();
    else        %if ( case_bo_1 == '2b' )
        disp([' ', 
              '              Beginn Fall 2_b_delta an Border 1 :',
              '"Fall 2" bedeutet Brechung vom Lot WEG ,',
              '             und']);
        Text_Fall_b_1();
    endif


    if ( case_bo_2 == '1a' )
        disp([' ', 
              '              Beginn Fall 1_a_delta an Border 2 :',
              '"Fall 1" bedeutet Brechung zum Lot HIN ,',
              '             und']);
        Text_Fall_a_2();
    elseif ( case_bo_2 == '1b' )
        disp([' ', 
              '              Beginn Fall 1_b_delta an Border 2 :',
              '"Fall 1" bedeutet Brechung zum Lot HIN ,',
              '             und']);
        Text_Fall_b_2();
    elseif ( case_bo_2 == '2a' )
        disp([' ', 
              '              Beginn Fall 2_a_delta an Border 2 :',
              '"Fall 2" bedeutet Brechung vom Lot WEG ,',
              '             und']);
        Text_Fall_a_2();
    else        %if ( case_bo_2 == '2b' )
        disp([' ', 
              '              Beginn Fall 2_b_delta an Border 2 :',
              '"Fall 2" bedeutet Brechung vom Lot WEG ,',
              '             und']);
        Text_Fall_b_2();
    endif


endfunction
