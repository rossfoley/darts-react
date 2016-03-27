Immutable = require 'immutable'

initialState = Immutable.fromJS teams: []

team = (state = initialState, action) -> state

module.exports = team
