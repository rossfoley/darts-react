React = require 'react'
CricketPoints = require '../constants/cricket_points'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'
_ = require 'underscore'

ScoreboardRow = React.createFactory require('./scoreboard_row')
ScoreboardTotalRow = React.createFactory require('./scoreboard_total_row')

{ div, colgroup, table, tbody, th, thead, tr } = React.DOM

Scoreboard = React.createClass
  displayName: 'Scoreboard'

  render: ->
    console.log @props.scoreboard
    table {className: 'table table-bordered table-hover', id: 'show-score-board'},
      colgroup {className: 'team-score'}
      colgroup {className: 'points-column'}
      colgroup {className: 'team-score'}
      thead {},
        tr {},
          th {},
            div {className: 'right'}, "Team #{@props.teams.get(0).get('name')}"
          th {},
            div {className: 'middle'}, 'vs.'
          th {},
            div {className: 'left'}, "Team #{@props.teams.get(1).get('name')}"
      tbody {},
        _.keys(CricketPoints).map (points) =>
          ScoreboardRow {points: points, scoreboard: @props.scoreboard[points], key: points}
        ScoreboardTotalRow {}

mapStateToProps = (state) ->
  teams: state.team.get 'teams'
  scoreboard: CricketUtils.computeScoreboard(state.round.get('rounds'), state.team.get('teams'))

module.exports = connect(mapStateToProps)(Scoreboard)
