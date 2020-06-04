# frozen_string_literal: true

# Routes for the cool books of this application
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
      @notes = opts[:notes].all_notes
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
          @errors = {}
          view('note_edit')
        end

        r.post do
          sym_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
          @params = NoteEditContract.new.call(sym_params)
          @errors = @params.errors.to_h
          if @params.success?
            opts[:notes].update_note(@note.id, @params.to_h)
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
        @notes = opts[:notes].all_notes
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
        @errors = {}
        view('note_new')
      end

      r.post do
        sym_params = r.params.map { |key, value| [key.to_sym, value] }.to_h
        @params = NoteNewContract.new.call(sym_params)
        @errors = @params.errors.to_h
        if @params.success?
          note = opts[:notes].add_note(@params.to_h)
          r.redirect(path(note))
        else
          puts @errors
          view('note_new')
        end
      end
    end
  end
end
