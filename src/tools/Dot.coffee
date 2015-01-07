{ToolWithStroke} = require './base'
{createShape} = require '../core/shapes'


# this is pretty similar to the Rectangle tool. maybe consolidate somehow.
module.exports = class Dot extends ToolWithStroke

  name: 'Dot'
  iconName: 'dot'

  constructor: -> @strokeWidth = 10
  optionsStyle: 'stroke-width'

  begin: (x, y, lc) ->
    @removal = false;
    for shape in lc.shapes when shape && shape.customData.isDot
      if (Math.pow((x - (shape.x + shape.width/2)), 2) + Math.pow((y - (shape.y + shape.width/2)), 2)) < Math.pow(shape.width, 2)
        removedShape = lc.shapes.splice(lc.shapes.indexOf(shape), 1)[0]
        removedShape.removed = true
        lc.trigger('shapeSave', {shape: removedShape})
        lc.trigger('drawingChange')
        lc.repaintLayer('main')
        @removal = true
    if !@removal
      @currentShape = createShape('Ellipse', {
        x, y, @strokeWidth,
        height: @strokeWidth,
        width: @strokeWidth,
        strokeColor: lc.getColor('primary'),
        fillColor: lc.getColor('primary'),
        customData: {
          isDot: true
        }
      })
      lc.drawShapeInProgress(@currentShape)

  continue: (x, y, lc) ->
    if !@removal
      @currentShape.x = x
      @currentShape.y = y
      lc.drawShapeInProgress(@currentShape)

  end: (x, y, lc) ->
    if !@removal
      lc.saveShape(@currentShape)
