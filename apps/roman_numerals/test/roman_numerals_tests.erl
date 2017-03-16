-module(roman_numerals_tests).
-include_lib("eunit/include/eunit.hrl").

convert_test()->
    Result = roman_numerals_app:arabic_to_roman(1),
    ?assertEqual("I",Result),
    Result2 = roman_numerals_app:arabic_to_roman(2),
    ?assertEqual("II",Result2),
    Result3 = roman_numerals_app:arabic_to_roman("3"),
    ?assertEqual("III",Result3),
    Result4 = roman_numerals_app:arabic_to_roman(4),
    ?assertEqual("IV",Result4),
    Result5 = roman_numerals_app:arabic_to_roman("8"),
    ?assertEqual("VIII",Result5),   
    Result6 = roman_numerals_app:arabic_to_roman(9),
    ?assertEqual("IX",Result6),
    Result7 = roman_numerals_app:arabic_to_roman(10),
    ?assertEqual("X",Result7),
    Result8 = roman_numerals_app:arabic_to_roman("15"),
    ?assertEqual("XV",Result8),
    Result9 = roman_numerals_app:arabic_to_roman(49),
    ?assertEqual("XLIX",Result9),
    Result10 = roman_numerals_app:arabic_to_roman("999"),
    ?assertEqual("CMXCIX",Result10).

format_input_test()->
    Integer_to_list = roman_numerals_app:format_input(123),
    List = roman_numerals_app:format_input("123"),
    ?assertEqual(123,Integer_to_list),
    ?assertEqual(123,List).
    
