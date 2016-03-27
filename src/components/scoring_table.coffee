React = require 'react'
Cricket = require '../constants/cricket'
_ = require 'underscore'

ScoringButtons = React.createFactory require('./scoring_buttons')

{ table, tbody, th, thead, tr } = React.DOM

ScoringTable = React.createClass
  displayName: 'ScoringTable'

  render: ->
    table {className: 'table table-bordered table-hover', id: 'scoring-table'},
      thead {},
        tr {},
          th {}, 'Points'
          th {}, 'Score'
      tbody {},
        _.keys(Cricket).map (points) ->
          ScoringButtons {points, key: points}

module.exports = ScoringTable
