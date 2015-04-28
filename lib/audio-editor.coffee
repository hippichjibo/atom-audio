JiboAudioView = require './audio-view'
{Model} = require 'theorist'
path = require 'path'

module.exports =
  class JiboAudioEditor extends Model
    atom.deserializers.add(this)

    constructor: (@uri, @filePath) ->
      @tabTitle = path.parse(@uri).base;
      super

    getTitle: ->
      @tabTitle

    getViewClass: ->
      JiboAudioView

    destroy: ->
      console.log('destroy')

    getURI: ->
      @uri

    serialize: ->
      {filePath: @uri, tabTitle: @tabTitle, deserializer: @constructor.name}

    @deserialize: ({filePath, tabTitle}) ->
      if fs.existsSync(filePath)
        new JiboAudioEditor(tabTitle, filePath)
      else
        console.warn "Could not deserialize image editor for path '#{filePath}' because that file no longer exists"
