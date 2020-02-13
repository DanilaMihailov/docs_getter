defmodule DocsGetter.MixProject do
  use Mix.Project

  def project do
    [
      app: :docs_getter,
      version: "0.1.0-beta.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      # test coverage (mix coveralls.html or mix test --cover)
      {:excoveralls, "~> 0.12.1", only: :test, runtime: false}
    ]
  end

  defp docs do
    [
      api_reference: false,
      main: "readme",
      extras: [
        "README.md": [title: "README"]
      ]
    ]
  end
end
