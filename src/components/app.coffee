React = require 'react'

PlayerOrderList = React.createFactory require('./player_order_list')
ScoringTable = React.createFactory require('./scoring_table')
Scoreboard = React.createFactory require('./scoreboard')

{ div, h1 } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'

  render: ->
    div {},
      h1 {className: 'middle'}, 'Playing Game'
      div {id: 'playing-container'},
        div {id: 'playing'},
          PlayerOrderList {}
          ScoringTable {}
          Scoreboard {}

module.exports = DartsApp
