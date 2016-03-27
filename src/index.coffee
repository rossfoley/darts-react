React = require 'react'
ReactDOM = require 'react-dom'
App = require('./app')

ReactDOM.render React.createElement(App),
                document.getElementById('react-root')
