# frozen_string_literal: true

# The list of possible types
module SexType
    MAN = 'Мужчина'
    WOMAN = 'Женщина'

    def self.all_types
      [
        MAN, WOMAN
      ]
    end
  end