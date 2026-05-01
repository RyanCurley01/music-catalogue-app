# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Music.create!([
  { title: 'last rushup 10 M', album: 'Rushup Edge', artist: 'The Tuss', genre: 'IDM', release_date: '2017-07-20', rating: 4},
  { title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', genre: 'IDM', release_date: '2003-11-03', rating: 2},
  { title: 'Papua New Guinea', album: 'Accelerator', artist: 'Future Sound of London', genre: 'Ambient', release_date: '1979-05-25', rating: 5},
  { title: 'Nothing is Real', album: "Tomorrow's Harvest", artist: 'Boards of Canada', genre: 'Ambient', release_date: '2013-06-04', rating: 3},
  { title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', release_date: '2001-10-22', genre: 'IDM', rating: 5}
])