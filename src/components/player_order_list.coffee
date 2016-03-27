React = require 'react'
{ connect } = require 'react-redux'

{ li, ul } = React.DOM

ScoreControls = React.createClass
  displayName: 'ScoreControls'

  render: ->
    ul {id: 'player-order-list'},
      @props.players.map (player, i) =>
        className = if player.get('id') is @props.activePlayerId then 'active-player' else ''
        li {key: player.get('id'), className}, player.get 'name'

mapStateToProps = (state) ->
  players: state.player.get 'players'
  activePlayerId: state.player.get('players').get(0).get 'id'

module.exports = connect(mapStateToProps)(ScoreControls)
