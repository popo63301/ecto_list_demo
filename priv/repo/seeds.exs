# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Netflix.Repo.insert!(%Netflix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Netflix.Series.create_serie(%{title: "Serie 1"})
Netflix.Videos.create_video(%{title: "Video 1", serie_id: 1})
Netflix.Videos.create_video(%{title: "Video 2", serie_id: 1})
Netflix.Videos.create_video(%{title: "Video 3", serie_id: 1})
