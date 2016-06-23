$ = require 'jquery'
FinishGame =
  submitResults: (state) ->
    window.onbeforeunload = ->
    $('#finish-game-button').html('Finishing Game...')
    $('#finish-game-button').attr('disabled', true)

    gameParams = {rounds: state.round.get('rounds').toJS()}
    gameId = state.game.get('id')
    $.ajax
      url: "/games/#{gameId}/finish"
      data: { game: gameParams }
      method: 'PUT'
      headers:
        'X-CSRF-Token': localStorage.getItem('csrf-token')
    .done (response) ->
      window.location = response.redirectUrl
    .fail ->
      window.onbeforeunload = -> 'Your game has not been saved!'
      alert 'Error finishing game!'

module.exports = FinishGame
