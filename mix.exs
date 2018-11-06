defmodule Fotd.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fotd,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      build_embedded: Mix.env in [:dev, :prod],
      start_permanent: Mix.env == :prod,
      aliases: [],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Fotd.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:plug_cowboy, "~> 1.0"},
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:earmark, "~> 1.2"},
      {:cowboy, "~> 1.0"}
    ]
  end
end
