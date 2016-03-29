React = require 'react'
ReactDOM = require 'react-dom'
{ createStore, applyMiddleware, compose } = require 'redux'
ReactRedux = require 'react-redux'
Thunk = require 'redux-thunk'
Immutable = require 'immutable'
$ = require 'jquery'
Provider = React.createFactory ReactRedux.Provider

App = React.createFactory require('./components/app')
RootReducer = require './reducers/root'

initialState = ->
  player: Immutable.fromJS {players: [{id: 1, name: 'Ross'}]}
  team: Immutable.fromJS {teams: [{id: 1, name: 'Ross'}, {id: 2, name: 'Other'}]}
  round: Immutable.fromJS {rounds: [
    {player_id: 1, team_id: 1, scores: [
      {points: '20', multiplier: 3},
      {points: '20', multiplier: 2},
      {points: '25', multiplier: 1},
    ]},
    {player_id: 1, team_id: 2, scores: [
      {points: '20', multiplier: 3},
      {points: '18', multiplier: 3},
      {points: '25', multiplier: 1},
    ]}
  ]}

finalCreateStore = compose(
  applyMiddleware(Thunk),
  if window.devToolsExtension then window.devToolsExtension() else (x) -> x
)(createStore);

$ ->
  reactRoot = $('#react-root')

  if reactRoot.length
    store = finalCreateStore(RootReducer, initialState())
    ReactDOM.render (
      Provider {store},
        App {}
    ), reactRoot[0]
