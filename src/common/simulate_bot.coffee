_ = require 'underscore'

simulateBot = (botData) ->
  pointProbabilities = botData['probabilities']['points']
  totalProbability = _.reduce(_.values(pointProbabilities), (sum, points) -> sum + points)
  if Math.random() < botData['probabilities']['hit']
    hit = Math.floor(Math.random() * totalProbability)
    points = null
    _.each pointProbabilities, (probability, score) ->
      if hit >= 0 and hit <= probability
        points = JSON.parse(score)
      hit -= probability
    points
  else
    null


module.exports = simulateBot
