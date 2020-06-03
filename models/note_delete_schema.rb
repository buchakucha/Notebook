# frozen_string_literal: true

require 'dry-schema'

NoteDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
