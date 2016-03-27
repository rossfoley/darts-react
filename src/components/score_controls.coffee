React = require 'react'

PlayerOrderList = React.createFactory require('./player_order_list')
ScoringTable = React.createFactory require('./scoring_table')

{ div, h2 } = React.DOM

ScoreControls = React.createClass
  displayName: 'ScoreControls'

  render: ->
    div {},
      PlayerOrderList {}
      ScoringTable {}

module.exports = ScoreControls
