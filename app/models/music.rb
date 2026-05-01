class Music < ApplicationRecord
  self.table_name = "music"
  
  def others_by_same_artist
    Music.where(artist: artist).where.not(id: id)
  end

  def others_by_same_genre
    Music.where(genre: genre).where.not(id: id)
  end

  def others_by_same_rating
    Music.where(rating: rating).where.not(id: id)
  end
end
