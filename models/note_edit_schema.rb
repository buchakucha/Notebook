# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'status_type'

NoteEditSchema = Dry::Schema.Params do
  required(:cellphone).filled(:integer)
  required(:homephone).filled(:integer)
  required(:address).filled(SchemaTypes::StrippedString)
  required(:status).filled(SchemaTypes::StrippedString, included_in?: StatusType.all_types)
end
