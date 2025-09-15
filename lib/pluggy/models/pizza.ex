defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", image: "")

  # alias Pluggy.Pizza

  # def all do
  #   Postgrex.query!(DB, "SELECT * FROM  pizzas", []).rows
  #   |> to_struct_list
  # end

  # def get(id) do
  #   Postgrex.query!(DB, "SELECT * FROM pizzas WHERE id = $1 LIMIT 1", [String.to_integer(id)]
  #   ).rows
  #   |> to_struct
  # end

  # def update(id, params) do
  #   name = params["name"]
  #   image = String.to_integer(params["image"])
  #   id = String.to_integer(id)

  #   Postgrex.query!(
  #     DB,
  #     "UPDATE pizzas SET name = $1, image = $2 WHERE id = $3",
  #     [name, image, id]
  #   )
  # end

  # def create(params) do
  #   name = params["name"]
  #   image = String.to_integer(params["tastiness"])

  #   Postgrex.query!(DB, "INSERT INTO pizzas (name, tastiness) VALUES ($1, $2)", [name, image])
  # end

  # def delete(id) do
  #   Postgrex.query!(DB, "DELETE FROM pizzas WHERE id = $1", [String.to_integer(id)])
  # end

  # def to_struct([[id, name, image]]) do
  #   %Pizza{id: id, name: name, image: image}
  # end

  # def to_struct_list(rows) do
  #   for [id, name, image] <- rows, do: %Pizza{id: id, name: name, image: image}
  # end


  #GER PIZZA-INFO TILL MENYSIDAN (DYNAMISKT)
  def all_pizza_ingredients() do
    result =
      Postgrex.query!(
        DB,
        "SELECT pizzas.id, pizzas.name, pizzas.image, ingredients.name
        FROM recepies
        INNER JOIN ingredients ON recepies.ingredient_id = ingredients.id
        INNER JOIN pizzas ON recepies.pizza_id = pizzas.id
        ORDER BY pizzas.id;",
        []
      )

    result.rows
    |> Enum.group_by(fn [id, name, image, _ingredient] -> {id, name, image} end,
                    fn [_id, _name, _image, ingredient] -> ingredient end)
    |> Enum.map(fn {{id, pizza_name, pizza_image}, ingredients} ->
      %{id: id, name: pizza_name, image: pizza_image, ingredients: ingredients}
    end)
  end


end
