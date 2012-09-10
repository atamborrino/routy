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
        {ok,Value} ->
            if
                N > Value ->
                    {new, dict:update(Node, fun(Value) -> N end, History)};
                true -> 
                    old
            end;
        error ->
            {new, dict:append(Node, N, History)}
    end.
        
                    


%%
%% Local Functions
%%

