%% Author: atamborrino
%% Created: 9 Sep 2012
%% Description: TODO: Add description to map
-module(map).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([new/0,all_nodes/1,reachable/2,update/3]).

%%
%% API Functions
%%

new() ->
	[].

update(Node,Links,Map) ->
	Tmp = lists:keydelete(Node, 1, Map),	
	[{Node,Links} | Tmp].

reachable(Node,Map) ->
	case lists:keyfind(Node, 1, Map) of
		{_,Links} ->
			Links;
		false ->
			[]
	end.

all_nodes(Map) ->
	FlattenedMap = lists:flatmap(fun({Node,Links}) -> [Node|Links] end, Map),
	lists:foldl(fun(El,Acc) ->
					   case {El,Acc} of
						   {El,[El|_]} ->
							   Acc;
						   _ ->
							   [El|Acc]
					   end
		   		   end,
			    [], lists:sort(FlattenedMap)).



