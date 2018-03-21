defmodule RihannaUi.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      {RihannaUi.Repo, [name: RihannaUi.Repo] ++ database_opts()},
      # Start the endpoint when the application starts
      supervisor(RihannaUiWeb.Endpoint, []),
      # Start your own worker by calling: RihannaUi.Worker.start_link(arg1, arg2, arg3)
      # worker(RihannaUi.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RihannaUi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RihannaUiWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp database_opts() do
    [
      username: "nested",
      password: "nested",
      database: System.get_env("DB_DATABASE") || "rihanna_db",
      hostname: System.get_env("DB_HOSTNAME") || "127.0.0.1",
      port: System.get_env("DB_PORT") || 54321
    ]
  end
end
