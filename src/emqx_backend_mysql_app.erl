%%%-------------------------------------------------------------------
%% @doc emqx_backend_mysql public API
%% @end
%%%-------------------------------------------------------------------

-module(emqx_backend_mysql_app).

-behaviour(application).

-include("emqx_backend_mysql.hrl").

-emqx_plugin(?MODULE).

-export([ start/2
        , stop/1
        ]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emqx_backend_mysql_sup:start_link(),
    emqx_backend_mysql:load(application:get_all_env()),
    {ok, Sup}.

stop(_State) ->
    emqx_backend_mysql:unload().
  
