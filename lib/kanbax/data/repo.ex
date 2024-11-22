defmodule Kanbax.Repo do
  use Ecto.Repo, otp_app: :kanbax, adapter: Ecto.Adapters.Postgres
end
