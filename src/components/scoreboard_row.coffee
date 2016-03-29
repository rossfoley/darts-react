React = require 'react'
Cricket = require '../constants/cricket'
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
        output = [span {}, String.fromCharCode('9421')]
        while points >= 5
          points -= 5
          output.push(span {className: 'tally'}, '| | | |')
        while points > 0
          points--
          output.push(span {}, ' |')
        div {}, output

  render: ->
    tr {},
      td {},
        div {className: 'score-ticks right'},
          @pointsToSymbols(@props.teamPoints[@props.teams.get(0).get('id')])
      td {},
        div {className: 'middle'}, Cricket[@props.points]
      td {},
        div {className: 'score-ticks left'},
          @pointsToSymbols(@props.teamPoints[@props.teams.get(1).get('id')])

mapStateToProps = (state) ->
  teams: state.team.get 'teams'
  teamPoints: {1: 10, 2: 1}

module.exports = connect(mapStateToProps)(ScoreboardRow)
