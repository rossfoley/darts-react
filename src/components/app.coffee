React = require 'react'
{ connect } = require 'react-redux'

{ div } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

  render: ->
    div {},
      div {}, 'Dart Scoreboard & Stat Tracker'
      @props.players.map (player) ->
        div {key: player.get('id')}, player.get 'name'

mapStateToProps = (state) ->
  players: state.player.get 'players'

module.exports = connect(mapStateToProps)(DartsApp)
