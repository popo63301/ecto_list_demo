defmodule Netflix.SeriesTest do
  use Netflix.DataCase

  alias Netflix.Series

  describe "series" do
    alias Netflix.Series.Serie

    @valid_attrs %{items_order: [], title: "some title"}
    @update_attrs %{items_order: [], title: "some updated title"}
    @invalid_attrs %{items_order: nil, title: nil}

    def serie_fixture(attrs \\ %{}) do
      {:ok, serie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Series.create_serie()

      serie
    end

    test "list_series/0 returns all series" do
      serie = serie_fixture()
      assert Series.list_series() == [serie]
    end

    test "get_serie!/1 returns the serie with given id" do
      serie = serie_fixture()
      assert Series.get_serie!(serie.id) == serie
    end

    test "create_serie/1 with valid data creates a serie" do
      assert {:ok, %Serie{} = serie} = Series.create_serie(@valid_attrs)
      assert serie.items_order == []
      assert serie.title == "some title"
    end

    test "create_serie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Series.create_serie(@invalid_attrs)
    end

    test "update_serie/2 with valid data updates the serie" do
      serie = serie_fixture()
      assert {:ok, %Serie{} = serie} = Series.update_serie(serie, @update_attrs)
      assert serie.items_order == []
      assert serie.title == "some updated title"
    end

    test "update_serie/2 with invalid data returns error changeset" do
      serie = serie_fixture()
      assert {:error, %Ecto.Changeset{}} = Series.update_serie(serie, @invalid_attrs)
      assert serie == Series.get_serie!(serie.id)
    end

    test "delete_serie/1 deletes the serie" do
      serie = serie_fixture()
      assert {:ok, %Serie{}} = Series.delete_serie(serie)
      assert_raise Ecto.NoResultsError, fn -> Series.get_serie!(serie.id) end
    end

    test "change_serie/1 returns a serie changeset" do
      serie = serie_fixture()
      assert %Ecto.Changeset{} = Series.change_serie(serie)
    end
  end
end
