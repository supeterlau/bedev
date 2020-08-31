defmodule KvUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      releases: [
        deploy_both: [
          version: "0.0.1",
          # permanent 意味着如果有一个 crash，整个 node 就停止
          applications: [
            kv_server: :permanent,
            kv: :permanent
          ]
        ],
        foo: [
          version: "0.0.1",
          # permanent 意味着如果有一个 crash，整个 node 就停止
          applications: [
            kv_server: :permanent,
            kv: :permanent
          ]
        ]
      ],
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    []
  end
end
