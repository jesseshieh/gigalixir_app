defmodule GigalixirPhoenixWeb.Router do
  use GigalixirPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GigalixirPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GigalixirPhoenixWeb do
  #   pipe_through :api
  # end
end
