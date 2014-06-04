module.exports = (grunt, config) ->
  compass:
    files: ['<%= config.src %>/**/*.sass']
    tasks: ['compass']
  coffee:
    files: ['<%= config.src %>/**/*.coffee']
    tasks: ['coffee']
  cson:
    files: ['<%= config.src %>/**/*.cson']
    tasks: ['cson']
  version:
    files: ['<%= config.src %>/manifest.cson']
    tasks: ['sync-version']
  jade_src:
    files: ['<%= config.src %>/**/*.jade']
    tasks: ['jade:src', 'wiredep:app']
  src_png:
    files: ['<%= config.src %>/**/*.png']
    tasks: ['copy:src']
