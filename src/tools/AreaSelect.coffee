{ToolWithStroke} = require './base'
{createShape} = require '../core/shapes'


# this is pretty similar to the Rectangle tool. maybe consolidate somehow.
module.exports = class AreaSelect extends ToolWithStroke

  name: 'AreaSelect'
  iconName: 'bucket'

  constructor: -> @strokeWidth = 10
  optionsStyle: 'stroke-width'

  isPointInPath: (x, y, points) ->
    j = points.length-1
    is_in_path = false
    for i in [0...points.length]
      if ((points[i].y > y) != (points[j].y > y)) && (x < (points[j].x - points[i].x) * (y - points[i].y) / (points[j].y - points[i].y) + points[i].x)
        is_in_path = !is_in_path
      j = i
    is_in_path

  begin: (x, y, lc) ->
    for backgroundShape in lc.backgroundShapes when backgroundShape.customData.isAreaSelection and @isPointInPath(x, y, backgroundShape.points)
      removedShape = lc.backgroundShapes.splice(lc.backgroundShapes.indexOf(backgroundShape), 1)[0]
      lc.trigger('shapeSave', {shape: removedShape})
      lc.trigger('drawingChange')
      lc.repaintLayer('background')
      return
    for backgroundShape in lc.backgroundShapes
      if @isPointInPath(x, y, backgroundShape.points)
        shape = createShape('LinePath', {
          points: backgroundShape.points,
          tailSize: 0,
          order: 1,
          smooth: false,
          fillColor: "#428BCA",
          customData: {
            sectionName: backgroundShape.customData.sectionName,
            isAreaSelection: true
          }
        })
        lc.backgroundShapes.push(shape)
        lc.trigger('shapeSave', {shape})
        lc.trigger('drawingChange')
        lc.repaintLayer('background')

  continue: (x, y, lc) ->

  end: (x, y, lc) ->