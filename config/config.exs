# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fotd,
  ecto_repos: [Fotd.Repo]

# Configures the endpoint
config :fotd, FotdWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Nc3GD82Hhlzhp8j940SnSvsljAXAvrMfH3LJ20LRI5qUh02tRqNjcrT5YvK3zLLt",
  render_errors: [view: FotdWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fotd.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
