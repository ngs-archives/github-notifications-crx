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
      css1: 'https://assets-cdn.github.com/assets/github-45a6b17d0e8fc68a83b5b85ae19012e6daf9a07b.css'
      css2: 'https://assets-cdn.github.com/assets/github2-0ee6a4d6913e5429aa63ee76db3b03a8f84e7aaf.css'
      frameworks: 'https://assets-cdn.github.com/assets/frameworks-ec74d07786e954c40f894a87e76f9896dc859586.js'
      ga: 'https://raw.githubusercontent.com/GoogleChrome/chrome-platform-analytics/master/google-analytics-bundle.js'
      js: 'https://assets-cdn.github.com/assets/github-f9f988d91282b8bfa90164066e6a3515f59b5c32.js'
      octicons: 'https://assets-cdn.github.com/assets/octicons-3c84a0c3eaadc6b1de3f87d18e14aeec05bf8be4.woff'

  if process.env.TRAVIS
    config.s3path = "travis/#{process.env.TRAVIS_BRANCH}/#{process.env.TRAVIS_BUILD_NUMBER}/"

  noext = (fn)-> fn.replace(/\.coffee$/, '')

  gruntConfig = config: config
  grunt.file.recurse './grunt/config', (abspath, rootdir, subdir, filename)->
    if /\.coffee$/.test filename
      gruntConfig[noext filename] = require("./#{noext abspath}") grunt, config

  grunt.initConfig gruntConfig
