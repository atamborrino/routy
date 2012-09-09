%% Author: atamborrino
%% Created: 9 Sep 2012
%% Description: TODO: Add description to test
-module(map_tests).

%%
%% Include files
%%

-include_lib("eunit/include/eunit.hrl").

%%
%% Exported Functions
%%

new_test() ->
	?assertEqual([],map:new()).

reachable_test() ->
	?assertEqual([], map:reachable(london, [{berlin,[london,paris]}])),
	?assertEqual([london,paris], map:reachable(berlin, [{berlin,[london,paris]}])).
	
update_test() ->
	?assertEqual([{berlin,[madrid]}], map:update(berlin, [madrid],[{berlin,[lol]}])),
	?assertEqual([{berlin,[london,paris]}],map:update(berlin, [london, paris], [])).

all_nodes_test() ->
	?assertEqual([paris,london,berlin], map:all_nodes([{berlin,[london,paris]}])).

