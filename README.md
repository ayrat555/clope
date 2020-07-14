# Clope

CLOPE: A Fast and Effective Clustering Algorithm for Transactional Data

The algorithm's description
http://www.inf.ufrgs.br/~alvares/CMP259DCBD/clope.pdf

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `clope` to your list of dependencies in `mix.exs`:

```elixir
  def deps do
    [{:clope, "~> 0.1.4"}]
  end
```

  2. Ensure `clope` is started before your application:

```elixir
  def application do
    [applications: [:clope]]
  end
```

## How to use

```elixir
iex> input = [
  {"transaction1", ["object1", "object2", "object3"]},
  {"transaction2", ["object1", "object5"]},
  {"transaction3", ["object2", "object3"]},
  {"transaction4", ["object1", "object5"]}
]
iex> result = input |> Clope.clusterize(2)
[
  [
    {"transaction1", ["object1", "object2", "object3"]},
    {"transaction3", ["object2", "object3"]}
  ],
  [
    {"transaction2", ["object1", "object5"]},
    {"transaction4", ["object1", "object5"]}
  ]
]
```
