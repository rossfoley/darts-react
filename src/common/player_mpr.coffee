playerMPR = (rounds) ->
  (player) ->
    playerRounds = rounds.filter (round) -> round.get('player_id') is player.get('id')
    return {name: player.get('name'), mpr: 0} if playerRounds.count() is 0
    totalMarks = playerRounds.reduce ((marks, round) ->
      marks + round.get('scores').reduce ((acc, score) -> acc + score.get('multiplier')), 0
    ), 0
    {name: player.get('name'), mpr: (totalMarks / playerRounds.count())}

PlayerMPR =
  computeMPRs: (players, rounds) ->
    players.map(playerMPR(rounds)).sortBy((player) -> player.mpr).reverse()

module.exports = PlayerMPR
