defmodule Pluggy.Router do
  use Plug.Router
  use Plug.Debugger

<<<<<<< HEAD
  alias Pluggy.FruitController
=======

  alias Pluggy.HomeController
  alias Pluggy.PizzaController
>>>>>>> f698b457d3ec3d4e53d136cccbf7735cdcba5471
  alias Pluggy.UserController
  alias Pluggy.BasketController

  plug(Plug.Static, at: "/", from: :pluggy)
  plug(:put_secret_key_base)

  plug(Plug.Session,
    store: :cookie,
    key: "_my_app_session",
    encryption_salt: "cookie store encryption salt",
    signing_salt: "cookie store signing salt",
    log: :debug
  )

  plug(:fetch_session)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(:match)
  plug(:dispatch)

<<<<<<< HEAD
  get("/fruits", do: FruitController.index(conn))
  get("/fruits/new", do: FruitController.new(conn))
  get("/fruits/:id", do: FruitController.show(conn, id))
  get("/fruits/:id/edit", do: FruitController.edit(conn, id))
=======
<<<<<<< HEAD

  get("/", do: HomeController.index(conn))
<<<<<<< HEAD
  get("/basket", do: BasketController.index(conn))
=======


=======
  get("/", do: HomeController.index(conn))
>>>>>>> cb27eec329f74bcdeee81daf7cc427ebba7d05cc
>>>>>>> fc8027e9d5031aea147c1e4efa3f3c22ae0fc3ae
  get("/pizzas", do: PizzaController.index(conn))
  get("/pizzas/new", do: PizzaController.new(conn))
  get("/pizzas/:id", do: PizzaController.show(conn, id))
  get("/pizzas/:id/edit", do: PizzaController.edit(conn, id))
>>>>>>> f698b457d3ec3d4e53d136cccbf7735cdcba5471

  post("/fruits", do: FruitController.create(conn, conn.body_params))

  # should be put /fruits/:id, but put/patch/delete are not supported without hidden inputs
  post("/fruits/:id/edit", do: FruitController.update(conn, id, conn.body_params))

  # should be delete /fruits/:id, but put/patch/delete are not supported without hidden inputs
  post("/fruits/:id/destroy", do: FruitController.destroy(conn, id))

  post("/users/login", do: UserController.login(conn, conn.body_params))
  post("/users/logout", do: UserController.logout(conn))

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp put_secret_key_base(conn, _) do
    put_in(
      conn.secret_key_base,
      "-- LONG STRING WITH AT LEAST 64 BYTES LONG STRING WITH AT LEAST 64 BYTES --"
    )
  end
end
