defmodule Fotd do
  import ExDoc.Formatter.HTML.Autolink, only: [project_doc: 2]

  @banned [
    "Earmark",
    "Fotd",
    "ExDoc"
  ]

  @doc """
  Get random function information
  """
  def random(seed) do
    :rand.seed(:exs1024s, seed)
    {type, module, func, arity, signature, docs} = Enum.random(get_all_docs())

    %{
      type: type,
      module: module,
      func: func,
      arity: arity,
      signature: signature,
      docs: project_doc(docs, %{})
    }
  end

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
    module = Atom.to_string(mod)
    elixir?(module) and not banned?(module)
  end

  defp elixir?("Elixir." <> _), do: true
  defp elixir?(_), do: false

  defp banned?(mod) when is_binary(mod) do
    Enum.any?(@banned, &String.starts_with?(mod, "Elixir." <> &1))
  end
end
