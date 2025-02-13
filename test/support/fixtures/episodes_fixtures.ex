defmodule MediaServer.EpisodesFixtures do

  def get_url(url) do
    "#{ Application.get_env(:media_server, :series_base_url) }/api/v3/#{ url }?apiKey=#{ Application.get_env(:media_server, :series_api_key) }"
  end

  def get_all(series_id) do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get("#{ get_url("episode") }&seriesId=#{ series_id }")

    Jason.decode!(body)
  end

  def get_episode(series_id) do
    get_all(series_id) |> Enum.filter(fn x -> x["hasFile"] end) |> List.first()
  end

  def get_episodes(series_id) do
    get_all(series_id) |> Enum.filter(fn x -> x["hasFile"] end)
  end
end
