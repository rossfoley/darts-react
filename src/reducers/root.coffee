{ combineReducers } = require 'redux'

round = require './round'
player = require './player'
team = require './team'

root = combineReducers {
  round
  player
  team
}

module.exports = root
