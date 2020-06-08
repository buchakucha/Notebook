# frozen_string_literal: true

# Routes for notes of this application
class NotebookApplication
  path :notes, '/notebook'
  path :note_new, '/notebook/new'
  path :note_search, '/notebook/search'
  path Note do |note, action|
    if action
      "/notebook/#{note.id}/#{action}"
    else
      "/notebook/#{note.id}"
    end
  end

  hash_branch('notebook') do |r|
    append_view_subdir('notes')
    set_layout_options(template: '../views/layout')

    r.is do
      @notes = opts[:notes].all_notes_sort_surname
      view('notes')
    end

    r.on Integer do |note_id|
      @note = opts[:notes].note_by_id(note_id)
      next if @note.nil?

      r.is do
        view('note')
      end

      r.on 'edit' do
        r.get do
          @parameters = @note.to_h
          view('note_edit')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(NoteEditSchema.call(r.params))
          if @parameters.success?
            opts[:notes].update_note(@note.id, @parameters)
            r.redirect(path(@note))
          else
            view('note_edit')
          end
        end
      end

      r.on 'delete' do
        r.get do
          @parameters = {}
          view('note_delete')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(NoteDeleteSchema.call(r.params))
          if @parameters.success?
            opts[:notes].delete_note(@note.id)
            r.redirect(notes_path)
          else
            view('note_delete')
          end
        end
      end
    end

    r.on 'search' do
      r.get do
        @parameters = {}
        @notes = opts[:notes].all_notes_sort_surname
        @notes_search = {}
        if !r.params['birthday'].nil? && r.params['birthday'] != ''
          min_mon = Date.parse(r.params['birthday']).mon
          @notes_search = Selector.select_birthday(@notes, min_mon)
        end
        view('note_search')
      end
    end

    r.on 'new' do
      r.get do
        @parameters = {}
        view('note_new')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(NoteNewSchema.call(r.params))
        if @parameters.success?
          note = opts[:notes].add_note(@parameters)
          r.redirect(path(note))
        else
          view('note_new')
        end
      end
    end
  end
end
