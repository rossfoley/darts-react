CricketPoints = require '../constants/cricket_points'
_ = require 'underscore'

scoreReducer = (points) ->
  (acc, score) ->
    if score.get('points') is points
      acc + parseInt(score.get('multiplier'))
    else
      acc

CricketUtils =
  computeScoreboard: (rounds, teams) ->
    _.keys(CricketPoints).reduce ((scoreboard, points) ->
      teamScores = teams.reduce ((teamScore, team) ->
        teamRounds = rounds.filter (round) -> round.get('team_id') is team.get('id')
        total = teamRounds.reduce ((acc, round) ->
          acc + round.get('scores').reduce(scoreReducer(points), 0)), 0
        teamScore[team.get('id')] = {total: total, closed: total > 3}
        teamScore), {}
      scoreboard[points] = teamScores
      scoreboard
    ), {}



module.exports = CricketUtils