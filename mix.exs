defmodule DocsGetter.MixProject do
  use Mix.Project

  def project do
    [
      app: :docs_getter,
      version: "0.1.0-beta.1",
      source_url: "https://github.com/DanilaMihailov/docs_getter",
      homepage_url: "https://github.com/DanilaMihailov/docs_getter",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp description() do
    "Builds docs for all dependencies"
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/DanilaMihailov/docs_getter"}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
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
