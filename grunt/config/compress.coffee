module.exports = (grunt, config) ->
  zip:
    options:
      archive: '<%= config.dist %>/<%= config.zipname %>'
      mode: 'zip'
    files: [
      {
        expand: yes
        src: ['**/*']
        dest: ''
        cwd: '<%= config.build %>/'
      }
    ]
