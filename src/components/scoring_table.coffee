React = require 'react'
CricketPoints = require '../constants/cricket_points'
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
        _.keys(CricketPoints).map (points) ->
          ScoringButtons {points, key: points}
        UndoButtons {}

module.exports = ScoringTable
