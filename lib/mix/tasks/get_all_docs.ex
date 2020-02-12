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
    project = Mix.Project.get()
    path = "../../doc_deps"
    all_deps = Path.wildcard("deps/*") |> Enum.map(fn p -> Path.split(p) |> Enum.at(1) end)
    local_deps = project.project()[:deps]

    deps = build_deps_docs(all_deps, path)
    gen_deps_md(deps, local_deps)

    cfg = project.project() |> add_extras()
    Mix.Tasks.Docs.run([], cfg)
  end

  defp build_deps_docs(deps, path) do
    deps
    |> Enum.reduce([], fn name, acc ->
      dep_path = "#{path}/#{name}"
      Mix.shell().info("Getting docs for #{name}")
      Mix.Project.in_project(String.to_atom(name), "deps/#{name}/", fn m ->
        unless File.exists?(dep_path) do
          # sometimes it raises exceptions, when no logo found
          try do
            Mix.Tasks.Docs.run(["-o=#{dep_path}"])
            Mix.Task.run("clean")
          rescue
            _ -> nil
          end
        end

        if m do
          proj = m.project()
          Keyword.put_new(acc, proj[:app], %{version: proj[:version], description: proj[:description]})
        else
          acc
        end
      end)
    end)
  end

  defp get_dep_line({dep, obj}, lines) do
    desc = String.split(obj.description, "\n") |> hd()
    header = "## #{dep}"
    local_link = "[local docs](../doc_deps/#{dep}/index.html)"
    remote_link = "[hexdocs](https://hexdocs.pm/#{dep}/)"
    ver = "[#{obj.version}](https://hex.pm/packages/#{dep}/)"
    ["#{header}\n #{local_link} | #{remote_link} | #{ver} \n\n #{desc}" | lines]
  end

  defp gen_deps_md(deps_objs, local_deps) do
    prepared_deps = 
      deps_objs
      |> Enum.map(fn {name, obj} -> 
        if Keyword.has_key?(local_deps, name) do
          {name, Map.put(obj, :level, 1)}
        else
          {name, Map.put(obj, :level, 2)}
        end
      end)
      |> Enum.sort(fn {_, %{level: l1}}, {_, %{level: l2}} -> l1 < l2 end)

    depsmd =
      prepared_deps
      |> Enum.filter(fn {_, dep} -> dep.level == 1 end)
      |> Enum.reduce(["", "# Dependencies"], &get_dep_line/2)
      |> Enum.reverse()
      |> Enum.join("\n")


    deps_of_deps_md =
      prepared_deps
      |> Enum.filter(fn {_, dep} -> dep.level > 1 end)
      |> Enum.reduce(["", "# Deps of deps"], &get_dep_line/2)
      |> Enum.reverse()
      |> Enum.join("\n")

    File.write("doc_deps/deps.md", depsmd <> "\n" <> deps_of_deps_md)
  end

  defp add_extras(cfg) do
    docs = cfg[:docs]
    depsmd = ["doc_deps/deps.md": [title: "Dependencies"]]
    extras = Keyword.get(docs, :extras, []) |> Keyword.merge(depsmd)
    docs = Keyword.put(docs, :extras, extras)

    Keyword.put(cfg, :docs, docs)
  end
end
