module.exports = (grunt, config) ->
  src:
    expand: yes
    cwd:  '<%= config.src %>'
    src:  '**/*.cson'
    dest: '<%= config.app %>'
    ext:  '.json'
