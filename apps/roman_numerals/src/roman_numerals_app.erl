%%%-------------------------------------------------------------------
%% @doc roman_numerals public API
%% @end
%%%-------------------------------------------------------------------

-module(roman_numerals_app).

%%-behaviour(application).

%% Application callbacks
-export([arabic_to_roman/1,format_input/1]).

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
