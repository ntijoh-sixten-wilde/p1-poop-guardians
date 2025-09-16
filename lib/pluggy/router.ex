defmodule Pluggy.Router do
  use Plug.Router
  use Plug.Debugger

  import Pluggy.Template

  alias Pluggy.BasketController
  alias Pluggy.OrderController
  alias Pluggy.PizzaController
  alias Pluggy.UserController

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

  # post("/users/login", do: UserController.login(conn, conn.body_params))
  # post("/users/logout", do: UserController.logout(conn))

  get("/basket", do: BasketController.index(conn))

  get("/orders", do: OrdersController.index(conn))


  get "/edit" do
  pre_set = conn.params["pre_set"]
  send_resp(conn, 200, render("Slask/slask", assigns: [pre_set: pre_set]))
  end

  # pre_set_names = ["Margherita",
  #             "Capricciosa",
  #             "Marinara",
  #             "Quattro formaggi",
  #             "Prosciutto e funghi",
  #             "Ortolana",
  #             "Quattro stagioni",
  #             "Diavola"]

  get "/edit/done" do
  pre_set = conn.params["pre_set"]
  topping_id_system = conn.params["topping_id_system"]
  last_id = Postgrex.query!(DB, "SELECT pizza_id FROM recepies ORDER BY pizza_id DESC").rows

  send_resp(conn, 200, render("Slask/slask", assigns:
  [
    topping_id_system: topping_id_system,
    pre_set: pre_set,
    new_id: hd(hd(last_id)) + 1
  ]
  ))
  end

  get("/pizzas", do: PizzaController.index(conn))

  # get("/pizzas/new", do: PizzaController.new(conn))
  # get("/pizzas/:id", do: PizzaController.show(conn, id))
  # get("/pizzas/:id/edit", do: PizzaController.edit(conn, id))

  # post("/pizzas", do: PizzaController.create(conn, conn.body_params))

  get "/pizzas/add" do
    id = conn.params["id"]
    OrderController.add(conn, id)
    PizzaController.index(conn)
  end


  # # should be put /pizzas/:id, but put/patch/delete are not supported without hidden inputs
  # post("/pizzas/:id/edit", do: PizzaController.update(conn, id, conn.body_params))

  # # should be delete /pizzas/:id, but put/patch/delete are not supported without hidden inputs
  # post("/pizzas/:id/destroy", do: PizzaController.destroy(conn, id))



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


# Plug.Conn.clear_session()



# Plug.Conn.put_session(:atom, value)



# order_id = Plug.Conn.get_session(conn, :order_id)
