Immutable = require 'immutable'

{ SCORE, NEXT_ROUND, UNDO_ROUND, UNDO_SCORE } = require '../constants/round'

initialState = Immutable.fromJS rounds: [], playerOrder: []

round = (state = initialState, action) ->
  switch action.type
    when SCORE
      # TODO: Add correct scoring validation logic
      scoreCount = state.get('rounds').last().get('scores').count()
      return state if scoreCount >= 3
      state.updateIn ['rounds', -1, 'scores'], (scores) ->
        newScore = Immutable.fromJS {points: action.points, multiplier: action.multiplier}
        scores.push newScore

    when NEXT_ROUND
      currentPersonId = state.get('rounds').last().get('player_id')
      currentIndex = state.get('playerOrder').findIndex (player) ->
        player.get('player_id') is currentPersonId
      newIndex = (currentIndex + 1) % state.get('playerOrder').count()
      nextPlayerData = state.get('playerOrder').get(newIndex)
      state.updateIn ['rounds'], (rounds) ->
        newRound =
          player_id: nextPlayerData.get('player_id')
          team_id: nextPlayerData.get('team_id')
          scores: []
        rounds.push(Immutable.fromJS(newRound))

    when UNDO_ROUND
      roundCount = state.get('rounds').count()
      return state unless roundCount > 1
      state.deleteIn ['rounds', -1]

    when UNDO_SCORE
      scoreCount = state.get('rounds').last().get('scores').count()
      return state if scoreCount is 0
      state.deleteIn ['rounds', -1, 'scores', -1]

    else
      state


module.exports = round
