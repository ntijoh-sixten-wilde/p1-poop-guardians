defmodule Pluggy.Order do
  defstruct(name: "", order_id: nil, pizza_id: nil, ingredient_id: nil)

  alias Pluggy.Order
  alias Pluggy.Router

  def all do
    Postgrex.query!(DB, "SELECT * FROM  orders", []).rows
    |> to_struct_list
  end

  # def create(params) do
  #   username = params["name"]
  #   order_id = String.to_integer(params["tastiness"])

  #   Postgrex.query!(DB, "INSERT INTO orders (username, order_id, pizza_id, ingredient_id) VALUES ($1, $2, $3, $4)", [username, order_id, pizza_id, ingredient_id])
  # end

  def to_struct([[name, order_id, pizza_id, ingredient_id]]) do
    %Order{name: name, order_id: order_id, pizza_id: pizza_id, ingredient_id: ingredient_id}
  end

  def to_struct_list(rows) do
    for [name, order_id, pizza_id, ingredient_id] <- rows, do: %Order{name: name, order_id: order_id, pizza_id: pizza_id, ingredient_id: ingredient_id}
  end

  # plug Plug.Session,
  # store: :cookie,
  # key: "_id_handler_key",
  # signing_salt: ""

  def add_to_order(conn, id) do

    {int_val, ""} = Integer.parse(id)

    Postgrex.query!(
      DB,
      "INSERT INTO order_recipes (pizza_id, ingredient_id)
      SELECT * FROM recepies WHERE pizza_id = #{int_val}",
      []
    )

    # last_id = Postgrex.query!(DB, "SELECT pizza_id FROM recepies ORDER BY pizza_id DESC").rows

    # new_id = if (true) do

    #   new_id = if (true)
    #   do
    #     hd(hd(last_id)) + 1
    #   else
    #     1
    #   end

    #   new_id
    # end



    # Plug.Conn.put_session(conn, :order_id, new_id)

    # order_id = Plug.Conn.get_session(conn, :order_id)
    order_id = 5



    Postgrex.query!(
      DB,
      "INSERT INTO pizza_orders (order_id, pizza_id)
        SELECT * FROM recepies WHERE pizza_id = #{order_id}",
      []
    )



  end
end
