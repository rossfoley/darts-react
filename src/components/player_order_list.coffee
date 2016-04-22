React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'
$ = require 'jquery'
FinishGame = require '../common/finish_game'

{ a, table, tbody, th, thead, tr, td } = React.DOM

ScoreControls = React.createClass
  displayName: 'ScoreControls'

  componentDidMount: ->
    $(window).keydown (e) =>
      if e.keyCode is 32
        e.preventDefault()
        @props.nextRound()

  finishGame: (e) ->
    e.preventDefault()
    FinishGame.submitResults(@props.finishGameState)

  render: ->
    table {id: 'player-order-list', className: 'table table-bordered'},
      thead {},
        tr {},
          th {}, 'Players'
      tbody {},
        @props.players.map (player) =>
          className = if player.get('id') is @props.activePlayerId then 'active-player' else ''
          tr {key: player.get('id')},
            td {className}, player.get 'name'
        tr {className: 'button-row'},
          td {},
            a {href: '#', className: 'btn btn-primary', onClick: @props.nextRound, id: 'next-button'}, 'Next Round'
        tr {className: 'button-row'},
          td {},
            a {href: '#', className: 'btn btn-primary', onClick: @finishGame, id: 'finish-game-button'}, 'Finish Game'

mapStateToProps = (state) ->
  players: state.player.get 'players'
  activePlayerId: state.round.get('rounds').last().get('player_id')
  finishGameState: state

mapDispatchToProps = (dispatch) ->
  nextRound: -> dispatch(RoundActions.nextRound())

module.exports = connect(mapStateToProps, mapDispatchToProps)(ScoreControls)
