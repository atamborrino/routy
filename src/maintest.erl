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
-export([sweden/0,france/0,go/0,join_swe_fr_uk/0,uk/0]).

%%
%% API Functions
%%

-define(NODE_FR,'france@192.168.1.5').
-define(NODE_SWE,'sweden@192.168.1.5').
-define(NODE_UK,'uk@192.168.1.5').


sweden() ->
    routy:start(stockholm),
    routy:start(malmo),
    malmo ! {add,stockholm,{stockholm,?NODE_SWE}},
    stockholm ! {add,malmo,{malmo,?NODE_SWE}}.

uk() ->
    routy:start(london).

france() ->
    routy:start(lille),
    routy:start(paris),
    lille ! {add,paris,{paris, ?NODE_FR}},
    paris ! {add,lille,{lille, ?NODE_FR}}.

join_swe_fr_uk() ->
    {malmo,?NODE_SWE} ! {add,lille,{lille,?NODE_FR}},
    {lille,?NODE_FR} ! {add,malmo,{malmo,?NODE_SWE}},
    {london,?NODE_UK} ! {add,stockholm,{stockholm,?NODE_SWE}},
    {london,?NODE_UK} ! {add,paris,{paris,?NODE_FR}},
    {paris,?NODE_FR} ! {add,london,{london,?NODE_UK}},
    {stockholm,?NODE_SWE} ! {add,london,{london,?NODE_UK}}.

go() ->
    Routers = [{paris, ?NODE_FR},{lille, ?NODE_FR},{malmo, ?NODE_SWE},{stockholm, ?NODE_SWE},{london,?NODE_UK}],
    lists:foreach(fun(Router) -> Router ! broadcast end, Routers),
    timer:sleep(1000),
    lists:foreach(fun(Router) -> Router ! update end, Routers).



