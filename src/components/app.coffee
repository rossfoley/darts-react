React = require 'react'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'
$ = require 'jquery'
RoundActions = require '../actions/round'
FinishGame = require '../common/finish_game'

PlayerOrderList = React.createFactory require('./player_order_list')
ScoringTable = React.createFactory require('./scoring_table')
Scoreboard = React.createFactory require('./scoreboard')
PlayerMPRTable = React.createFactory require('./player_mpr_table')

{ div, h1 } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

  componentDidMount: ->
    key 'space', => @props.nextRound()
    key 'command+z', => @props.undoScore()
    key 'command+x', => @props.undoRound()
    key 'command+s', => FinishGame.submitResults(@props.finishGameState)

  componentDidUpdate: ->
    $('.btn').mouseup -> $(@).blur()

  render: ->
    div {},
      h1 {className: 'middle'}, 'Playing Game'
      div {id: 'playing-container'},
        div {id: 'playing'},
          PlayerOrderList {}
          ScoringTable {scoreboard: @props.scoreboard}
          Scoreboard {scoreboard: @props.scoreboard}
          PlayerMPRTable {}

mapStateToProps = (state) ->
  scoreboard: CricketUtils.computeScoreboard(state.round.get('rounds'), state.team.get('teams'))
  finishGameState: state

mapDispatchToProps = (dispatch) ->
  nextRound: -> dispatch(RoundActions.nextRound())
  undoRound: -> dispatch(RoundActions.undoRound())
  undoScore: -> dispatch(RoundActions.undoScore())

module.exports = connect(mapStateToProps, mapDispatchToProps)(DartsApp)
