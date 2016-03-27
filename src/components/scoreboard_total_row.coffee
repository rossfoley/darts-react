React = require 'react'
Cricket = require '../constants/cricket'
{ connect } = require 'react-redux'

{ div, td, tr } = React.DOM

ScoreboardTotalRow = React.createClass
  displayName: 'ScoreboardTotalRow'

  render: ->
    tr {className: 'score-row'},
      td {},
        div {className: 'right'}, '0' # Team 1 total points
      td {},
        div {className: 'middle'}, 'Total'
      td {},
        div {className: 'left'}, '0' # Team 2 total points

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardTotalRow)
