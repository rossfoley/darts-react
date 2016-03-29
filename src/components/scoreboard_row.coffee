React = require 'react'
CricketPoints = require '../constants/cricket_points'
{ connect } = require 'react-redux'

{ div, span, td, tr } = React.DOM

ScoreboardRow = React.createClass
  displayName: 'ScoreboardRow'

  pointsToSymbols: (points) ->
    switch points
      when 0 then ''
      when 1 then '\\'
      when 2 then 'X'
      else
        points -= 3
        output = [span {key: points}, String.fromCharCode('9421')]
        while points >= 5
          points -= 5
          output.push(span {className: 'tally', key: points}, '| | | |')
        while points > 0
          points--
          output.push(span {key: points}, ' |')
        div {}, output

  closedClass: (team) -> if team.closed then 'closed' else ''

  bothClosedClass: (firstTeam, secondTeam) ->
    if firstTeam.closed and secondTeam.closed then 'both-closed' else ''


  render: ->
    firstTeam = @props.scoreboard[@props.teams.get(0).get('id')]
    secondTeam = @props.scoreboard[@props.teams.get(1).get('id')]

    tr {className: @bothClosedClass(firstTeam, secondTeam)},
      td {className: @closedClass(firstTeam)},
        div {className: 'score-ticks right'},
          @pointsToSymbols(firstTeam.total)
      td {},
        div {className: 'middle'}, CricketPoints[@props.points]
      td {className: @closedClass(secondTeam)},
        div {className: 'score-ticks left'},
          @pointsToSymbols(secondTeam.total)

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardRow)
