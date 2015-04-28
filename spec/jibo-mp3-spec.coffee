JiboMp3 = require '../lib/jibo-mp3'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "JiboMp3", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('jibo-mp3')

  describe "when the jibo-mp3:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.jibo-mp3')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'jibo-mp3:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.jibo-mp3')).toExist()

        jiboMp3Element = workspaceElement.querySelector('.jibo-mp3')
        expect(jiboMp3Element).toExist()

        jiboMp3Panel = atom.workspace.panelForItem(jiboMp3Element)
        expect(jiboMp3Panel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'jibo-mp3:toggle'
        expect(jiboMp3Panel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.jibo-mp3')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'jibo-mp3:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        jiboMp3Element = workspaceElement.querySelector('.jibo-mp3')
        expect(jiboMp3Element).toBeVisible()
        atom.commands.dispatch workspaceElement, 'jibo-mp3:toggle'
        expect(jiboMp3Element).not.toBeVisible()
