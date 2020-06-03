# frozen_string_literal: true

# The list of possible types
module StatusType
  FRIEND = 'Друг'
  COLLEAGUE = 'Коллега'
  FAMILY = 'Cемья'
  STAFF = 'Обслуживающий персонал'

  def self.all_types
    [
      FRIEND, COLLEAGUE, FAMILY, STAFF
    ]
  end
end
