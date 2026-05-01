require 'rails_helper'

RSpec.describe MusicController, type: :controller do
  let(:valid_attributes) do
    { title: 'Windowlicker', album: 'Windowlicker', artist: 'Aphex Twin', release_date: '1999-03-22' }
  end

  let(:music) { Music.create!(valid_attributes) }

  # index
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all music to @songs' do
      music
      get :index
      expect(assigns(:songs)).to include(music)
    end
  end

  # index rating and sorting
  describe 'GET #index with rating and sorting' do
    it 'filters music by rating and sorts music by headings' do
      Music.create!(title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', genre: 'IDM', rating: 5, release_date: '2001-10-22')
      Music.create!(title: 'Avril 14th', album: 'Drukqs', artist: 'Aphex Twin', genre: 'IDM', rating: 5, release_date: '2001-10-22')
      Music.create!(title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', genre: 'IDM', rating: 2, release_date: '2003-11-03')
      
      get :index, params: { rating: 5, sort: 'title' }
      
      # Checks filtering
      expect(assigns(:songs).map(&:title)).to include('Vordhosbn', 'Avril 14th')
      expect(assigns(:songs).map(&:title)).not_to include('Mangle 11')

      # Checks sorting
      expect(assigns(:songs).map(&:title)).to eq(['Avril 14th', 'Vordhosbn'])
    end

    it 'sorts by album' do
      get :index, params: { sort: 'album' }
      expect(response).to be_successful
    end

    it 'sorts by artist' do
      get :index, params: { sort: 'artist' }
    end

    it 'sorts by genre' do
      get :index, params: { sort: 'genre' }
    end

    it 'sorts by release_date' do
      get :index, params: { sort: 'release_date' }
    end

    it 'sorts by rating' do
      get :index, params: { sort: 'rating' }
    end 
  end 


  # show
  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: music.id }
      expect(response).to be_successful
    end

    it 'assigns the requested music to @music' do
      get :show, params: { id: music.id }
      expect(assigns(:music)).to eq(music)
    end
  end


  # create 
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Music record' do
        expect {
          post :create, params: { music: valid_attributes }
        }.to change(Music, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { music: valid_attributes }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        post :create, params: { music: valid_attributes }
        expect(flash[:notice]).to match(/successfully created/)
      end
    end
  end


  # edit 
  describe 'GET #edit' do
    it 'returns a successful response' do
      get :edit, params: { id: music.id }
      expect(response).to be_successful
    end

    it 'assigns the requested music to @music' do
      get :edit, params: { id: music.id }
      expect(assigns(:music)).to eq(music)
    end
  end


  # update 
  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the music record' do
        patch :update, params: { id: music.id, music: { artist: 'The Tuss' } }
        expect(music.reload.artist).to eq('The Tuss')
      end

      it 'redirects to the music show page' do
        patch :update, params: { id: music.id, music: { artist: 'The Tuss' } }
        expect(response).to redirect_to(music_path(music))
      end

      it 'sets a flash notice' do
        patch :update, params: { id: music.id, music: { artist: 'The Tuss' } }
        expect(flash[:notice]).to match(/successfully updated/)
      end
    end
  end


  # destroy
  describe 'DELETE #destroy' do
    it 'deletes the music record' do
      music
      expect {
        delete :destroy, params: { id: music.id }
      }.to change(Music, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: music.id }
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: music.id }
      expect(flash[:notice]).to match(/deleted/)
    end
  end


  # same_artist
  describe 'GET #same_artist' do
    context 'when the music has an artist' do
      it 'returns a successful response' do
        get :same_artist, params: { id: music.id }
        expect(response).to be_successful
      end

      it 'assigns other music by same artist to @songs' do
        other = Music.create!(title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', release_date: '2003-11-03')
        get :same_artist, params: { id: music.id }
        expect(assigns(:songs)).to include(other)
      end
    end

    context 'when the music has no artist' do
      it 'redirects to the index with a flash notice' do
        no_artist = Music.create!(title: 'Unknown', album: 'Unknown', artist: '', release_date: '2000-01-01')
        get :same_artist, params: { id: no_artist.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/no artist info/)
      end
    end
  end


  # same_genre
  describe 'GET #same_genre' do
    context 'when the music has a genre' do
      it 'returns a successful response' do
        music_with_genre = Music.create!(title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', genre: 'IDM', release_date: '2001-10-22')
        get :same_genre, params: { id: music_with_genre.id }
        expect(response).to be_successful
      end

      it 'assigns other music by same genre to @songs' do
        m1 = Music.create!(title: 'Vordhosbn', album: 'druqs', artist: 'Aphex Twin', genre: 'IDM', release_date: '2001-10-22')
        m2 = Music.create!(title: 'Mangle 11', album: 'Rephlexions', artist: 'Aphex Twin', genre: 'IDM', release_date: '2003-11-03')
        get :same_genre, params: { id: m1.id }
        expect(assigns(:songs)).to include(m2)
      end
    end

    context 'when the music has no genre' do
      it 'redirects to the index with a flash notice' do
        no_genre = Music.create!(title: 'Unknown', album: 'Unknown', artist: 'Unknown', genre: '', release_date: '2000-01-01')
        get :same_genre, params: { id: no_genre.id }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/no genre info/)
      end
    end
  end 
end
