%% Author: atamborrino
%% Created: 10 Sep 2012
%% Description: TODO: Add description to hist
-module(hist).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([new/1,update/3]).

%%
%% API Functions
%%

new(Name) ->
    D = dict:new(),
    dict:append(Name, inf, D).

update(Node, N, History) ->
    case dict:find(Node, History) of
        {ok,[Value|_]} ->
            if
                N > Value ->
                    Dict1 = dict:erase(Node, History),
                    Dict2 = dict:append(Node, N, Dict1),
                    {new, Dict2};
                true -> 
                    old
            end;
        error ->
            {new, dict:append(Node, N, History)}
    end.
        
                    


%%
%% Local Functions
%%

