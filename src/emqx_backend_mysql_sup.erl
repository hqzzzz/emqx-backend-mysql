%%%-------------------------------------------------------------------
%% @doc emqx_backend_mysql top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(emqx_backend_mysql_sup).

-behaviour(supervisor).

-export([start_link/0,start_link/1]).

-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


start_link(Pools) ->
  supervisor:start_link({local, ?MODULE},?MODULE, [Pools]).


%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([Pools]) ->
    SupFlags = #{strategy => one_for_one,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [pool_spec(Pool, Env) || {Pool, Env} <- Pools],
    {ok, {SupFlags, ChildSpecs}}.


pool_spec(Pool, Env) ->
  ecpool:pool_spec({emqx_backend_mysql, Pool}, emqx_backend_mysql:pool_name(Pool), emqx_backend_mysql_cli, Env).