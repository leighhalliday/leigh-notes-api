class NotesController < ApplicationController
  before_action :require_authenticated

  def create
    note = current_user.notes.new(note_params)
    if note.save
      render(json: {
        note: note_json(note)
      })
    else
      render(status: 400, json: { errors: note.errors.full_messages })
    end
  end

  def index
    render(json: {
      notes: current_user.notes.map { |note| note_json(note) }
    })
  end

  private

  def note_json(note)
    { id: note.id, body: note.body, createdAt: note.created_at }
  end

  def note_params
    params.require(:note).permit(:body)
  end
end
