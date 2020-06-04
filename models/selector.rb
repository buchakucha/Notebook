# frozen_string_literal: true

require 'date'

require_relative 'note'
require_relative 'note_list'
# module for selecting the necessary data
module Selector
  def self.select_birthday(notes, date)
    min_mon = Date.parse(date).mon
    max_mon = min_mon + 1
    select_notes = []
    notes.each do |note|
      select_notes.append(note) if note.birthday.mon == min_mon || note.birthday.mon == max_mon
    end
    select_notes
  end
end

# notes: []
# [note]
#  note: [x,y]
# x: number
# y: struct
