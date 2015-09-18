class NotesController < ApplicationController
  def create
    note = Note.new(body: params[:note][:body])
    note.user_id = current_user.id
    note.track_id = params[:track_id]

    note.save

    redirect_to track_url(note.track_id)
  end

  def destroy
    note = Note.find(params[:id])
    if note.user_id == current_user.id
      note.destroy
      redirect_to track_url(note.track_id)
    else
      render text: "403 FORBIDDEN"
    end
  end
end
