module.exports = (grunt) ->

  CSON = require 'cson-safe'
  manifest = CSON.parse grunt.file.read 'src/manifest.cson'

  syncVersion = (file)->
    data = grunt.file.readJSON file
    data.version = manifest.version
    grunt.file.write file, JSON.stringify data, null, 2

  grunt.registerTask 'sync-version', 'Sync {package,bower}.json version with manifest.cson', ->
    syncVersion 'bower.json'
    syncVersion 'package.json'
