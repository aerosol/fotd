defmodule FotdTest do
  use ExUnit.Case, async: true

  test "module is considered legit when belongs to Elixir and is not banned" do
    assert Fotd.legit? Phoenix
    assert Fotd.legit? Ecto
    assert Fotd.legit? :"Elixir.Kernel"

    refute Fotd.legit? Fotd
    refute Fotd.legit? Earmark
    refute Fotd.legit? :"Elixir.ExDoc"
    refute Fotd.legit? Fotd.NonExisting
    refute Fotd.legit? :lists
  end

  test "function docs can be extracted per module" do
    assert [{Fotd, docs} | _] = Fotd.get_module_docs(Fotd, [])
    assert [{:function, Fotd, name, arity, signature, doc}] = Fotd.inner_docs({Fotd, docs})
    assert is_atom(name)
    assert is_integer(arity)
    assert is_binary(signature)
    assert is_binary(doc)
  end

  test "all functions docs can be retrieved" do
    assert [{type, module, func, arity, signature, docs} | _] = Fotd.get_all_docs()
    assert is_atom(type)
    assert is_atom(module)
    assert is_atom(func)
    assert is_integer(arity)
    assert is_binary(signature)
    assert is_binary(docs)
  end
end
