# Contributing to Nerves Metal Detector

Contributions in the form of adding new vendors, products and
product update items (vendor-item relation) are greatly welcome.

Of course, creating issues to hint at vendors, products and 
which products are listed on specific vendors but not part of our listing yet 
are also always welcome. Please look at the existing issues to see if a related issue already exists.

This document will focus on how to add new vendors, products and product update items.

## Adding a new Vendor

Each vendor has its own file in `lib/nerves_metal_detector/vendors` 
with the naming scheme `{name}_{country}.ex`, e.g. `berry_base_de.ex`.

The structure of such a file looks like this:

```elixir
# example_vendor_de.ex
defmodule NervesMetalDetector.Vendors.ExampleVendorDe do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "examplevendorde",
      name: "Example Vendor",
      country: :de,
      homepage: "https://www.example-vendor.de"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.ExampleVendorDe.ProductUpdate do
  alias NervesMetalDetector.Vendors.ExampleVendorDe

  def fetch_availability(%ExampleVendorDe.ProductUpdate{url: url, sku: sku}) do
    # fetching product info
    %{
      sku: sku,
      vendor: ExampleVendorDe.vendor_info().id,
      url: "...",
      in_stock: false,
      items_in_stock: nil,
      price: Money.new!(String.to_atom("..."), "...")
    }
  end
end
```

The main module of this file is the specific vendor module 
that implements the `Vendor` behaviour. 

The `Vendor` behaviour defines a `vendor_info` function that returns 
a `Vendor` struct. Its fields should be pretty self-explanatory.
The `id` field convention is to use the file name without underscores.

Nested inside the specific vendor module is the `ProductUpdate` struct.
The name `ProductUpdate` and the fields `:url` and `:sku` are by convention. 
Additional fields can be added, if they are required for the product update functionality.

The second part of the file is the implementation of the 
`Inventory.ProductAvailability.Fetcher` protocol for the vendor specific `ProductUpdate` struct.

Its only function is the `fetch_availability/1` function to fetch the availability of a given product.

A few things to note:

- `sku` - Should be used from the `ProductUpdate` struct because the vendors SKUs are unlikely the same as ours
- `url` - Should be parsed from the product page and not just simply be the value from the `ProductUpdate` struct
- `items_in_stock` Should be `nil` if unknown or not in stock
- `price` Needs to be a `Money` struct

Fetching the required info is usually done via web scraping using `HTTPoison` and `Floki`.

A good starting point is to copy an existing vendor file. 

- `Vendors.BerryBaseDe` is a good example of parsing the information from `<meta itemprop="..." content="..." />` elements
- `Vendors.AdafruitUs` and `Vendors.PimoroniUk` are good examples of parsing the information from JSON strings inside `<script type="application/ld+json">` elements

**Important:** Once done, the new vendor needs to be added to the list in `NervesMetalDetector.Vendors`.

## Adding a new Product

Products are defined in `lib/nerves_metal_detector/inventory/data/products` inside collection modules.

An existing collection module is `Rpi` which contains Raspberry Pi SBCs. 
There could be a `BeagleBone` collection for all BeagleBone SBCs 
or a `PiJuice` collection for all PiJuice hats and batteries. 
The collections are mainly used for organisational purpose and don't follow strict rules.

A collection only has an `all/0` function which returns a list of `Inventory.Product` structs.

A few things to note about `Inventory.Product` items:

- `sku` - Finding out the "proper" SKU can be difficult as almost all stores use different ones. It's best to look directly at the manufacturer website.
- `ìmage` - Can be ignored for now

**Important:** If a new collection was created, it needs to be added to the list in `Inventory.Data.Products`.

## Adding new Product Update Items

Each vendor has a collection of its specific `ProductUpdate` structs in
`lib/nerves_metal_detector/inventory/data/product_update_items`. 

Usually, they just need an `sku` which needs to match the `sku` of a known product,
and an `url` that points to the product page.

**Important:** If a new collection was created, it needs to be added to the mapping in `Inventory.Data.ProductUpdateItems`.


## Adding new Vendors and Products from RpiLocator

All products from rpilocator.com are already defined.

For adding missing vendors, please look at the guide above.

Creating the product update items list for a vendor is made easy
using the `/dev/rpilocator` page when the project is run locally in the `dev` environment.
Simply select the RpiLocator vendor and press "Update". It will fetch all vendor specific items and
generate a list of `ProductUpdate` structs that can be pasted into the collection
if the collection follows the same structure as the existing ones.

For better organisation, please structure the list in the same way as the existing ones
where the items are separated into different product groups like `RPi 3`, `RPi 4`, `RPi CM4`.

Also, please remove any additional query params that were added by RpiLocator.
