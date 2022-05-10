defmodule RihannaUIWeb.Router do
  use RihannaUIWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :auth
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RihannaUIWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/", PageController, :overview
    get "/enqueued", PageController, :enqueued
    get "/in_progress", PageController, :in_progress
    get "/failed", PageController, :failed

    post "/jobs", JobsController, :mutate
    post "/jobs/:id", JobsController, :mutate
  end

  # Other scopes may use custom stacks.
  # scope "/api", RihannaUIWeb do
  #   pipe_through :api
  # end

  defp auth(conn, _opts) do
    username = System.fetch_env!("AUTH_USERNAME")
    password = System.fetch_env!("AUTH_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
