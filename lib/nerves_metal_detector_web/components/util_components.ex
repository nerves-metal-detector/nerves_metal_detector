defmodule NervesMetalDetectorWeb.UtilComponents do
  use Phoenix.Component

  attr :id, :string, required: true
  attr :date_time, DateTime, required: true, doc: "the DateTime struct"

  attr :format, :string,
    required: true,
    doc: "the format in which the date time string should be displayed in the static render"

  attr :js_format, :string,
    required: true,
    doc: "the format in which the date time string should be displayed after client side update"

  def date_time(assigns) do
    ~H"""
    <time
      id={@id}
      datetime={DateTime.to_iso8601(@date_time)}
      phx-hook="LocalDateTime"
      data-format={@js_format}
    >
      <span id={"#{@id}-view"} phx-update="ignore">
        <%= NervesMetalDetector.Cldr.DateTime.to_string!(@date_time, format: @format) %>
      </span>
    </time>
    """
  end
end
