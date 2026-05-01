class MusicController < ApplicationController
  def index
    @songs = Music.all
    if params[:rating].present?
      @songs = @songs.where(rating: params[:rating])
    end

    if params[:sort].present?
      case params[:sort]
      when "title"
        @songs = @songs.order(:title)

      when "album"
        @songs = @songs.order(:album, :title)

      when "artist"
        @songs = @songs.order(:artist, :title)

      when "genre"
        @songs = @songs.order(:genre, :title)

      when "release_date"
        @songs = @songs.order(:release_date, :title)

      when "rating"
        @songs = @songs.order(:rating, :title)
      end
    end
  end


  def show
    @music = Music.find(params[:id])
  end


  def create
    @music = Music.create!(music_params)
    flash[:notice] = "#{@music.title} was successfully created."
    redirect_to root_path
  end


  def edit
    @music = Music.find(params[:id])
  end


  def update
    @music = Music.find(params[:id])
    updated_params = music_params
    if updated_params[:album].blank?
      updated_params[:album] = @music.album
    end
    @music.update!(updated_params)
    flash[:notice] = "#{@music.title} was successfully updated."
    redirect_to music_path(@music)
  end


  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    flash[:notice] = "Selected song deleted."
    redirect_to root_path
  end


  def same_artist
    @music = Music.find(params[:id])
    if @music.artist.blank?
      flash[:notice] = "'#{@music.title}' has no artist info"
      redirect_to root_path
    else
      @songs = @music.others_by_same_artist
    end
  end
  

  def same_genre
    @music = Music.find(params[:id])
    if @music.genre.blank?
      flash[:notice] = "'#{@music.title}' has no genre info"
      redirect_to root_path
    else
      @songs = Music.where(genre: @music.genre).where.not(id: @music.id)
    end
  end

  private

  def music_params
    params.require(:music).permit(:title, :album, :artist, :genre, :release_date, :rating)
  end
end
