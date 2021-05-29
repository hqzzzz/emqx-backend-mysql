


-module(emqx_backend_mysql_app).

-include("emqx_backend_mysql.hrl").
-behaviour(application).



-emqx_plugin(backend).

-export([start/2, stop/1]).



start(_StartType, _StartArgs) ->
     %获得配置文件Pool
    Pools = application:get_env(emqx_backend_mysql, pools,[]),
    {ok, Sup} = emqx_backend_mysql_sup:start_link(Pools),
    emqx_backend_mysql:register_metrics(),
    emqx_backend_mysql:load(),
    {ok, Sup}.

stop(_State) -> emqx_backend_mysql:unload().


