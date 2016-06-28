React = require 'react'
CricketOrderedPoints = require '../constants/cricket_ordered_points'
{ connect } = require 'react-redux'

ScoreboardRow = React.createFactory require('./scoreboard_row')
ScoreboardTotalRow = React.createFactory require('./scoreboard_total_row')

{ div, colgroup, table, tbody, th, thead, tr } = React.DOM

Scoreboard = React.createClass
  displayName: 'Scoreboard'

  render: ->
    table {className: 'table table-bordered table-hover', id: 'show-score-board'},
      colgroup {className: 'team-score'}
      colgroup {className: 'points-column'}
      colgroup {className: 'team-score'}
      thead {},
        tr {},
          th {},
            div {className: 'right truncate'}, "Team #{@props.teams.get(0).get('name')}"
          th {},
            div {className: 'middle'}, 'vs.'
          th {},
            div {className: 'left truncate'}, "Team #{@props.teams.get(1).get('name')}"
      tbody {},
        CricketOrderedPoints.map (points) =>
          ScoreboardRow {points: points, scoreboard: @props.scoreboard[points], key: points}
        ScoreboardTotalRow {scoreboard: @props.scoreboard}

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(Scoreboard)
