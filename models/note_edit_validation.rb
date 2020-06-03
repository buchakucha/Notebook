# frozen_string_literal: true

require 'dry-validation'
# checks input of edit note
class NoteEditContract < Dry::Validation::Contract
  params do
    required(:cellphone).value(:string)
    required(:homephone).value(:string)
    required(:address).value(:string)
  end

  rule(:cellphone) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:homephone) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:address) do
    key.failure('Должно быть заполненно') if value.empty?
  end
end
