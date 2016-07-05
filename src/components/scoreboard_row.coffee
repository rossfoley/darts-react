React = require 'react'
ReactBootstrap = require 'react-bootstrap'
CricketPoints = require '../constants/cricket_points'
{ connect } = require 'react-redux'

{ div, span, td, tr } = React.DOM
OverlayTrigger = React.createFactory(ReactBootstrap.OverlayTrigger)
Tooltip = React.createFactory(ReactBootstrap.Tooltip)

ScoreboardRow = React.createClass
  displayName: 'ScoreboardRow'

  firstTeamId: -> @props.teams.get(0).get('id')
  secondTeamId: -> @props.teams.get(1).get('id')
  firstTeam: -> @props.scoreboard[@firstTeamId()]
  secondTeam: -> @props.scoreboard[@secondTeamId()]

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
          points -= 1
          output.push(span {key: points}, ' |')
        div {}, output

  closedClass: (team) -> if team.closed then 'closed' else ''

  bothClosedClass: ->
    if @firstTeam().closed and @secondTeam().closed then 'both-closed' else ''

  tooltipText: (teamId, otherTeamId) ->
    teamPoints = @props.scoreboard[teamId]
    otherTeamPoints = @props.scoreboard[otherTeamId]
    teamScore = @props.finalScores[teamId]
    otherTeamScore = @props.finalScores[otherTeamId]

    return 'Closed' if teamPoints.closed and otherTeamPoints.closed
    if teamPoints.total < 3
      "#{3 - teamPoints.total} to close"
    else
      return 'Open to score' if teamScore >= otherTeamScore
      needed = Math.ceil((otherTeamScore - teamScore) / parseInt(@props.points))
      "#{needed} to gain lead"

  tooltip: (teamId, otherTeamId) ->
    Tooltip {id: 'tooltip'}, @tooltipText(teamId, otherTeamId)

  render: ->
    tr {className: @bothClosedClass()},
      OverlayTrigger {placement: 'right', overlay: @tooltip(@firstTeamId(), @secondTeamId())},
        td {className: @closedClass(@firstTeam())},
          div {className: 'score-ticks right'},
            @pointsToSymbols(@firstTeam().total)
      td {},
        div {className: 'middle'}, CricketPoints[@props.points]
      OverlayTrigger {placement: 'left', overlay: @tooltip(@secondTeamId(), @firstTeamId())},
        td {className: @closedClass(@secondTeam())},
          div {className: 'score-ticks left'},
            @pointsToSymbols(@secondTeam().total)

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardRow)
