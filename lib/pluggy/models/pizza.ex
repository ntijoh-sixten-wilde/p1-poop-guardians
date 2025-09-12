defmodule Pluggy.Pizza do
  defstruct(id: nil, name: "")

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
  end
end
