defmodule Mix.Tasks.Docs.Fetch do
  use Mix.Task

  @moduledoc """
  Calls mix hex.docs fetch for all dependencies

  Goes through all your dependencies and their dependencies and fetches docs
  via mix hex.docs fetch
  """
  @shortdoc "Calls mix hex.docs fetch for all dependencies"
  @doc false
  def run(_opts) do
    project = Mix.Project.get()
    deps = Path.wildcard("deps/*") |> Enum.map(fn p -> Path.split(p) |> Enum.at(1) end)

    Enum.each(deps, fn name ->
      Mix.shell().info("Getting docs for #{name}")
      Mix.Tasks.Hex.Docs.run(["fetch", name])
    end)
  end
end
