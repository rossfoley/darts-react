React = require 'react'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'
$ = require 'jquery'
ReactTooltip = React.createFactory require('react-tooltip')

PlayerOrderList = React.createFactory require('./player_order_list')
ScoringTable = React.createFactory require('./scoring_table')
Scoreboard = React.createFactory require('./scoreboard')
PlayerMPRTable = React.createFactory require('./player_mpr_table')
KeyboardShortcuts = React.createFactory require('./keyboard_shortcuts')
BotSimulator = React.createFactory require('./bot_simulator')

{ div } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

  componentDidUpdate: ->
    $('.btn').mouseup -> $(@).blur()

  render: ->
    div {},
      div {id: 'playing-container'},
        div {id: 'playing'},
          PlayerOrderList {}
          ScoringTable {scoreboard: @props.scoreboard}
          Scoreboard {scoreboard: @props.scoreboard}
          PlayerMPRTable {}
      KeyboardShortcuts {scoreboard: @props.scoreboard}
      BotSimulator {scoreboard: @props.scoreboard}
      ReactTooltip {}

mapStateToProps = (state) ->
  scoreboard: CricketUtils.computeScoreboard(state.round.get('rounds'), state.team.get('teams'))

module.exports = connect(mapStateToProps)(DartsApp)
