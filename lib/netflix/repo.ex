defmodule Netflix.Repo do
  use Ecto.Repo,
    otp_app: :netflix,
    adapter: Ecto.Adapters.Postgres
end
