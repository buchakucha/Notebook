# frozen_string_literal: true

require 'date'

require_relative 'note'

# The class of notes
class NoteList
  def initialize(notes = [])
    @notes = notes.map do |note|
      [note.id, note]
    end.to_h
  end

  def all_notes_sort_surname
    @notes.values.sort { |x, y| x.surname <=> y.surname }
  end

  def all_notes
    @notes.values
  end

  def note_by_id(id)
    @notes[id]
  end

  def add_note(parameters)
    note_id = if @notes.empty?
                1
              else
                @notes.keys.max + 1
              end
    @notes[note_id] = Note.new(id: note_id, **parameters.to_h)
    @notes[note_id]
  end

  def add_note_from_db(note)
    @notes[note.id] = note
  end

  def update_note(id, parameters)
    note = @notes[id]
    parameters.to_h.each do |key, value|
      note[key] = value
    end
  end

  def delete_note(id)
    @notes.delete(id)
  end
end
