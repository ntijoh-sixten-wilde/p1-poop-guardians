defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "", price: "")

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

  def to_struct([[id, name, price]]) do
    %Pizza{id: id, name: name, price: price}
  end

  def to_struct_list(rows) do
    for [id, name, price] <- rows, do: %Pizza{id: id, name: name, price: price}
  end
end
