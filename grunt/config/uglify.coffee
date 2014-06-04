module.exports = (grunt, config) ->
  app:
    expand: yes
    cwd:  '<%= config.app %>'
    src:  [
      'scripts/*.js'
      '!bower_components/**/*.js'
      'bower_components/jquery/dist/jquery.js'
    ]
    dest: '<%= config.build %>'
