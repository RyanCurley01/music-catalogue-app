require 'rails_helper'

RSpec.describe Music, type: :model do
  describe 'valid music' do
    it 'is valid with all required attributes' do
      music = Music.new(
        title: 'Windowlicker',
        album: 'Windowlicker',
        artist: 'Aphex Twin',
        release_date: '1999-03-22'
      )
      expect(music).to be_valid
    end
  end

  describe '#others_by_same_artist' do
    before do
      @aphex1 = Music.create!(title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', release_date: '2001-10-22')
      @aphex2 = Music.create!(title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', release_date: '2003-11-03')
      @other  = Music.create!(title: 'Papua New Guinea', album: 'Accelerator', artist: 'Future Sound of London', release_date: '1991-05-25')
    end

    it 'returns music by the same artist' do
      expect(@aphex1.others_by_same_artist).to include(@aphex2)
    end

    it 'does not return the music itself' do
      expect(@aphex1.others_by_same_artist).not_to include(@aphex1)
    end

    it 'does not return music by a different artist' do
      expect(@aphex1.others_by_same_artist).not_to include(@other)
    end

    it 'returns all other tracks by the same artist' do
      aphex3 = Music.create!(title: 'Windowlicker', album: 'Windowlicker', artist: 'Aphex Twin', release_date: '1999-03-22')
      expect(@aphex1.others_by_same_artist).to include(@aphex2, aphex3)
    end

    it 'returns an empty collection when no other tracks share the artist' do
      expect(@other.others_by_same_artist).to be_empty
    end
  end
end
