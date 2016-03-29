Immutable = require 'immutable'

{ SCORE, NEXT_ROUND, UNDO_ROUND, UNDO_SCORE } = require '../constants/round'

initialState = Immutable.fromJS rounds: [], playerOrder: []

round = (state = initialState, action) ->
  switch action.type
    when SCORE
      lastRound = state.get('rounds').count() - 1
      state.updateIn ['rounds', lastRound, 'scores'], (scores) ->
        newScore = Immutable.fromJS {points: action.points, multiplier: action.multiplier}
        scores.push newScore
    else
      state


module.exports = round
