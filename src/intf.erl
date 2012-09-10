%% Author: atamborrino
%% Created: 10 Sep 2012
%% Description: TODO: Add description to intf
-module(intf).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([add/4,broadcast/2,list/1,lookup/2,name/2,new/0,ref/2,remove/2]).

%%
%% API Functions
%%

new() ->
    [].

add(Name,Ref,Pid,Intf) ->
    case lists:member({Name,Ref,Pid}, Intf) of
        true ->
                Intf;
        false ->
                [{Name,Ref,Pid} | Intf]
    end.
            

remove(Name,Intf) ->
    lists:delete(Name, Intf).

lookup(Name,Intf) ->
    case lists:keyfind(Name, 1, Intf) of
        {_,_,Pid} ->
            {ok,Pid};
        false ->
            notfound
    end.

ref(Name,Intf) ->
    case lists:keyfind(Name, 1, Intf) of
        {_,Ref,_} ->
            {ok,Ref};
        false ->
            notfound
    end.

name(Ref,Intf) ->
    case lists:keyfind(Ref, 2, Intf) of
        {Name,_,_} ->
            {ok,Name};
        false ->
            notfound
    end.

list(Intf) ->
    [Name || {Name,_,_} <- Intf].

broadcast(Message,Intf) ->
    lists:foreach(fun({_,_,Pid})->
                          Pid ! Message
                          end, Intf).
    


%%
%% Local Functions
%%

