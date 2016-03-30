{ SCORE, NEXT_ROUND, UNDO_ROUND, UNDO_SCORE } = require '../constants/round'

Round =
  score: (points, multiplier, scoreboard) -> {points, multiplier, scoreboard, type: SCORE}
  nextRound: -> {type: NEXT_ROUND}
  undoRound: -> {type: UNDO_ROUND}
  undoScore: -> {type: UNDO_SCORE}

module.exports = Round
