defmodule NervesMetalDetectorWeb.DevAssigns do
  @moduledoc false

  import Phoenix.Component

  def on_mount(:default, _params, _session, socket) do
    {:cont, assign(socket, :makeup_styles, true)}
  end
end
