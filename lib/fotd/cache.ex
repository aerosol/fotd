defmodule Fotd.Cache do
  use GenServer
  import ExDoc.Formatter.HTML.Autolink, only: [project_doc: 2]

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(nil) do
    :ets.new(__MODULE__, [:public, :ordered_set, :named_table, read_concurrency: true])

    all_docs =
      Fotd.Code.get_all_docs()
      |> Enum.with_index
      |> Enum.map(fn {entry, index} -> {index, entry} end)

    :ets.insert(__MODULE__, all_docs)
    {:ok, Enum.count(all_docs)}
  end

  def size() do
    :ets.info(__MODULE__)[:size]
  end

  def pick(n) do
    :ets.lookup_element(Fotd.Cache, n, 2)
  end

  def random() do
    size = size()
    index = :rand.uniform(size + 1) - 1

    {type, module, func, arity, signature, docs} = pick(index)

    %{
      out_of: size,
      app: Application.get_application(module),
      type: type,
      module: module,
      func: func,
      arity: arity,
      signature: signature,
      docs: project_doc(docs, %{})
    }
  end
end
