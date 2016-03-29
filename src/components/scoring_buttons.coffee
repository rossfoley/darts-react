React = require 'react'
CricketPoints = require '../constants/cricket_points'
_ = require 'underscore'

{ a, div, td, tr } = React.DOM

ScoringButtons = React.createClass
  displayName: 'ScoringButtons'

  availableMarks: ->
    return [1, 2] if parseInt(@props.points) is 25
    [1, 2, 3]

  render: ->
    marks = @availableMarks()

    tr {},
      td {}, CricketPoints[@props.points]
      td {},
        div {className: 'btn-group'},
          marks.map (mark) ->
            a {className: 'btn btn-primary', key: mark}, "#{mark}x"

module.exports = ScoringButtons
