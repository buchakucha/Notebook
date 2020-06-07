# frozen_string_literal: true

require 'date'

require_relative 'note'
require_relative 'note_list'
require_relative 'selector'

# module for creating file
module Creator
  def self.create_invitations(params, notes)
    select_notes = Selector.select_status(notes, params['status'])
    text = create_text(params['event'], params['date'], params['address'])
    select_notes.each do |note|
      create_file(note, text, params['file'])
    end
  end

  def self.create_file(note, text, file)
    filepath = File.expand_path("../EVENT/#{note.surname}#{note.id}#{file}.txt", __dir__)
    outfile = File.new(filepath, 'w')
    outfile.puts(note.name + ' ' + note.surname + '! ' + text)
    outfile.close
  end

  def self.create_text(event, date, address)
    text = "Приглашаем Вас на #{event}, которое состоится #{date} по адресу #{address}"
    text
  end
end
