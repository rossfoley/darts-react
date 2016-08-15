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
          className: 'btn btn-small'
          onClick: @props.undoRound,
          'data-tip': '⌘ + x',
          'data-place': 'right',
            'Undo Round'
      td {},
        a
          href: '#'
          className: 'btn btn-small'
          onClick: @props.undoScore,
          'data-tip': '⌘ + z',
          'data-place': 'right',
            'Undo Score'

mapDispatchToProps = (dispatch) ->
  undoRound: -> dispatch(RoundActions.undoRound())
  undoScore: -> dispatch(RoundActions.undoScore())

module.exports = connect((-> {}), mapDispatchToProps)(UndoButtons)
