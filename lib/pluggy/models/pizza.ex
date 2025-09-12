defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "")
  defstruct(id: nil, order_id: nil, completion: nil, pizza_name: nil, price: nil, glutenfree: nil,
  size: nil, mozzarella: nil, parmesan: nil, pecorino: nil, gorgonzola: nil, ham: nil, basil: nil,
  mushroom: nil, artichoke: nil, olives: nil, pepper: nil, salami: nil, aubergine: nil, zucchini: nil, chili: nil, tomato: nil)

  alias Pluggy.Pizza

    def all do
      Postgrex.query!(DB, "SELECT * FROM pizzas", []).rows
      |> to_struct_list
    end

    def get(id) do
      Postgrex.query!(DB, "SELECT * FROM pizzas WHERE id = $1 LIMIT 1", [String.to_integer(id)]
      ).rows
      |> to_struct
    end

    # def update(id, params) do
    #   name = params["name"]
    #   tastiness = String.to_integer(params["tastiness"])
    #   id = String.to_integer(id)

    #   Postgrex.query!(
    #     DB,
    #     "UPDATE fruits SET name = $1, tastiness = $2 WHERE id = $3",
    #     [name, tastiness, id]
    #   )
    # end

    # def create(params) do
    #   name = params["name"]
    #   tastiness = String.to_integer(params["tastiness"])

    #   Postgrex.query!(DB, "INSERT INTO fruits (name, tastiness) VALUES ($1, $2)", [name, tastiness])
    # end

    # def delete(id) do
    #   Postgrex.query!(DB, "DELETE FROM fruits WHERE id = $1", [String.to_integer(id)])
    # end

    def to_struct([[id, name]]) do
    %Pizza{id: id, name: name}
    end

    def to_struct_list(rows) do
      for [id, name] <- rows, do: %Pizza{id: id, name: name}
    @spec update(binary(), nil | maybe_improper_list() | map()) :: Postgrex.Result.t()
    def update(id, params) do
      name = params["name"]
      price = String.to_integer(params["price"])
      id = String.to_integer(id)

      Postgrex.query!(
        DB,
        "UPDATE pizzas SET name = $1, price = $2 WHERE id = $3",
        [name, price, id]
      )
    end

    def create(params) do
      name = params["name"]
      price = String.to_integer(params["price"])

      Postgrex.query!(DB, "INSERT INTO pizzas (name, price) VALUES ($1, $2)", [name, price])
    end

    def delete(id) do
      Postgrex.query!(DB, "DELETE FROM pizzas WHERE id = $1", [String.to_integer(id)])
    end

    def to_struct([[id, order_id, completion, pizza_name, price, glutenfree,
        size, mozzarella, parmesan, pecorino, gorgonzola, ham, basil,
        mushroom, artichoke, olives, pepper, salami, aubergine, zucchini, chili, tomato
      ]]) do
      %Pizza{id: id, order_id: order_id, completion: completion, pizza_name: pizza_name, price: price, glutenfree: glutenfree,
        size: size, mozzarella: mozzarella, parmesan: parmesan, pecorino: pecorino, gorgonzola: gorgonzola, ham: ham, basil: basil,
        mushroom: mushroom, artichoke: artichoke, olives: olives, pepper: pepper, salami: salami, aubergine: aubergine, zucchini: zucchini, chili: chili, tomato: tomato}
    end

    def to_struct_list(rows) do
      for [id, order_id, completion, pizza_name, price, glutenfree,
        size, mozzarella, parmesan, pecorino, gorgonzola, ham, basil,
        mushroom, artichoke, olives, pepper, salami, aubergine, zucchini, chili, tomato
      ] <- rows, do: %Pizza{id: id, order_id: order_id, completion: completion, pizza_name: pizza_name, price: price, glutenfree: glutenfree,
        size: size, mozzarella: mozzarella, parmesan: parmesan, pecorino: pecorino, gorgonzola: gorgonzola, ham: ham, basil: basil,
        mushroom: mushroom, artichoke: artichoke, olives: olives, pepper: pepper, salami: salami, aubergine: aubergine, zucchini: zucchini, chili: chili, tomato: tomato}
    end
  end
end
