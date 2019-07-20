defmodule Netflix.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :title, :string
      add :items_order, {:array, :id}

      timestamps()
    end

  end
end
