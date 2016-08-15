React = require 'react'
CricketPoints = require '../constants/cricket_points'
{ connect } = require 'react-redux'

{ div, span, td, tr } = React.DOM

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
        if points > 10
          output.push(span {}, " #{points}")
        else
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

  tooltip: (teamId, otherTeamId) ->
    teamPoints = @props.scoreboard[teamId]
    otherTeamPoints = @props.scoreboard[otherTeamId]
    teamScore = @props.finalScores[teamId]
    otherTeamScore = @props.finalScores[otherTeamId]

    return 'Closed' if teamPoints.closed and otherTeamPoints.closed
    if teamScore >= otherTeamScore
      if teamPoints.closed
        'Open to score'
      else
        "#{3 - teamPoints.total} to close"
    else
      if otherTeamPoints.closed
        "#{3 - teamPoints.total} to close"
      else
        messages = []
        messages.push("#{3 - teamPoints.total} to close") unless teamPoints.closed
        toClose = Math.max(0, 3 - teamPoints.total)
        needed = Math.ceil((otherTeamScore - teamScore) / parseInt(@props.points)) + toClose
        messages.push "#{needed} to gain lead"
        messages.join ', '

  render: ->
    tr {className: @bothClosedClass()},
      td
        className: @closedClass(@firstTeam())
        'data-tip': @tooltip(@firstTeamId(), @secondTeamId())
        'data-place': 'right',
          div {className: 'score-ticks right'},
            @pointsToSymbols(@firstTeam().total)
      td {},
        div {className: 'middle'}, CricketPoints[@props.points]
      td
        className: @closedClass(@secondTeam())
        'data-tip': @tooltip(@secondTeamId(), @firstTeamId())
        'data-place': 'left',
          div {className: 'score-ticks left'},
            @pointsToSymbols(@secondTeam().total)

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardRow)
