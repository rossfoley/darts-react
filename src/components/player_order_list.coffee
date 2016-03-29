React = require 'react'
{ connect } = require 'react-redux'

{ a, li, ul } = React.DOM

ScoreControls = React.createClass
  displayName: 'ScoreControls'

  render: ->
    ul {id: 'player-order-list'},
      @props.players.map (player, i) =>
        className = if player.get('id') is @props.activePlayerId then 'active-player' else ''
        li {key: player.get('id'), className}, player.get 'name'
      li {}, a {href: '#', className: 'btn btn-primary', id: 'next-button'}, 'Next Round'
      li {}, a {href: '#', className: 'btn btn-primary', id: 'finish-game-button'}, 'Finish Game'

mapStateToProps = (state) ->
  players: state.player.get 'players'
  activePlayerId: state.round.get('rounds').last().get('player_id')

module.exports = connect(mapStateToProps)(ScoreControls)
