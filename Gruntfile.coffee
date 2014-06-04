'use strict'

require('dotenv').load()

CSON = require 'cson-safe'

module.exports = (grunt) ->

  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'dev',     ['bower-install', 'curl', 'cson', 'jade:src', 'coffee', 'compass', 'wiredep', 'copy:src']
  grunt.registerTask 'build',   ['dev', 'uglify', 'copy:app']
  grunt.registerTask 'dist',    ['build', 'crx', 'compress']
  grunt.loadTasks './grunt/tasks'

  config =
    app:      'app'
    src:      'src'
    build:    'build'
    dist:     'dist'
    crxname:  'github-notifications-<%= config.manifest.version %>.crx'
    zipname:  'github-notifications-<%= config.manifest.version %>.zip'
    s3bucket: process.env.S3_BUCKET
    s3url:    'https://<%= config.s3bucket %>.s3.amazonaws.com'
    crxurl:   '<%= config.s3url %>/<%= config.crxname %>'
    s3path:   ''
    manifest: CSON.parse grunt.file.read 'src/manifest.cson'
    urls:
      css1: 'https://assets-cdn.github.com/assets/github-3fbc8ed7662a68f636e9db2134408ae87d1fa298.css'
      css2: 'https://assets-cdn.github.com/assets/github2-f8705d17741c213939d96bed1f5c89eb7d96b9f6.css'
      frameworks: 'https://assets-cdn.github.com/assets/frameworks-f120624597a361065113e4c5852f2894459aba3a.js'
      ga: 'https://raw.githubusercontent.com/GoogleChrome/chrome-platform-analytics/master/google-analytics-bundle.js'
      js: 'https://assets-cdn.github.com/assets/github-063276c9ee5974f7ef1bf34b7a8f7c5f4a4ea72e.js'
      octicons: 'https://assets-cdn.github.com/assets/octicons-3c84a0c3eaadc6b1de3f87d18e14aeec05bf8be4.woff'

  if process.env.TRAVIS
    config.s3path = "travis/#{process.env.TRAVIS_BRANCH}/#{process.env.TRAVIS_BUILD_NUMBER}/"

  noext = (fn)-> fn.replace(/\.coffee$/, '')

  gruntConfig = config: config
  grunt.file.recurse './grunt/config', (abspath, rootdir, subdir, filename)->
    if /\.coffee$/.test filename
      gruntConfig[noext filename] = require("./#{noext abspath}") grunt, config

  grunt.initConfig gruntConfig
