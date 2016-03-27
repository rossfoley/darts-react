Immutable = require 'immutable'

initialState = Immutable.fromJS rounds: []

round = (state = initialState, action) -> state

module.exports = round
