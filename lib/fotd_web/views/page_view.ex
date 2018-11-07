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

  def hexdocs_link(%{app: app, module: m, func: f, arity: a} = fotd) do
    # TODO see if we need any escaping here for non alphanumeric names etc.
    link to: "https://hexdocs.pm/#{app}/#{inspect(m)}.html##{f}/#{a}" do
      mfa(fotd)
    end
  end

  def mfa(%{module: m, func: f, arity: a}), do: "#{inspect(m)}.#{f}/#{a}"
end
