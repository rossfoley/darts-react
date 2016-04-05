React = require 'react'
CricketUtils = require '../common/cricket_utils'
{ connect } = require 'react-redux'
$ = require 'jquery'

PlayerOrderList = React.createFactory require('./player_order_list')
ScoringTable = React.createFactory require('./scoring_table')
Scoreboard = React.createFactory require('./scoreboard')
PlayerMPRTable = React.createFactory require('./player_mpr_table')

{ div, h1 } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

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

module.exports = connect(mapStateToProps)(DartsApp)
