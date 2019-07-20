defmodule NetflixWeb.SerieControllerTest do
  use NetflixWeb.ConnCase

  alias Netflix.Series

  @create_attrs %{items_order: [], title: "some title"}
  @update_attrs %{items_order: [], title: "some updated title"}
  @invalid_attrs %{items_order: nil, title: nil}

  def fixture(:serie) do
    {:ok, serie} = Series.create_serie(@create_attrs)
    serie
  end

  describe "index" do
    test "lists all series", %{conn: conn} do
      conn = get(conn, Routes.serie_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Series"
    end
  end

  describe "new serie" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.serie_path(conn, :new))
      assert html_response(conn, 200) =~ "New Serie"
    end
  end

  describe "create serie" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.serie_path(conn, :create), serie: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.serie_path(conn, :show, id)

      conn = get(conn, Routes.serie_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Serie"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.serie_path(conn, :create), serie: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Serie"
    end
  end

  describe "edit serie" do
    setup [:create_serie]

    test "renders form for editing chosen serie", %{conn: conn, serie: serie} do
      conn = get(conn, Routes.serie_path(conn, :edit, serie))
      assert html_response(conn, 200) =~ "Edit Serie"
    end
  end

  describe "update serie" do
    setup [:create_serie]

    test "redirects when data is valid", %{conn: conn, serie: serie} do
      conn = put(conn, Routes.serie_path(conn, :update, serie), serie: @update_attrs)
      assert redirected_to(conn) == Routes.serie_path(conn, :show, serie)

      conn = get(conn, Routes.serie_path(conn, :show, serie))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, serie: serie} do
      conn = put(conn, Routes.serie_path(conn, :update, serie), serie: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Serie"
    end
  end

  describe "delete serie" do
    setup [:create_serie]

    test "deletes chosen serie", %{conn: conn, serie: serie} do
      conn = delete(conn, Routes.serie_path(conn, :delete, serie))
      assert redirected_to(conn) == Routes.serie_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.serie_path(conn, :show, serie))
      end
    end
  end

  defp create_serie(_) do
    serie = fixture(:serie)
    {:ok, serie: serie}
  end
end
