React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'
FinishGame = require '../common/finish_game'

{ dd, div, dl, dt, hr } = React.DOM

KeyboardShortcuts = React.createClass
  displayName: 'KeyboardShortcuts'
  pointKeys: {'5': '15', '6': '16', '7': '17', '8': '18', '9': '19', '0': '20', '1': '25'}

  componentDidMount: ->
    key 'space', => @props.nextRound() and off
    key 'command+z', => @props.undoScore() and off
    key 'command+x', => @props.undoRound() and off
    key 'command+enter', => FinishGame.submitResults(@props.finishGameState) and off
    $(document).on 'keydown', @scoreKey

  scoreKey: (e) ->
    if @pointKeys[e.key]
      points = @pointKeys[e.key]
      if @isTriple e
        @props.score(points, 3)
      else if @isDouble e
        @props.score(points, 2)
      else
        @props.score(points, 1)
      return off
    on

  isTriple: (e) -> e.metaKey and e.ctrlKey
  isDouble: (e) -> e.metaKey

  render: ->
    div {id: 'shortcuts', onKeyPress: @scoreKey},
      hr {}
      dl {className: 'dl-horizontal'},
        dt {}, '5 - 0'
        dd {}, 'Score single 15-20'

        dt {}, '1'
        dd {}, 'Score single bull'

        dt {}, '⌘+point'
        dd {}, 'Score double'

        dt {}, '⌘+⌃+point'
        dd {}, 'Score triple'

        dt {}, 'Space'
        dd {}, 'Next Round'

        dt {}, '⌘+z'
        dd {}, 'Undo Score'

        dt {}, '⌘+x'
        dd {}, 'Undo Round'

        dt {}, '⌘+enter'
        dd {}, 'Finish Game'

mapStateToProps = (state) ->
  finishGameState: state

mapDispatchToProps = (dispatch, props) ->
  nextRound: -> dispatch(RoundActions.nextRound())
  undoRound: -> dispatch(RoundActions.undoRound())
  undoScore: -> dispatch(RoundActions.undoScore())
  score: (points, multiplier) ->
    dispatch(RoundActions.score(points, multiplier, props.scoreboard[points]))

module.exports = connect(mapStateToProps, mapDispatchToProps)(KeyboardShortcuts)
