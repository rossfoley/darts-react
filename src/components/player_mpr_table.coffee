React = require 'react'
{ connect } = require 'react-redux'

PlayerMPR = require '../common/player_mpr'

{ div, table, tbody, thead, td, th, tr } = React.DOM

PlayerMPRTable = React.createClass
  displayName: 'PlayerMPRTable'

  roundMPR: (mpr) -> Math.round(mpr * 100) / 100

  render: ->
    div {className: 'clearfix'},
      table {className: 'bordered highlight'},
        thead {},
          tr {},
            th {}, 'Player'
            th {}, 'MPR'
        tbody {},
          @props.playerMPRs.map (playerMPR) =>
            tr {key: playerMPR.name},
              td {}, playerMPR.name
              td {}, @roundMPR(playerMPR.mpr)

mapStateToProps = (state) ->
  playerMPRs: PlayerMPR.computeMPRs(state.player.get('players'), state.round.get('rounds'))

module.exports = connect(mapStateToProps)(PlayerMPRTable)
