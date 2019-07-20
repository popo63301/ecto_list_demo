defmodule Netflix.Videos.Video do
  use Ecto.Schema
  import Ecto.Changeset

  alias Netflix.Series.Serie

  schema "videos" do
    field :title, :string

    belongs_to :serie, Serie

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :serie_id])
    |> validate_required([:title, :serie_id])
  end
end
