defmodule TodoLiveView.Repo do
  use Ecto.Repo,
    otp_app: :todo_live_view,
    adapter: Ecto.Adapters.Postgres
end
