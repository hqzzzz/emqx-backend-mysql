


-module(emqx_backend_mysql_plug).


-include("emqx_backend_mysql.hrl").
-include_lib("emqx.hrl").
-compile(inline).


-export([format/1,
         pMessage/1]).

pMessage(#message{id = Id,
                qos = QoS,
                topic = Topic,
                from = From,
                flags = Flags,
                headers = Headers,
                payload = Payload}) ->

io_lib:format("Id=~s~nQoS=~w~nTopic=~s~nPayload:~s~nFrom=~p~nFlags=~s~nHeaders=~s~n)",
                  [format(eId2list, Id),QoS,  Topic, Payload,  From, format(flags, Flags), format(headers, Headers)]).


format(#message{id = Id,
                qos = QoS,
                topic = Topic,
                from = From,
                flags = Flags,
                headers = Headers,
                payload = Payload}) ->
               
    io_lib:format("Payload:~s~n Message(Id=~s, QoS=~w, Topic=~s, From=~p, Flags=~s, Headers=~s)",
                  [Payload,format(eId2list, Id), QoS, Topic, From, format(flags, Flags), format(headers, Headers)]).

format(eId2list,Id) ->
    % binary:decode_hex(<<0,5,194,210,135,248,181,212,244,67,0,0,7,62,0,1>>).
    io_lib:format("~.16B",[binary:decode_unsigned(Id,big)]);

format(flags, Flags) ->
    io_lib:format("~p", [[Flag || {Flag, true} <- maps:to_list(Flags)]]);

format(headers, Headers) ->
    io_lib:format("~p", [Headers]).


