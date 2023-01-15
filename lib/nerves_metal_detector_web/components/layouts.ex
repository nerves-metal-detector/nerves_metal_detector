defmodule NervesMetalDetectorWeb.Layouts do
  use NervesMetalDetectorWeb, :html
  import Phoenix.HTML.Tag, only: [tag: 2]

  embed_templates "layouts/*"

  def meta_tags(attrs_list) do
    Enum.map(attrs_list, &meta_tag/1)
  end

  def meta_tag(attrs) do
    tag(:meta, Enum.into(attrs, []))
  end
end
