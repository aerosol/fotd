defmodule Fotd.Code do
  @allowed_apps ~w(
    ecto
    eex
    elixir
    ex_unit
    iex
    logger
    mix
    phoenix
    phoenix_html
    plug
  )a

  @doc """
  Builds a list of tuples of all functions that are good to display
  """
  def get_all_docs() do
    :code.all_loaded()
    |> Enum.sort()
    |> Enum.map(&elem(&1, 0))
    |> Enum.filter(&legit?/1)
    |> Enum.reduce([], &get_module_docs/2)
    |> Enum.flat_map(&inner_docs/1)
  end

  def get_module_docs(mod, acc) do
    case Code.fetch_docs(mod) do
      {:error, _} ->
        acc

      {:docs_v1, _, _, _, :hidden, _, _} ->
        acc

      docs ->
        [{mod, docs} | acc]
    end
  end

  def inner_docs({mod, {:docs_v1, _, :elixir, _, _, _, inner_docs}}) do
    inner_docs
    |> Enum.reduce([], fn
      {{kind, name, arity}, _, [signature], %{"en" => doc}, _meta}, acc ->
        [{kind, mod, name, arity, signature, doc} | acc]

      _, acc ->
        acc
    end)
  end

  def legit?(mod) when is_atom(mod) do
    elixir?(mod) and allowed?(mod)
  end

  defp elixir?(mod) when is_atom(mod), do: elixir?(Atom.to_string(mod))
  defp elixir?("Elixir." <> _), do: true
  defp elixir?(_), do: false

  defp allowed?(mod) when is_atom(mod) do
    Application.get_application(mod) in @allowed_apps
  end
end
