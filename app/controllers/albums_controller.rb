class AlbumsController < ApplicationController
  before_action :must_be_logged_in

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    @bands = Band.all
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:name, :recording_type, :band_id)
  end
end
