defmodule Netflix.Series.Serie do
  use Ecto.Schema
  import Ecto.Changeset

  alias Netflix.Videos.Video

  schema "series" do
    field :items_order, {:array, :id}, default: []
    field :title, :string

    has_many :videos, Video

    timestamps()
  end

  @doc false
  def changeset(serie, attrs) do
    serie
    |> cast(attrs, [:title, :items_order])
    |> validate_required([:title, :items_order])
  end
end
