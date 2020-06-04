# frozen_string_literal: true

require 'date'

require_relative 'note'
require_relative 'note_list'

# module for selecting the necessary data
module Selector
  def self.select_birthday(notes, min_mon)
    max_mon = if min_mon != 12
                min_mon + 1
              else
                1
              end
    select_notes = []
    notes.each do |note|
      select_notes.append(note) if note.birthday.mon == min_mon || note.birthday.mon == max_mon
    end
    select_notes
  end

  def self.select_status(notes, status)
    select_notes = []
    notes.each do |note|
      select_notes.append(note) if note.status == status
    end
    select_notes
  end
end
