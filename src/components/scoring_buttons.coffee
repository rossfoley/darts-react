React = require 'react'
CricketPoints = require '../constants/cricket_points'
Shortcuts = require '../constants/shortcuts'
RoundActions = require '../actions/round'
{ connect } = require 'react-redux'
_ = require 'underscore'

{ a, div, td, tr } = React.DOM

ScoringButtons = React.createClass
  displayName: 'ScoringButtons'
  markModifiers: {1: '', 2: '⌘ + ', 3: '⌘ + ⌃ + '}

  availableMarks: ->
    return [1, 2] if parseInt(@props.points) is 25
    [1, 2, 3]

  scoreClick: (multiplier) -> (=> @props.score(multiplier))

  btnClass: (mark) ->
    currentTeamScoreboard = @props.scoreboard[@props.currentTeam]
    otherTeamScoreboard = _.values(_.omit(@props.scoreboard, @props.currentTeam))[0]
    if otherTeamScoreboard.closed
      return 'disabled' if currentTeamScoreboard.closed or (mark + currentTeamScoreboard.total) > 3
    else
      return 'btn-success' if currentTeamScoreboard.closed
    ''

  shortcutText: (mark) ->
    key = _.invert(Shortcuts)[@props.points]
    @markModifiers[mark] + key

  render: ->
    marks = @availableMarks()

    tr {},
      td {}, CricketPoints[@props.points]
      td {},
        div {className: 'btn-group'},
          marks.map (mark) =>
            a
              href: '#'
              className: "btn btn-primary #{@btnClass(mark)}"
              onClick: @scoreClick(mark)
              'data-toggle': 'tooltip'
              'data-placement': 'right'
              title: @shortcutText(mark)
              key: mark,
                "#{mark}x"

mapStateToProps = (state) ->
  currentTeam: state.round.get('rounds').last().get('team_id')

mapDispatchToProps = (dispatch, props) ->
  score: (multiplier) ->
    dispatch(RoundActions.score(props.points, multiplier, props.scoreboard))

module.exports = connect(mapStateToProps, mapDispatchToProps)(ScoringButtons)
