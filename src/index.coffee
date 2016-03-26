ReactDOM = require 'react-dom'
App = React.createFactory require('./app')

console.log 'RUNNING'
ReactDOM.render App {}, document.getElementById('react-root')
