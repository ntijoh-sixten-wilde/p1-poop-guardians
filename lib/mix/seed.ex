defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run("app.start")
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS orders", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "Create TABLE pizzas (id SERIAL, order_id INTEGER, completion INTEGER, pizza_name VARCHAR(255) NOT NULL, price INTEGER NOT NULL, glutenfree BOOLEAN NOT NULL, size BOOLEAN NOT NULL, tomato INTEGER NOT NULL, mozzarella INTEGER NOT NULL, parmesan INTEGER NOT NULL, pecorino INTEGER NOT NULL, gorgonzola INTEGER NOT NULL, ham INTEGER NOT NULL, basil INTEGER NOT NULL, mushroom INTEGER NOT NULL, artichoke INTEGER NOT NULL, olives INTEGER NOT NULL, pepper INTEGER NOT NULL, salami INTEGER NOT NULL, aubergine INTEGER NOT NULL, zucchini INTEGER NOT NULL, chili INTEGER NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )

    Postgrex.query!(
      DB,
      "Create TABLE orders (id SERIAL, username VARCHAR(255) NOT NULL, password_hash CHAR(72) NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )
  end

  defp seed_data() do
    IO.puts("Seeding data")

    # Postgrex.query!(DB, "INSERT INTO fruits(order_id, completion, pizza_name, price, glutenfree, size, tomato, mozzarella, parmesan, pecorino, gorgonzola, ham, basil, mushroom, artichoke, olives, pepper, salami, aubergine, zucchini, chili) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21)",
    #   [1, 0, "Margherita", 85, false, 100, false, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],

    #   # pool: DBConnection.ConnectionPool
    # )


    # Postgrex.query!(
    #   DB,
    #   "INSERT INTO users(username, password_hash) VALUES($1, $2)",
    #   ["a", Bcrypt.hash_pwd_salt("a")],
    #   pool: DBConnection.ConnectionPool
    # )
  end
end
