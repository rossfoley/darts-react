React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'
FinishGame = require '../common/finish_game'

{ a, div, table, tbody, th, thead, tr, td } = React.DOM

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
    div {id: 'player-order-list', className: 'col s2'},
      table {className: 'bordered'},
        thead {},
          tr {},
            th {}, 'Players'
        tbody {},
          @props.players.map (player) =>
            className = if player.get('id') is @props.activePlayerId then 'active-player' else ''
            tr {key: player.get('id')},
              td
                className: className
                'data-tip': @playerTooltip(player),
                'data-place': 'right'
                title: @playerTooltip(player),
                  player.get 'name'
          tr {className: 'button-row'},
            td {},
              a
                href: '#'
                className: 'btn btn-small'
                id: 'next-button'
                onClick: @props.nextRound,
                'data-tip': 'Space'
                'data-place': 'right'
                title: 'Space',
                  'Next Round'
          unless @props.training
            tr {className: 'button-row'},
              td {},
                a
                  href: '#'
                  className: 'btn btn-small'
                  id: 'finish-game-button'
                  onClick: @finishGame,
                  'data-tip': '⌘ + Enter'
                  'data-place': 'right'
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
