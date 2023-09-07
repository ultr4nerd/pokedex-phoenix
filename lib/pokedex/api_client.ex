defmodule Pokedex.APIClient do
  @moduledoc """
  A Pokémon API Client.
  """

  @doc """
  Retrieves Pokemon data with given id.

  ## Examples

      iex> Pokedex.APIClient.get_pokemon(1)
      {:ok, "bulbasaur"}

      iex> Pokedex.APIClient.get_pokemon(5000)
      {:error, "Not found :("}

  """
  def get_pokemon(id) do
    HTTPoison.start
    case HTTPoison.get("https://pokeapi.co/api/v2/pokemon/#{id}/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, json} -> {:ok, Map.fetch!(json, "name")}
          {:error, _reason} -> {:error, "An error ocurred while decoding data."}
        end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found :("}
      {:error, %HTTPoison.Error{reason: _reason}} ->
        {:error, "An error ocurred while fetching data."}
    end
  end
end
