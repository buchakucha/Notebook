# frozen_string_literal: true

require 'dry-validation'
# checks input of new note
class NoteNewContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:surname).value(:string)
    required(:patronymic).value(:string)
    required(:cellphone).value(:string)
    required(:homephone).value(:string)
    required(:address).value(:string)
    required(:birthday).value(:date)
    required(:sex).filled(:string)
    required(:status).filled(:string)
  end

  rule(:birthday) do
    key.failure('Должно быть заполненно') if value.empty?
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

  rule(:name) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:surname) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:patronymic) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:status) do
    key.failure('Должно быть заполненно') if value.empty?
  end

  rule(:sex) do
    key.failure('Должно быть заполненно') if value.empty?
  end
end