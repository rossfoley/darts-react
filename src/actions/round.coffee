{ SCORE, NEXT_ROUND, UNDO_ROUND, UNDO_SCORE } = require '../constants/round'

Round =
  score: (points, multiplier) -> {points, multiplier, type: SCORE}
  nextRound: -> {type: NEXT_ROUND}
  undoRound: -> {type: UNDO_ROUND}
  undoScore: -> {type: UNDO_SCORE}

module.exports = Round
