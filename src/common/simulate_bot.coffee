Immutable = require 'immutable'
_ = require 'underscore'

simulateBot = (botData, state) ->
  pointProbabilities = botData.getIn(['probabilities', 'points']).toJS()
  totalProbability = _.reduce(_.values(pointProbabilities), (sum, points) -> sum + points)
  scores = _.compact([0..2].map ->
    if Math.random() < botData.getIn(['probabilities', 'hit'])
      hit = Math.floor(Math.random() * totalProbability)
      points = null
      _.each pointProbabilities, (probability, score) ->
        if hit >= 0 and hit <= probability
          points = JSON.parse(score)
        hit -= probability
      { points: "#{points[0]}", multiplier: points[1] }
    else
      null
  )
  console.log scores
  nextPlayerData = state.get('playerOrder').first()
  state.updateIn(['rounds', -1, 'scores'], -> Immutable.fromJS(scores)).updateIn(['rounds'], (rounds) ->
    newRound =
      player_id: nextPlayerData.get('player_id')
      team_id: nextPlayerData.get('team_id')
      scores: []
    rounds.push(Immutable.fromJS(newRound))
  )


module.exports = simulateBot
