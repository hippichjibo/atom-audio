{View} = require 'atom-space-pen-views'

# View that renders the audio of an {AudioEditor}.
module.exports =
class AudioView extends View
    @content: ->
        @div class: 'jibo-audio' , =>
            @audio class: 'audio-element', controls: true
            @img src: "atom://jibo-audio/images/background.jpg"

    attached: ->
        console.log "attached!"

    initialize: (editor) ->
        audio = @find('.audio-element')[0]
        if editor.filePath
            audio.src = editor.filePath
        else
            audio.src = editor.getURI()
            audio.play()

        #animation.setElement(this[0])
