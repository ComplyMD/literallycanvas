React = require './React-shim'
DOM = require '../reactGUI/ReactDOMFactories-shim'
createReactClass = require '../reactGUI/createReactClass-shim'

ClearButton = React.createFactory require './ClearButton'
UndoRedoButtons = React.createFactory require './UndoRedoButtons'
ZoomButtons = React.createFactory require './ZoomButtons'

{_} = require '../core/localization'
ColorWell = React.createFactory require './ColorWell'

ColorPickers = React.createFactory createReactClass
  displayName: 'ColorPickers'
  render: ->
    {lc} = @props
    {div} = DOM
    (div {className: 'lc-color-pickers'},
      (ColorWell {lc, colorName: 'primary', label: _('stroke')})
      (ColorWell {lc, colorName: 'secondary', label: _('fill')}),
      (ColorWell {lc, colorName: 'background', label: _('background')})
    )


Picker = createReactClass
  displayName: 'Picker'
  getInitialState: -> {selectedToolIndex: 0}
  render: ->
    {ul} = DOM
    {toolButtonComponents, lc, imageURLPrefix} = @props
    (ul {className: 'lc-picker-contents'},
      toolButtonComponents.map((component, ix) =>
        (component \
          {
            lc, imageURLPrefix,
            key: ix
            isSelected: ix == @state.selectedToolIndex,
            onSelect: (tool) =>
              lc.setTool(tool)
              @setState({selectedToolIndex: ix})
          }
        )
      ),
      ClearButton({lc})
    )


module.exports = Picker
