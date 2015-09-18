class TracksController < ApplicationController
  before_action :must_be_logged_in

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
  end

  def create
    @track = Track.new(track_params)
    @album = Album.find(@track.album_id)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :feature_type, :lyrics)
  end
end
