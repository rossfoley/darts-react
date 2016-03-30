React = require 'react'
CricketOrderedPoints = require '../constants/cricket_ordered_points'
_ = require 'underscore'

ScoringButtons = React.createFactory require('./scoring_buttons')
UndoButtons = React.createFactory require('./undo_buttons')

{ table, tbody, th, thead, tr } = React.DOM

ScoringTable = React.createClass
  displayName: 'ScoringTable'

  render: ->
    table {className: 'table table-bordered table-hover', id: 'scoring-table'},
      thead {},
        tr {},
          th {}, 'Points'
          th {}, 'Score'
      tbody {},
        CricketOrderedPoints.map (points) =>
          ScoringButtons {points, scoreboard: @props.scoreboard[points], key: points}
        UndoButtons {}

module.exports = ScoringTable
