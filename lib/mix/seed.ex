defmodule Mix.Tasks.Seed do
  use Mix.Task

  # PIZZAS
  defp add_list_to_pizza_table(nested_list) do
    Enum.map(nested_list, fn x -> add_to_pizza_table(x) end)
  end

  defp add_to_pizza_table(pair) do
    Postgrex.query!(DB, "INSERT INTO pizzas (name, image) VALUES($1, $2)", pair,
      pool: DBConnection.ConnectionPool
    )
  end


  #INGREDIENTS
  defp add_to_ingredients_table(ingredients) do
    Postgrex.query!(DB, "INSERT INTO ingredients (name) VALUES($1)", ingredients,
      pool: DBConnection.ConnectionPool
    )
  end

  defp add_list_to_ingredients_table(list) do
    Enum.map(list, fn x -> add_to_ingredients_table(x) end)
  end


  # RECEPIES
  defp add_list_to_recepies_table(nested_list) do
    Enum.map(nested_list, fn x -> add_to_recepies_table(x) end)
  end

  defp add_to_recepies_table(pair) do
    Postgrex.query!(DB, "INSERT INTO recepies (pizza_id, ingredient_id) VALUES($1, $2)", pair,
      pool: DBConnection.ConnectionPool
    )
  end

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run("app.start")
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS recepies", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS ingredients", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS fruits", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables")

    # PIZZAS
    Postgrex.query!(
      DB,
      "Create TABLE pizzas (id SERIAL, name VARCHAR(255) NOT NULL, image VARCHAR(255) NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )

    #INGREDIENTS
    Postgrex.query!(
      DB,
      "Create TABLE ingredients (id SERIAL, name VARCHAR(255) NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )

    # RECEPIES
    Postgrex.query!(
      DB,
      "Create TABLE recepies (pizza_id INTEGER NOT NULL, ingredient_id INTEGER NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )

    # USERS
    Postgrex.query!(
      DB,
      "Create TABLE users (id SERIAL, username VARCHAR(255) NOT NULL, password_hash CHAR(72) NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )
  end

  defp seed_data() do
    IO.puts("Seeding data")

    pizzas = [["Margherita", "priv/static/uploads/margherita.svg"],
              ["Capricciosa", "priv/static/uploads/capricciosa.svg"],
              ["Marinara", "priv/static/uploads/marinara.svg"],
              ["Quattro formaggi", "priv/static/uploads/quattro-formaggi.svg"],
              ["Prosciutto e funghi", "priv/static/uploads/prosciutto-e-funghi.svg"],
              ["Ortolana", "priv/static/uploads/ortolana.svg"],
              ["Quattro stagioni", "priv/static/uploads/quattro-stagioni.svg"],
              ["Diavola", "priv/static/uploads/diavola.svg"]]
    add_list_to_pizza_table(pizzas)


    ingredients = [ ["Tomato"],
                    ["Mozzarella"],
                    ["Parmesan"],
                    ["Gorgonzola"],
                    ["Pecorino"],
                    ["Skinka"],
                    ["Basilika"],
                    ["Svamp"],
                    ["Kronärtskocka"],
                    ["Oliver"],
                    ["Paprika"],
                    ["Salami"],
                    ["Aubergine"],
                    ["Zucchini"],
                    ["Chili"]]

    add_list_to_ingredients_table(ingredients)


    recepies = [[1, 1],
                [1, 2],
                [1, 7],

                [2, 1],
                [2, 2],
                [2, 6],
                [2, 8],
                [2, 9],

                [3, 1],

                [4, 1],
                [4, 2],
                [4, 3],
                [4, 4],
                [4, 5],

                [5, 1],
                [5, 2],
                [5, 6],
                [5, 8],

                [6, 1],
                [6, 2],
                [6, 11],
                [6, 13],
                [6, 14],

                [7, 1],
                [7, 2],
                [7, 6],
                [7, 8],
                [7, 14],
                [7, 10],

                [8, 1],
                [8, 2],
                [8, 12],
                [8, 11],
                [8, 15]]

    add_list_to_recepies_table(recepies)

    # USERS
    Postgrex.query!(
      DB,
      "INSERT INTO users(username, password_hash) VALUES($1, $2)", ["Tony", Bcrypt.hash_pwd_salt("admin")],
      pool: DBConnection.ConnectionPool
    )
  end
end
