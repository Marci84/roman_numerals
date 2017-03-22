%%%-------------------------------------------------------------------
%% @doc roman_numerals public API
%% @end
%%%-------------------------------------------------------------------

-module(roman_numerals_app).

%%-behaviour(application).

%% Application callbacks
-export([arabic_to_roman/1,format_input/1,roman_to_arab/1]).

%%====================================================================
%% API
%%====================================================================

%% start(_StartType, _StartArgs) ->
%%     roman_numerals_sup:start_link().

%%--------------------------------------------------------------------
%% stop(_State) ->
%%     ok.

%%====================================================================
%% Internal functions
%%====================================================================


arabic_to_roman(Number)->
    List_Number = format_input(Number),
    case List_Number < 5000 of
        true ->
            convert(List_Number,[]);
        false ->
            io:format("The provided number is too high to convert~n")
    end.


format_input(Number)->
    case Number of
        Number when is_list(Number)  ->
            list_to_integer(Number);
        Number when is_integer(Number) ->
            Number;
        _ ->
            io:format("Incorrect number format : ~p~n",[Number]),
            no_number
    end.

convert(Number,List)->
    case Number of
        Number when (Number - 1000) >= 0 ->
            convert(Number - 1000,List ++ "M");
        Number when (Number - 900) >= 0 ->
            convert(Number - 900,List ++ "CM");
        Number when (Number - 500) >= 0 ->
            convert(Number - 500,List ++ "D");
        Number when (Number - 400) >= 0 ->
            convert(Number - 400,List ++ "CD");
        Number when (Number - 100) >= 0 ->
            convert(Number - 100,List ++ "C");
        Number when (Number - 90) >= 0 ->
            convert(Number - 90,List ++ "XC");
        Number when (Number - 50) >= 0 ->
            convert(Number - 50,List ++ "L");
        Number when (Number - 40) >= 0 ->
            convert(Number - 40,List ++ "XL");
        Number when (Number - 10) >= 0 ->
            convert(Number - 10,List ++ "X");
        Number when (Number - 9) >= 0 ->
            convert(Number - 9,List ++ "IX");
        Number when (Number - 5) >= 0 ->
            convert(Number - 5,List ++ "V");
        Number when (Number - 4) >= 0 ->
            convert(Number - 4,List ++ "IV");
        Number when (Number - 1) >= 0 ->
            convert(Number - 1,List ++ "I");
        _ ->
            List
    end.


roman_to_arab(Number)->
    convert_to_arab(Number,0).


convert_to_arab([],Result)->
    Result;
convert_to_arab([H|[]],Result)->
    convert_normal(H,Result);
convert_to_arab([H|T],Result) ->
    Next_element = [lists:nth(1,T)],
    Value = case [H]++ Next_element of
                "CM" ->
                    Converted_value = convert_exeption("CM",Result),
                    {[H|T] -- "CM",Converted_value};
                "CD" ->
                    Converted_value =convert_exeption("CD",Result),
                    {[H|T] -- "CD",Converted_value};
                "XC" ->
                    Converted_value = convert_exeption("XC",Result),
                    {[H|T] -- "XC",Converted_value};
                "XL" ->
                    Converted_value = convert_exeption("XL",Result),
                    {[H|T] -- "XL",Converted_value};
                "IX" ->
                    Converted_value =  convert_exeption("IX",Result),
                    {[H|T] -- "IX",Converted_value};
                "IV" ->
                    Converted_value =  convert_exeption("IV",Result),
                    {[H|T] -- "IV",Converted_value};
                _ ->
                    Converted_value =  convert_normal(H,Result),
                    {T,Converted_value}
            end,
    {List,V} = Value,
    convert_to_arab(List,V).
                
convert_normal(Number,Result)->    
    case [Number] of
        "M" ->
            Result + 1000;
        "D" ->
            Result + 500;
        "C" ->
            Result + 100;
        "L" ->
            Result + 50;
        "X" ->
            Result + 10;
        "V" ->
            Result + 5;
        "I" ->
            Result + 1
    end.

convert_exeption(Number,Result)->
    case Number of
        "CM" ->
            Result + 900;
        "CD" ->
            Result + 400;
        "XC" ->
            Result + 90;
        "XL" ->
            Result + 40;
        "IX" ->
            Result + 9;
        "IV" ->
            Result + 4;
        _ ->
            io:format("Invalid character : ~p~n,",[Number]),
            Result                
    end.
    
