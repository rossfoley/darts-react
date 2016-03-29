React = require 'react'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'

{ div, td, tr } = React.DOM

ScoreboardTotalRow = React.createClass
  displayName: 'ScoreboardTotalRow'

  render: ->
    finalScores = CricketUtils.finalScores(@props.scoreboard, @props.teams)
    tr {className: 'score-row'},
      td {},
        div {className: 'right'}, finalScores[@props.teams.get(0).get('id')]
      td {},
        div {className: 'middle'}, 'Total'
      td {},
        div {className: 'left'}, finalScores[@props.teams.get(1).get('id')]

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardTotalRow)
