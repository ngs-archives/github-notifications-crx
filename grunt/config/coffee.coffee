module.exports = (grunt, config) ->
  src:
    expand: yes
    cwd:  '<%= config.src %>'
    src:  '**/*.coffee'
    dest: '<%= config.app %>'
    ext:  '.js'
