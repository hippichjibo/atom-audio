var path = require("path"),
    JiboAudioEditor = require("./audio-editor");

module.exports = {

    activate: function() {
        this.openerDisposable = atom.workspace.addOpener( function(uriToOpen){
                var extension = path.extname(uriToOpen).toLowerCase();

                if( extension === '.mp3' ||
                    extension === '.ogg' ||
                    extension === '.wav') {
                    return new JiboAudioEditor(uriToOpen);
                }
            });
    },

    deactivate: function() {
        this.openerDisposable.dispose();
    }
};
