defmodule NervesMetalDetectorWeb.Util do
  def page_title(), do: "Nerves Metal Detector"
  def page_title(nil), do: page_title()
  def page_title(title), do: "#{title} - #{page_title()}"
end
