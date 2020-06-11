# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'sex_type'
require_relative 'status_type'

NoteNewSchema = Dry::Schema.Params do
  required(:surname).filled(SchemaTypes::StrippedString)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:patronymic).filled(SchemaTypes::StrippedString)
  required(:cellphone).filled(SchemaTypes::StrippedString,
                              format?: /^(8|\+7)-\d{3}-\d{3}-\d{2}-\d{2}$/)
  required(:homephone).filled(SchemaTypes::StrippedString,
                              format?: /^\d{2}-\d{2}-\d{2}$/)
  required(:address).filled(SchemaTypes::StrippedString)
  required(:birthday).filled(:date)
  required(:sex).filled(SchemaTypes::StrippedString, included_in?: SexType.all_types)
  required(:status).filled(SchemaTypes::StrippedString, included_in?: StatusType.all_types)
end
