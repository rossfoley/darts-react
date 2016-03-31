{ combineReducers } = require 'redux'

round = require './round'

root = combineReducers {
  round
  player: (state = {}) -> state
  team: (state = {}) -> state
  game: (state = {}) -> state
}

module.exports = root
