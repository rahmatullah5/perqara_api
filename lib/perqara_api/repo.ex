defmodule PerqaraApi.Repo do
  use Ecto.Repo,
    otp_app: :perqara_api,
    adapter: Ecto.Adapters.SQLite3
end
