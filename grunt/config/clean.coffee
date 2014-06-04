module.exports = (grunt, config) ->
  build: ['<%= config.build %>']
  dist:  ['<%= config.dist %>']
  app:   ['<%= config.app %>']
