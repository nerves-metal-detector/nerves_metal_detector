defmodule NervesMetalDetector.Repo do
  use Ecto.Repo,
    otp_app: :nerves_metal_detector,
    adapter: Ecto.Adapters.Postgres
end
