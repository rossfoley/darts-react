React = require 'react'

{ div } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'
  render: ->
    div {}, 'Dart Scoreboard & Stat Tracker'

module.exports = DartsApp
