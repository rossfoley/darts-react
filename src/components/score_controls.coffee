React = require 'react'
Cricket = require '../constants/cricket'
{ connect } = require 'react-redux'
_ = require 'underscore'

PlayerOrderList = React.createFactory require('./player_order_list')

{ div, h2, li, ul } = React.DOM

ScoreControls = React.createClass
  displayName: 'ScoreControls'

  render: ->
    div {},
      h2 {}, 'Score Controls'
      PlayerOrderList {}
      _.values(Cricket).map (point) ->
        div {key: point}, point

mapStateToProps = (state) ->
  players: state.player.get 'players'

module.exports = connect(mapStateToProps)(ScoreControls)
