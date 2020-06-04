# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'status_type'

InvitationSchema = Dry::Schema.Params do
  required(:event).filled(SchemaTypes::StrippedString)
  required(:status).filled(SchemaTypes::StrippedString, included_in?: StatusType.all_types)
  required(:date).filled(:date)
  required(:address).filled(SchemaTypes::StrippedString)
  required(:file).filled(SchemaTypes::StrippedString)
end
