defmodule NervesMetalDetectorWeb.Router do
  use NervesMetalDetectorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NervesMetalDetectorWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NervesMetalDetectorWeb do
    pipe_through :browser

    live_session :default do
      live "/", HomeLive
      live "/vendor/:vendor", VendorLive
      live "/vendor/:vendor/:sku", VendorProductLive
      live "/product/:sku", ProductLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", NervesMetalDetectorWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:nerves_metal_detector, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_session :dev_tools, on_mount: NervesMetalDetectorWeb.DevAssigns do
        live "/", NervesMetalDetectorWeb.DevLive
        live "/charttest", NervesMetalDetectorWeb.Dev.ChartTestLive
        live "/rpilocator", NervesMetalDetectorWeb.Dev.RpiLocatorLive
      end

      live_dashboard "/dashboard",
        metrics: NervesMetalDetectorWeb.Telemetry,
        ecto_repos: [NervesMetalDetector.Repo]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
