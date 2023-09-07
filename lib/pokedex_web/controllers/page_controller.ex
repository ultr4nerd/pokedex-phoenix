defmodule PokedexWeb.PageController do
  use PokedexWeb, :controller

  def home(conn, params) do
    case Map.fetch(params, "id") do
      {:ok, id} ->
        case Pokedex.APIClient.get_pokemon(id) do
          {:ok, name} ->
            render(conn, :home, id: id, name: name)

          {:error, message} ->
            put_flash(conn, :error, message)
            |> render(:home, id: id, name: nil)
        end

      :error ->
        render(conn, :home, id: nil, name: nil)
    end
  end
end
