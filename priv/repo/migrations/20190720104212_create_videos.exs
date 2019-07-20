defmodule Netflix.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :title, :string
      add :serie_id, references(:series, on_delete: :nothing)

      timestamps()
    end

    create index(:videos, [:serie_id])
  end
end
