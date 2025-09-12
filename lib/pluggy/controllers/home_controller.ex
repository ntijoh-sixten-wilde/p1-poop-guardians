defmodule Pluggy.HomeController do
  import Pluggy.Template, only: [render: 3]
  import Plug.Conn, only: [send_resp: 3]


  # def index(conn) do
  #   send_resp(conn,200,render("home/index", %{name: "Tim"}, true))
  # end
end
