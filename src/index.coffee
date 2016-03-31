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

initialState = (data) ->
  game: Immutable.fromJS data.game
  player: Immutable.fromJS players: data.players
  team: Immutable.fromJS teams: data.teams
  round: Immutable.fromJS rounds: data.rounds, playerOrder: data.playerOrder

finalCreateStore = compose(
  applyMiddleware(Thunk),
  if window.devToolsExtension then window.devToolsExtension() else (x) -> x
)(createStore)

$ ->
  reactRoot = $('#react-root')

  if reactRoot.length
    window.onbeforeunload = -> 'Your game has not been saved!'

    csrf = jQuery('meta[name="csrf-token"]').attr('content')
    localStorage.setItem('csrf-token', csrf)

    data = reactRoot.data 'initial-state'
    store = finalCreateStore(RootReducer, initialState(data))

    ReactDOM.render (
      Provider {store},
        App {}
    ), reactRoot[0]
