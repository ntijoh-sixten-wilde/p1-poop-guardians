defmodule Pluggy.Router do
  use Plug.Router
  use Plug.Debugger


  alias Pluggy.HomeController
  alias Pluggy.PizzaController
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


  post("/pizzas", do: PizzaController.create(conn, conn.body_params))

  # should be put /pizzas/:id, but put/patch/delete are not supported without hidden inputs
  post("/pizzas/:id/edit", do: PizzaController.update(conn, id, conn.body_params))

  # should be delete /pizzas/:id, but put/patch/delete are not supported without hidden inputs
  post("/pizzas/:id/destroy", do: PizzaController.destroy(conn, id))

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
