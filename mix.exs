defmodule Clope.Mixfile do
  use Mix.Project

  def project do
    [
      app: :clope,
      version: "0.1.4",
      elixir: "~> 1.4",
      description: "CLOPE: A Fast and Effective Clustering Algorithm for Transactional Data",
      package: [
        maintainers: ["Ayrat Badykov"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/ayrat555/clope"}
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test]},
      {:elixir_uuid, "~> 1.2"},
      {:ex_machina, "~> 2.4"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
