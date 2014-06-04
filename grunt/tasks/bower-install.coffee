module.exports = (grunt) ->
  grunt.registerTask 'bower-install', 'Run bower install command', ->
    done = @async()
    spawn = require('child_process').spawn
    ls = spawn('bower', ['install', '--config.interactive=false'])
    ls.stdout.on 'data', (data) ->
      grunt.log.write data

    ls.stderr.on 'data', (data) ->
      grunt.log.write data

    ls.on 'close', (code) ->
      grunt.log.writeln 'child process exited with code ' + code
      done()

