module.exports = (grunt, config) ->
  ga:
    dest: '<%= config.app %>/vendor/google-analytics-bundle.js'
    src: '<%= config.urls.ga %>'
  js:
    dest: '<%= config.app %>/vendor/github.js'
    src: '<%= config.urls.js %>'
  frameworks:
    dest: '<%= config.app %>/vendor/frameworks.js'
    src: '<%= config.urls.frameworks %>'
  octicons:
    dest: '<%= config.app %>/vendor/octicons.woff'
    src: '<%= config.urls.octicons %>'
  css1:
    dest: '<%= config.app %>/vendor/github1.css'
    src: '<%= config.urls.css1 %>'
  css2:
    dest: '<%= config.app %>/vendor/github2.css'
    src: '<%= config.urls.css2 %>'
