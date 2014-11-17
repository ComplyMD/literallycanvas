React = require './React-shim'


createToolButton = ({displayName, getTool, imageName}) ->
  tool = getTool()
  React.createClass
    displayName: displayName,
    getDefaultProps: -> {isSelected: false, lc: null}
    componentWillMount: ->
      if @props.isSelected
        # prevent race condition with options, tools getting set
        # (I've already forgotten the specifics of this; should reinvestigate
        # and explain here. --steve)
        @props.lc.setTool(tool)
    render: ->
      {li, img, span} = React.DOM
      {imageURLPrefix, isSelected, onSelect} = @props

      className = React.addons.classSet
        'lc-pick-tool': true
        'toolbar-button': true
        'thin-button': true
        'selected': isSelected
      (li {className, onClick: (-> onSelect(tool)), title: displayName},
        (img \
          {
            className: 'lc-tool-icon',
            src: "#{imageURLPrefix}/#{imageName}.png"
          }
        )
        (span \
          {className: 'tool-name'}, displayName
        )
      )


module.exports = createToolButton