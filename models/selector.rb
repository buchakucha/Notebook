require 'date'

require_relative 'note'
require_relative 'note_list'

module Selector
    def self.select_birthday(notes = [], date)
      min_mon = Date.parse(date).mon
      max_mon = min_mon + 1
      select_notes = []
      notes.each do |note|
        if Date.parse(note.birthday).mon == min_mon || Date.parse(note.birthday).mon == max_mon
          select_notes.append(note)
        end
      end
      select_notes
    end
end