React = require './React-shim'
createSetStateOnEventMixin = require './createSetStateOnEventMixin'
{_} = require '../core/localization'

ClearButton = React.createClass
  displayName: 'ClearButton'
  getState: -> {isEnabled: true}
  getInitialState: -> @getState()
  mixins: [createSetStateOnEventMixin('drawingChange')]

  render: ->
    {li} = React.DOM
    {lc} = @props

    className = React.addons.classSet
      'lc-clear': true
      'toolbar-button': true
      'fat-button': true
      'disabled': not @state.isEnabled
    onClick = if true then (=> lc.clear()) else ->

    (li {className, onClick}, _('Clear'))


module.exports = ClearButton
