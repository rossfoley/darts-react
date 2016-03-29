React = require 'react'
CricketPoints = require '../constants/cricket_points'
RoundActions = require '../actions/round'
{ connect } = require 'react-redux'

{ a, div, td, tr } = React.DOM

ScoringButtons = React.createClass
  displayName: 'ScoringButtons'

  availableMarks: ->
    return [1, 2] if parseInt(@props.points) is 25
    [1, 2, 3]

  scoreClick: (multiplier) -> (=> @props.score(multiplier))

  render: ->
    marks = @availableMarks()

    tr {},
      td {}, CricketPoints[@props.points]
      td {},
        div {className: 'btn-group'},
          marks.map (mark) =>
            a {href: '#', className: 'btn btn-primary', onClick: @scoreClick(mark), key: mark}, "#{mark}x"


mapDispatchToProps = (dispatch, props) ->
  score: (multiplier) ->
    dispatch(RoundActions.score(props.points, multiplier))

module.exports = connect((-> {}), mapDispatchToProps)(ScoringButtons)
