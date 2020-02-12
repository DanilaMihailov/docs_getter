# DocsGetter

Build docs for all dependencies

<!-- ## Installation -->
<!--  -->
<!-- If [available in Hex](https://hex.pm/docs/publish), the package can be installed -->
<!-- by adding `docs_getter` to your list of dependencies in `mix.exs`: -->
<!--  -->
<!-- ```elixir -->
<!-- def deps do -->
<!--   [ -->
<!--     {:docs_getter, "~> 0.1.0"} -->
<!--   ] -->
<!-- end -->
<!-- ``` -->

# Usage

add this to `.gitignore`
```
/doc_deps/
```

you can add this to your `docs` config, so that you can call `mix docs` and not lose `Deps` links. (it is added automatically when you call `mix docs.build`)

```elixir
extras: [
  "doc_deps/deps.md": [title: "Deps"]
]
```

Now you can run 
```
mix docs.build
```

<!-- Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) -->
<!-- and published on [HexDocs](https://hexdocs.pm). Once published, the docs can -->
<!-- be found at [https://hexdocs.pm/docs_getter](https://hexdocs.pm/docs_getter). -->
<!--  -->
