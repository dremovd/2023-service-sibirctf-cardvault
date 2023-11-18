defmodule CardVault.MixProject do
  use Mix.Project

  def project do
    [
      app: :cardvault,
      version: "1.0.16",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CardVault.Application, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.6"},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:plug_cowboy, "~> 2.0"},
      {:observer_cli, "~> 1.5"},
      {:uuid, "~> 1.1"},
      {:redix, "~> 1.1"},
      {:castore, ">= 0.0.0"},
      {:poison, "~> 3.1"}
    ]
  end

  defp releases do
    [
      cardvault: [
        include_executables_for: [:unix]
      ]
    ]
  end
end
