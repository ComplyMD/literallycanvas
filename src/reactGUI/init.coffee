React = require './React-shim'

createToolButton = require './createToolButton'
Options = require './Options'
Picker = require './Picker'


init = (pickerElement, lc, tools, imageURLPrefix) ->
  toolButtonComponents = tools.map (ToolClass) ->
    toolInstance = new ToolClass()
    createToolButton
      displayName: toolInstance.name
      imageName: toolInstance.iconName
      getTool: -> toolInstance

  React.renderComponent(Picker(
    {lc, toolButtonComponents, imageURLPrefix}), pickerElement)


module.exports = init