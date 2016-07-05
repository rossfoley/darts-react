React = require 'react'
{ connect } = require 'react-redux'

{ div, td, tr } = React.DOM

ScoreboardTotalRow = React.createClass
  displayName: 'ScoreboardTotalRow'

  render: ->
    tr {className: 'score-row'},
      td {},
        div {className: 'right'}, @props.finalScores[@props.teams.get(0).get('id')]
      td {},
        div {className: 'middle'}, 'Total'
      td {},
        div {className: 'left'}, @props.finalScores[@props.teams.get(1).get('id')]

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardTotalRow)
