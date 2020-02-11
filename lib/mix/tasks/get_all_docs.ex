defmodule Mix.Tasks.Docs.Fetch do
  use Mix.Task

  @shortdoc "Calls mix hex.docs fetch for all dependencies"
  def run(_opts) do
    project = Mix.Project.get()
    deps = Keyword.get(project.project(), :deps)

    Enum.each(deps, fn dep ->
      name = elem(dep, 0)
      Mix.shell().info("Getting docs for #{name}")
      Mix.Tasks.Hex.Docs.run(["fetch", Atom.to_string(name)])
    end)
  end
end

defmodule Mix.Tasks.Docs.Build do
  use Mix.Task

  @shortdoc "Builds docs for all dependencies"
  def run(_opts) do
    path = "../../doc/deps"
    all_deps = Path.wildcard("deps/*") |> Enum.map(fn p -> Path.split(p) |> Enum.at(1) end)

    Enum.each(all_deps, fn name ->
      Mix.shell().info("Getting docs for #{name}")
      Mix.Project.in_project(String.to_atom(name), "deps/#{name}/", fn module ->
        # sometimes it raises exceptions, when no logo found
        try do
          Mix.Tasks.Docs.run(["-o=#{path}/#{name}"])
          Mix.Task.run("clean")
        rescue
          _ -> nil
        end
      end)
    end)
  end
end
