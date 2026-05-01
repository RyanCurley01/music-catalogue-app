require 'rails_helper'

RSpec.describe Music, type: :model do
  describe 'valid rating' do
    it 'is valid with all required attributes' do
      music = Music.new(
        title: 'Vordhosbn',
        album: 'druqs',
        artist: 'Aphex Twin',
        genre: 'IDM',
        rating: 5,
        release_date: '2001-10-22'
      )
      expect(music).to be_valid
    end
  end

  describe '#others_by_same_rating' do
    before do
      @five1 = Music.create!(title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', genre: 'IDM', rating: 5, release_date: '2001-10-22')
      @five2 = Music.create!(title: 'Papua New Guinea', album: 'Accelerator', artist: 'Future Sound of London', genre: 'Ambient', rating: 5, release_date: '1991-05-25')
      @two   = Music.create!(title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', genre: 'IDM', rating: 2, release_date: '2003-11-03')
    end

    it 'returns music with the same rating' do
      expect(@five1.others_by_same_rating).to include(@five2)
    end

    it 'does not return the music itself' do
      expect(@five1.others_by_same_rating).not_to include(@five1)
    end

    it 'does not return music with a different rating' do
      expect(@five1.others_by_same_rating).not_to include(@two)
    end

    it 'returns all other tracks with the same rating' do
      five3 = Music.create!(title: 'Nothing is Real', album: "Tomorrow's Harvest", artist: 'Boards of Canada', genre: 'Ambient', rating: 5, release_date: '2013-06-04')
      expect(@five1.others_by_same_rating).to include(@five2, five3)
    end

    it 'returns an empty collection when no other tracks share the rating' do
      expect(@two.others_by_same_rating).to be_empty
    end
  end
end
