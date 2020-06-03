# frozen_string_literal: true

require 'psych'
require_relative 'note_list'
require_relative 'note'

# Storage for data
class Store
  attr_reader :note_list

  DATA_STORE = File.expand_path('../db/data.yaml', __dir__)

  def initialize
    @note_list = NoteList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:note_list].each do |raw_note|
      @note_list.add_note_from_db(Note.new(**raw_note))
    end
  end

  def write_data
    raw_notes = @note_list.all_notes.map(&:to_h)
    yaml_data = Psych.dump({
                             note_list: raw_notes
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
