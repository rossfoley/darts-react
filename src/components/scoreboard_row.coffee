React = require 'react'
Cricket = require '../constants/cricket'
{ connect } = require 'react-redux'

{ div, td, tr } = React.DOM

ScoreboardRow = React.createClass
  displayName: 'ScoreboardRow'

  render: ->
    tr {},
      td {},
        div {className: 'right'}, '' # Team 1 points
      td {},
        div {className: 'middle'}, Cricket[@props.points]
      td {},
        div {className: 'left'}, '' # Team 2 points

mapStateToProps = (state) ->
  teams: state.team.get 'teams'

module.exports = connect(mapStateToProps)(ScoreboardRow)
