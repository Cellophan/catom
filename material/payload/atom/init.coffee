atom.config.set 'welcome.showOnStartup', false

path = require 'path'
atom.workspace.observeTextEditors (editor) ->
  editor.setTabLength(4)
  editorView = atom.views.getView(editor)
  if path.extname(editor.getPath()) is '.go'
    editor.setTabLength(4)
