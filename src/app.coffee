React = require 'react'

{ div } = React.DOM

DartsApp = React.createClass
  displayName: 'Darts'
  render: ->
    div {}, 'Hello World'

module.exports = DartsApp
