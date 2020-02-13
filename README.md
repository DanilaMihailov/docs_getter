# DocsGetter [![Hex Version](https://img.shields.io/hexpm/v/docs_getter.svg)](https://hex.pm/packages/docs_getter) [![docs](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/docs_getter/)

Build docs for all dependencies

## Installation

The package can be installed
by adding `docs_getter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:docs_getter, "~> 0.1-pre", only: :dev, runtime: false}
  ]
end
```

## Documentation

Documentation can be found at [https://hexdocs.pm/docs_getter](https://hexdocs.pm/docs_getter).

# Usage

Run
```
mix docs.build
```

and after a while you will get your docs build with page `Dependencies`, that will list all your deps.
![Docs with dependecies page](https://github.com/DanilaMihailov/docs_getter/blob/master/priv/screenshot.png?raw=true)

you can add docs folder to `.gitignore`
```
/doc_deps/
```
