React = require 'react'
Cricket = require '../constants/cricket'
{ connect } = require 'react-redux'
_ = require 'underscore'

{ div, h2 } = React.DOM

Scoreboard = React.createClass
  displayName: 'Scoreboard'

  render: ->
    div {},
      h2 {}, 'Scoreboard'
      _.values(Cricket).map (point) ->
        div {key: point}, point

mapStateToProps = (state) ->
  players: state.player.get 'players'

module.exports = connect(mapStateToProps)(Scoreboard)
