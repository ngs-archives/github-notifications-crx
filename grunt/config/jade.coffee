module.exports = (grunt, config) ->
  options:
    data:
      config: config
  src:
    expand: yes
    cwd:  config.src
    src:  '**/*.jade'
    dest: config.app
    ext:  '.html'
