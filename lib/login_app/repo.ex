defmodule LoginApp.Repo do
  use Ecto.Repo,
    otp_app: :login_app,
    adapter: Ecto.Adapters.Postgres
end
