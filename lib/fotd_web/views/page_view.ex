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

  # TODO: update with hexdocs link
  def mfa(%{module: m, func: f, arity: a}), do: "#{inspect(m)}.#{f}/#{a}"
end
