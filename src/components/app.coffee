React = require 'react'
{ connect } = require 'react-redux'

ScoreControls = React.createFactory require('./score_controls')
Scoreboard = React.createFactory require('./scoreboard')

{ div, h1 } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

  render: ->
    div {},
      h1 {className: 'middle'}, 'Playing Game'
      div {id: 'playing-container'},
        div {id: 'playing'},
          ScoreControls {}
          Scoreboard {}

mapStateToProps = (state) ->
  players: state.player.get 'players'

module.exports = connect(mapStateToProps)(DartsApp)
