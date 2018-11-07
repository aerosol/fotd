defmodule FotdWeb.PageView do
  use FotdWeb, :view

  def signature(%{signature: signature}), do: signature

  def signature_type(%{type: type}) when is_atom(type) do
    type
    |> Atom.to_string()
    |> String.capitalize()
  end

  def render_docs(%{docs: markdown}) do
    markdown
    |> Earmark.as_html!
    |> raw()
  end

  def hexdocs_link(fotd) do
    # TODO see if we need any escaping here for non alphanumeric names etc.
    link to: make_hexdocs_url(fotd) do
      mfa(fotd)
    end
  end

  def make_hexdocs_url(%{app: app, module: m, func: f, arity: a}) do
    "https://hexdocs.pm/#{app}/#{inspect(m)}.html##{f}/#{a}"
  end

  def mfa(%{module: m, func: f, arity: a}), do: "#{inspect(m)}.#{f}/#{a}"

  def tweet_url(fotd) do
    base = "https://twitter.com/intent/tweet"

    twitter_params = %{
      original_referer: "https://elixirfunctionoftheday.com",
      ref_src: "twsrc^tfw",
      text: "#{mfa(fotd)} #{make_hexdocs_url(fotd)} found via https://elixirfunctionoftheday.com #elixir"
    }

    "#{base}?#{URI.encode_query(twitter_params)}"
  end
end
