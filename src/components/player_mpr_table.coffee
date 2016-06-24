React = require 'react'
{ connect } = require 'react-redux'

PlayerMPR = require '../common/player_mpr'

{ div, hr, table, tbody, thead, td, th, tr } = React.DOM

PlayerMPRTable = React.createClass
  displayName: 'PlayerMPRTable'

  roundMPR: (mpr) -> Math.round(mpr * 100) / 100

  render: ->
    div {className: 'clearfix'},
      hr {}
      table {className: 'table table-hover table-striped'},
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
