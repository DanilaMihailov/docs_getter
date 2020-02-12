defmodule DocsGetter.MixProject do
  use Mix.Project

  def project do
    [
      app: :docs_getter,
      version: "0.1.0",
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
    ]
  end

  defp docs do
    [
      extras: [
        "README.md": [title: "README"]
      ]
    ]
  end
end
