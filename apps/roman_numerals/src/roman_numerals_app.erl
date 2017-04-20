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
    Int_Number = format_input(Number),
    case Int_Number < 5000 of
        true ->
            convert(Int_Number,[]);
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
    Result = check_syntax(Number,[]),
    case lists:keyfind(error,1,Result) of
        false ->
            convert_to_arab(Number,0);        
        Tuple ->
            io:format("Invalid character(s) in roman number : ~p~n",[Tuple]),
            Result
    end.

check_syntax([],List) ->
    lists:flatten(List);
check_syntax([H|T],List)->
    Valid_characters = "MDCLXVI",
    Result =   case lists:member(H,Valid_characters) of
                   true ->
                       {ok,[H]};
                   false ->
                       {error,[H]}
               end,
    check_syntax(T,List ++ [Result]).


convert_to_arab([],Result)->
    Result;
convert_to_arab([H],Result)->
    Result + convert_normal(H);
convert_to_arab([H,H2|T],Result)->
    First = convert_normal(H),
    Second = convert_normal(H2),
    case First >= Second of
                       true ->
            convert_to_arab([H2|T], Result + First);
                       false ->
            convert_to_arab(T,Result - First + Second)
    end.



convert_normal(Number)->    
    case [Number] of
        "M" ->
            1000;
        "D" ->
            500;
        "C" ->
            100;
        "L" ->
            50;
        "X" ->
            10;
        "V" ->
            5;
        "I" ->
            1
    end.
