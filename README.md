routy
=====

A small routing protocol based on link-state and implemented in Erlang (academic lab project).

Fault-tolerancy is handled (try to add then crash routers). Scaling is limited because each router builds a routing table for the entire network. It would be interesting to implement *default routes* to overcome that.

