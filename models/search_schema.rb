# frozen_string_literal: true

require 'dry-schema'

SearchSchema = Dry::Schema.Params do
    required(:birthday).filled(:date)
end
