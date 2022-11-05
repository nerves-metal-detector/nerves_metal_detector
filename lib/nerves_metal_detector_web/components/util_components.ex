defmodule NervesMetalDetectorWeb.UtilComponents do
  use Phoenix.Component

  attr :date_time, DateTime, required: true, doc: "the DateTime struct"
  attr :format, :string, required: true, doc: "the format in which the date time string should be displayed"
  def date_time(assigns) do
    ~H"""
    <%= NervesMetalDetector.Cldr.DateTime.to_string!(@date_time, format: @format) %>
    """
  end
end
