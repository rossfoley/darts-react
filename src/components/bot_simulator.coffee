React = require 'react'
{ connect } = require 'react-redux'
RoundActions = require '../actions/round'
_ = require 'underscore'
simulateBot = require '../common/simulate_bot'

{ div } = React.DOM

BotSimulator = React.createClass
  displayName: 'BotSimulator'

  makeBotThrow: ->
    if @props.currentPlayer['bot']
      if parseInt(localStorage.getItem('bot-throws')) >= 3
        localStorage.setItem('bot-throws', 0)
        @props.nextRound()
      else
        localStorage.setItem('bot-throws', parseInt(localStorage.getItem('bot-throws')) + 1)
        botThrow = simulateBot(@props.currentPlayer)
        if botThrow
          @props.score("#{botThrow[0]}", botThrow[1])
        else
          setTimeout (=> @makeBotThrow()), 500

  componentDidUpdate: -> setTimeout (=> @makeBotThrow()), 500

  render: -> div {}

mapStateToProps = (state) ->
  currentPlayer: _.findWhere(state.round.get('playerOrder').toJS(),
                             player_id: state.round.get('rounds').last().get('player_id'))

mapDispatchToProps = (dispatch, props) ->
  nextRound: -> dispatch(RoundActions.nextRound())
  score: (points, multiplier) ->
    dispatch(RoundActions.score(points, multiplier, props.scoreboard[points]))

module.exports = connect(mapStateToProps, mapDispatchToProps)(BotSimulator)
