{ToolWithStroke} = require './base'
{createShape} = require '../core/shapes'


# this is pretty similar to the Rectangle tool. maybe consolidate somehow.
module.exports = class Dot extends ToolWithStroke

  name: 'Dot'
  iconName: 'dot'

  constructor: -> @strokeWidth = 10
  optionsStyle: 'stroke-width'

  begin: (x, y, lc) ->
    @currentShape = createShape('Ellipse', {
      x, y, @strokeWidth,
      height: @strokeWidth,
      width: @strokeWidth,
      strokeColor: lc.getColor('primary'),
      fillColor: lc.getColor('primary')})
    lc.drawShapeInProgress(@currentShape)

  continue: (x, y, lc) ->
    @currentShape.x = x
    @currentShape.y = y
    lc.drawShapeInProgress(@currentShape)

  end: (x, y, lc) ->
    lc.saveShape(@currentShape)
