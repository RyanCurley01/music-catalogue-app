class Music < ApplicationRecord
  def others_by_same_artist
    # Your code here #
    Music.where(artist: artist).where.not(id: id)
  end
end
