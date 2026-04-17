class MusicController < ApplicationController
  def show
    id = params[:id]
    @music = Music.find(id)
  end

  def index
    @songs = Music.all
  end

  def new
  end

  def create
    @music = Music.create!(music_params)
    flash[:notice] = "#{@music.title} was successfully created."
    redirect_to root_path
  end

  def edit
    @music = Music.find params[:id]
  end

  def update
    @music = Music.find params[:id]
    @music.update!(music_params)
    flash[:notice] = "#{@music.title} was successfully updated."
    redirect_to music_path(@music)
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    flash[:notice] = "Music '#{@music.title}' deleted."
    redirect_to root_path
  end

  def same_artist
    @music = Music.find(params[:id])
    if @music.artist.blank?
      flash[:notice] = "'#{@music.title}' has no artist info"
      redirect_to music_index_path
    else
      @songs = @music.others_by_same_artist
    end
  end

  private

  def music_params
    params.require(:music).permit(:title, :album, :description, :release_date, :artist)
  end
end