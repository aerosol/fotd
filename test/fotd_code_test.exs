defmodule Fotd.CodeTest do
  use ExUnit.Case, async: true

  test "module is considered legit when belongs to Elixir and is not banned" do
    assert Fotd.Code.legit? Phoenix
    assert Fotd.Code.legit? Ecto
    assert Fotd.Code.legit? :"Elixir.Kernel"

    refute Fotd.Code.legit? Fotd
    refute Fotd.Code.legit? Earmark
    refute Fotd.Code.legit? :"Elixir.ExDoc"
    refute Fotd.Code.legit? Fotd.Code.NonExisting
    refute Fotd.Code.legit? :lists
  end

  test "function docs can be extracted per module" do
    assert [{Fotd.Code, docs} | _] = Fotd.Code.get_module_docs(Fotd.Code, [])
    assert [{:function, Fotd.Code, name, arity, signature, doc}] = Fotd.Code.inner_docs({Fotd.Code, docs})
    assert is_atom(name)
    assert is_integer(arity)
    assert is_binary(signature)
    assert is_binary(doc)
  end

  test "skip private modules" do
    assert [] = Fotd.Code.get_module_docs(Kernel.Typespec, [])
  end

  test "all functions docs can be retrieved" do
    assert [{type, module, func, arity, signature, docs} | _] = Fotd.Code.get_all_docs()
    assert is_atom(type)
    assert is_atom(module)
    assert is_atom(func)
    assert is_integer(arity)
    assert is_binary(signature)
    assert is_binary(docs)
  end
end
