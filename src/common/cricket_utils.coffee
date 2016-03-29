CricketPoints = require '../constants/cricket_points'
_ = require 'underscore'

scoreReducer = (points) ->
  (acc, score) ->
    if score.get('points') is points
      acc + parseInt(score.get('multiplier'))
    else
      acc

roundTotal = (team, rounds, points) ->
  teamRounds = rounds.filter (round) -> round.get('team_id') is team.get('id')
  teamRounds.reduce ((acc, round) -> acc + round.get('scores').reduce(scoreReducer(points), 0)), 0

CricketUtils =
  computeScoreboard: (rounds, teams) ->
    _.keys(CricketPoints).reduce ((scoreboard, points) ->

      teamScores = teams.reduce ((teamScore, team) ->
        total = roundTotal(team, rounds, points)
        teamScore[team.get('id')] = {total, closed: total >= 3}
        teamScore), {}

      scoreboard[points] = teamScores
      scoreboard
    ), {}

  finalScores: (scoreboard, teams) ->
    _.object(teams.toArray().map (team) ->
      [team.get('id'), _.keys(scoreboard).reduce ((acc, points) ->
        actualTotal = Math.max(0, scoreboard[points][team.get('id')].total - 3)
        acc + actualTotal * parseInt(points)
      ), 0]
    )



module.exports = CricketUtils
