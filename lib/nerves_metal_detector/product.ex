defmodule NervesMetalDetector.Product do
  @moduledoc false

  @enforce_keys [:sku, :name, :type]
  defstruct sku: nil,
            name: nil,
            description: nil,
            # reference to image served by this app
            image: nil,
            # :sbc, :sensor, :led, :display, etc. we probably need key -> label mapping somewhere
            type: nil,
            # atoms - can be used to further filter the products in the UI
            tags: []
end
