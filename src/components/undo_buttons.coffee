React = require 'react'

{ a, td, tr } = React.DOM

UndoButtons = React.createClass
  displayName: 'UndoButtons'

  render: ->
    tr {},
      td {},
        a {className: 'btn btn-primary'}, 'Undo Round'
      td {},
        a {className: 'btn btn-primary'}, 'Undo Score'

module.exports = UndoButtons
