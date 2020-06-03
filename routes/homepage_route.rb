# frozen_string_literal: true

# Routes for the cool books of this application
class NotebookApplication
  path :home, '/homepage'

  hash_branch('homepage') do |r|
    append_view_subdir('homepage')
    set_layout_options(template: '../views/layout')

    r.is do
      view('homepage')
    end
  end
end
