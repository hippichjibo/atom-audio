AudioView = require './audio-view'
path = require 'path'

module.exports =
  class JiboAudioEditor
    atom.deserializers.add(this)

    constructor: (@uri, @filePath) ->
      @tabTitle = path.parse(@uri).base;

    getTitle: ->
      @tabTitle

    getViewClass: ->
      AudioView

    destroy: ->
      console.log('destroy')

    getURI: ->
      @uri

    serialize: ->
      {filePath: @uri, tabTitle: @tabTitle, deserializer: @constructor.name}

    @deserialize: ({filePath, tabTitle}) ->
      if fs.existsSync(filePath)
        new AudioEditor(tabTitle, filePath)
      else
        console.warn "Could not deserialize image editor for path '#{filePath}' because that file no longer exists"
