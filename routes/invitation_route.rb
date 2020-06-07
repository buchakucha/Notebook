# frozen_string_literal: true

# Routes for invitations of this application
class NotebookApplication
  path :invite, '/invitation'
  path :invite_luck, '/invitation/success'

  hash_branch('invitation') do |r|
    append_view_subdir('invitation')
    set_layout_options(template: '../views/layout')

    r.is do
      r.get do
        @parameters = {}
        @notes = opts[:notes].all_notes
        unless r.params.empty?
          @parameters = DryResultFormeWrapper.new(InvitationSchema.call(r.params))
          if @parameters.success?
            Creator.create_invitations(r.params, @notes) if @parameters.success?
            r.redirect invite_luck_path
          end
        end
        view('invitation')
      end
    end

    r.on 'success' do
      view('success')
    end
  end
end
