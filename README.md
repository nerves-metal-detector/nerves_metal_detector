# NervesMetalDetector

![Test Status](https://github.com/nerves-metal-detector/nerves_metal_detector/actions/workflows/tests.yml/badge.svg)

The Nerves Metal Detector is an application with the goal to show all 
[Nerves Framework](https://github.com/nerves-project) supported hardware,
where to buy it and its availability.

## Roadmap

- [x] Product availability update functionality
- [ ] Coverage of [rpilocator.com](https://rpilocator.com/) catalogue (**in progress**)
- [ ] Non-RPi SBC Products
- [ ] Proper design

## How to contribute

Contributions that add new vendors, products and 
product update items (vendor-item relation) are greatly welcome.

See the [CONTRIBUTING](./CONTRIBUTING.md) document for detailed information. 
Especially the section about adding the items from [rpilocator.com](https://rpilocator.com/).

## Local Development

The project is a standard [Phoenix Framework](https://github.com/phoenixframework/phoenix) application.

### Database

The `docker-compose.yml` in the root folder defines a simple Postgres Docker container.

Run `docker-compose up` to start the database.

Any other way of running a Postgres database works as well.

### Running the server

To start the Phoenix server:

  * Make the environment variables in `.envrc.dist` available. When using [direnv](https://direnv.net/), copy the file to `.envrc` and run `direnv allow .`
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Fetching/Updating Product Availabilities

Product availabilities are updated every hour via an `Oban` cronjob. 

The updates can be manually scheduled by running the server in an iex session 
and scheduling the `NervesMetalDetector.Jobs.ScheduleProductUpdates` job.

```
$ iex -S mix phx.server
iex(1)> NervesMetalDetector.Jobs.ScheduleProductUpdates.new(%{}) |> Oban.insert()
```
