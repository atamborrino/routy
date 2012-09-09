%% Author: atamborrino
%% Created: 9 Sep 2012
%% Description: TODO: Add description to djikstra
-module(dijkstra).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([table/2,route/2]).

%%
%% API Functions
%%

route(Node,Table) ->
    case lists:keyfind(Node, 1, Table) of
        {Dest,Gateway}->
            {ok,Gateway};
        false ->
            notfound
    end.

table(Gateways, Map) ->
    AllNodes = map:all_nodes(Map),
    InitialSortedList = lists:keysort(2, lists:map(fun(El) ->
                                              case lists:member(El, Gateways) of
                                                  true ->
                                                      {El,0,El};
                                  
                                                  false ->
                                                      {El,inf,unknown}
                                              end
                                              end, AllNodes)),
    iterate(InitialSortedList, Map, []).

            
%%
%% Local Functions
%%

update(Node, N, Gateway, Sorted) ->
    L = entry(Node,Sorted),
    case (N < L) of
        true ->
            replace(Node, N, Gateway, Sorted);
        false ->
            Sorted
    end.

iterate(Sorted, Map, Table) ->
    case Sorted of
        [] ->
            Table;
        [{_,inf,_}|_] ->
            Table;
        [Entry|T] ->
            {Dest,L,Gateway} = Entry,
            case lists:keyfind(Dest, 1, Map) of
                {_,Reachables} ->
                    NewSortedList = lists:foldl(fun(El,SortedList) ->
                                        update(El,L+1,Gateway,SortedList)
                                        end, T, Reachables);
                false ->
                    NewSortedList = T   
            end,
            iterate(NewSortedList,Map,[{Dest,Gateway} | Table])           
    end.

entry(Node,Sorted) ->
    case lists:keyfind(Node, 1, Sorted) of
        {_,L,_} -> L;
        false -> 0
    end.

replace(Node,N,Gateway,Sorted) ->
    Tmp = lists:keyreplace(Node, 1, Sorted, {Node,N,Gateway}),
    lists:keysort(2, Tmp).

