React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'
FinishGame = require '../common/finish_game'

{ a, table, tbody, th, thead, tr, td } = React.DOM

PlayerOrderList = React.createClass
  displayName: 'PlayerOrderList'

  finishGame: (e) ->
    e.preventDefault()
    FinishGame.submitResults(@props.finishGameState)

  playerTooltip: (player) ->
    recentMpr = Math.round(parseFloat(player.get('recent_mpr')) * 100) / 100
    "Recent MPR: #{recentMpr}"

  componentDidMount: ->
    $('[data-toggle="tooltip"]').tooltip(container: 'body')

  render: ->
    table {id: 'player-order-list', className: 'table table-bordered'},
      thead {},
        tr {},
          th {}, 'Players'
      tbody {},
        @props.players.map (player) =>
          className = if player.get('id') is @props.activePlayerId then 'active-player' else ''
          tr {key: player.get('id')},
            td
              className: className
              'data-toggle': 'tooltip'
              'data-placement': 'right'
              title: @playerTooltip(player),
                player.get 'name'
        tr {className: 'button-row'},
          td {},
            a
              href: '#'
              className: 'btn btn-primary'
              id: 'next-button'
              onClick: @props.nextRound,
              'data-toggle': 'tooltip'
              'data-placement': 'right'
              title: 'Space',
                'Next Round'
        unless @props.training
          tr {className: 'button-row'},
            td {},
              a
                href: '#'
                className: 'btn btn-primary'
                id: 'finish-game-button'
                onClick: @finishGame,
                'data-toggle': 'tooltip'
                'data-placement': 'right'
                title: '⌘ + Enter',
                  'Finish Game'

mapStateToProps = (state) ->
  players: state.player.get 'players'
  activePlayerId: state.round.get('rounds').last().get('player_id')
  training: state.game.get('training')
  finishGameState: state

mapDispatchToProps = (dispatch) ->
  nextRound: -> dispatch(RoundActions.nextRound())

module.exports = connect(mapStateToProps, mapDispatchToProps)(PlayerOrderList)
