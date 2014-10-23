{ToolWithStroke} = require './base'
{createShape} = require '../core/shapes'


# this is pretty similar to the Rectangle tool. maybe consolidate somehow.
module.exports = class PathFill extends ToolWithStroke

  name: 'PathFill'
  iconName: 'pathfill'

  constructor: -> @strokeWidth = 1
  optionsStyle: 'stroke-width'

  isPointInPath: (x, y, points) ->
    j = points.length-1
    is_in_path = false
    for i in [0...points.length]
      if ((points[i].y > y) != (points[j].y > y)) and (x < (points[j].x - points[i].x) * (y - points[i].y) / (points[j].y - points[i].y) + points[i].x)
        is_in_path = !is_in_path
      j = i;
    is_in_path

  begin: (x, y, lc) ->
    for backgroundShape in lc.backgroundShapes
      if @isPointInPath(x, y, backgroundShape.points)
        points = []
        for pair in backgroundShape.points
          do (pair) ->
            points.push(createShape('Point', {x: pair.x, y: pair.y, size: 1, color: '#000'}))
        @shapeMask = createShape('LinePath', {points: points, tailSize: 0, order: 1, interpolate: false, fillColor: 'rgba(255,255,255,0)'})
        @shapeMask.background = true
        bgShape = createShape('LinePath', {points: points, tailSize: 0, order: 1, interpolate: false, fillColor: lc.getColor('secondary')})
        lc.backgroundShapes.push(bgShape)
        lc.repaintLayer('background')
        lc.saveShape(@shapeMask)

  continue: (x, y, lc) ->

  end: (x, y, lc) ->
