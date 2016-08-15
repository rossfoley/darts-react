React = require 'react'
CricketOrderedPoints = require '../constants/cricket_ordered_points'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'

ScoreboardRow = React.createFactory require('./scoreboard_row')
ScoreboardTotalRow = React.createFactory require('./scoreboard_total_row')

{ div, table, tbody, th, thead, tr } = React.DOM

Scoreboard = React.createClass
  displayName: 'Scoreboard'

  render: ->
    finalScores = CricketUtils.totalScores(@props.scoreboard, @props.teams)
    div {id: 'show-score-board'},
      table {className: 'bordered highlight'},
        thead {},
          tr {},
            th {},
              div {className: 'right truncate'}, @props.teams.get(0).get('name')
            th {},
              div {className: 'middle'}, 'vs.'
            th {},
              div {className: 'left truncate'}, @props.teams.get(1).get('name')
        tbody {},
          CricketOrderedPoints.map (points) =>
            ScoreboardRow {points: points, scoreboard: @props.scoreboard[points], finalScores, key: points}
          ScoreboardTotalRow {finalScores}

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(Scoreboard)
