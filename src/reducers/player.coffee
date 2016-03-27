Immutable = require 'immutable'

initialState = Immutable.fromJS players: []

player = (state = initialState, action) -> state

module.exports = player
