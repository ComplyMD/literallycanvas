React = require './React-shim'
ReactDOM = require './ReactDOM-shim'

createToolButton = require './createToolButton'
Options = require './Options'
Picker = React.createFactory(require './Picker')


init = (pickerElement, lc, tools, imageURLPrefix) ->
  toolButtonComponents = tools.map (ToolClass) ->
    toolInstance = new ToolClass()
    createToolButton
      displayName: toolInstance.name
      imageName: toolInstance.iconName
      getTool: -> toolInstance

  ReactDOM.render(Picker(
    {lc, toolButtonComponents, imageURLPrefix}), pickerElement)


module.exports = init
