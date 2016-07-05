React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'

{ a, td, tr } = React.DOM

UndoButtons = React.createClass
  displayName: 'UndoButtons'

  render: ->
    tr {},
      td {},
        a
          href: '#'
          className: 'btn btn-primary'
          onClick: @props.undoRound,
          'data-toggle': 'tooltip'
          'data-placement': 'left'
          title: '⌘+x',
            'Undo Round'
      td {},
        a
          href: '#'
          className: 'btn btn-primary'
          onClick: @props.undoScore,
          'data-toggle': 'tooltip'
          'data-placement': 'right'
          title: '⌘+z',
            'Undo Score'

mapDispatchToProps = (dispatch) ->
  undoRound: -> dispatch(RoundActions.undoRound())
  undoScore: -> dispatch(RoundActions.undoScore())

module.exports = connect((-> {}), mapDispatchToProps)(UndoButtons)
