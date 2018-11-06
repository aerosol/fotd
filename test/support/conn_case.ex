defmodule FotdWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import FotdWeb.Router.Helpers
      @endpoint FotdWeb.Endpoint
    end
  end

  setup _ do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
