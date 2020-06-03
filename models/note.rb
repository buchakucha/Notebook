# frozen_string_literal: true

Note = Struct.new(:id, :name, :surname, :patronymic, :cellphone, :homephone,
                  :address, :birthday, :sex, :status, keyword_init: true)
