%% Author: atamborrino
%% Created: 10 Sep 2012
%% Description: TODO: Add description to maintest
-module(maintest).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([sweden/0,france/0,go/0,join_swe_fr/0]).

%%
%% API Functions
%%

-define(NODE_FR,'france@192.168.1.5').
-define(NODE_SWE,'sweden@192.168.1.5').


sweden() ->
    routy:start(stockholm),
    routy:start(malmo),
    malmo ! {add,stockholm,{stockholm,?NODE_SWE}},
    stockholm ! {add,malmo,{malmo,?NODE_SWE}}.

france() ->
    routy:start(lille),
    routy:start(paris),
    lille ! {add,paris,{paris, ?NODE_FR}},
    paris ! {add,lille,{lille, ?NODE_FR}}.

join_swe_fr() ->
    {malmo,?NODE_SWE} ! {add,lille,{lille,?NODE_FR}},
    {lille,?NODE_FR} ! {add,malmo,{malmo,?NODE_SWE}}.

go() ->
    Routers = [{paris, ?NODE_FR},{lille, ?NODE_FR},{malmo, ?NODE_SWE},{stockholm, ?NODE_SWE}],
    lists:foreach(fun(Router) -> Router ! broadcast end, Routers),
    timer:sleep(1000),
    lists:foreach(fun(Router) -> Router ! update end, Routers).


