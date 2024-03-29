defmodule EncodingBech.MixProject do
  use Mix.Project

  def project do
    [
      app: :encoding_bech,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:codepagex, "~> 0.1.4"},
      {:benchee, "~> 1.0", only: :dev},
      {:iconv, "~> 1.0"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
