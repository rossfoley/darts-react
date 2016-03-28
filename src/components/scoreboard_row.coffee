React = require 'react'
Cricket = require '../constants/cricket'
{ connect } = require 'react-redux'

{ div, td, tr } = React.DOM

ScoreboardRow = React.createClass
  displayName: 'ScoreboardRow'

  pointsToSymbols: (points) ->
    switch points
      when 0 then ''
      when 1 then '\\'
      when 2 then 'X'
      else
        points -= 3
        output = String.fromCharCode('9421')
        while points >= 5
          output += '<span class="tally">| | | |</span>'
          points -= 5
        while points > 0
          output += ' |'
          points--
        output

  render: ->
    tr {},
      td {},
        div
          className: 'score-ticks right'
          dangerouslySetInnerHTML: {__html: @pointsToSymbols(@props.teamPoints[@props.teams.get(0).get('id')])}
      td {},
        div {className: 'middle'}, Cricket[@props.points]
      td {},
        div
          className: 'score-ticks left'
          dangerouslySetInnerHTML: {__html: @pointsToSymbols(@props.teamPoints[@props.teams.get(1).get('id')])}

mapStateToProps = (state) ->
  teams: state.team.get 'teams'
  teamPoints: {1: 10, 2: 1}

module.exports = connect(mapStateToProps)(ScoreboardRow)
