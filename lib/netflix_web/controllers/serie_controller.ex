defmodule NetflixWeb.SerieController do
  use NetflixWeb, :controller

  alias Netflix.Series
  alias Netflix.Series.Serie

  def index(conn, _params) do
    series = Series.list_series()
    render(conn, "index.html", series: series)
  end

  def new(conn, _params) do
    changeset = Series.change_serie(%Serie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"serie" => serie_params}) do
    case Series.create_serie(serie_params) do
      {:ok, serie} ->
        conn
        |> put_flash(:info, "Serie created successfully.")
        |> redirect(to: Routes.serie_path(conn, :show, serie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    serie = Series.get_serie!(id)
    videos = EctoList.ordered_items_list(serie.videos, serie.items_order)

    render(conn, "show.html", serie: serie, videos: videos)
  end

  def edit(conn, %{"id" => id}) do
    serie = Series.get_serie!(id)
    videos = EctoList.ordered_items_list(serie.videos, serie.items_order)

    changeset = Series.change_serie(serie)
    render(conn, "edit.html", serie: serie, videos: videos, changeset: changeset)
  end

  def update(conn, %{"id" => id, "serie" => serie_params, "items_order" => items_order}) do
    serie = Series.get_serie!(id)
    serie_params = Map.put(serie_params, "items_order", items_order)

    case Series.update_serie(serie, serie_params) do
      {:ok, serie} ->
        conn
        |> put_flash(:info, "Serie updated successfully.")
        |> redirect(to: Routes.serie_path(conn, :show, serie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", serie: serie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie = Series.get_serie!(id)
    {:ok, _serie} = Series.delete_serie(serie)

    conn
    |> put_flash(:info, "Serie deleted successfully.")
    |> redirect(to: Routes.serie_path(conn, :index))
  end
end
