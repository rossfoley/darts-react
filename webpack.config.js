var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    './src/index'
  ],
  devtool: "eval",
  debug: true,
  output: {
    path: path.join(__dirname, "public"),
    filename: 'bundle.js'
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  resolve: {
    extensions: ['', '.js', '.coffee']
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loaders: ['react-hot', 'coffee'], include: path.join(__dirname, 'src') }
    ]
  }
};
