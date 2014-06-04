module.exports = (grunt, config) ->
  compile:
    src: '<%= config.build %>'
    dest: '<%= config.dist %>/<%= config.crxname %>'
    privateKey: process.env.CRX_PRIVATE_KEY || '~/.ssh/github-notifications-chrome.pem'
    exclude: ['.DS_Store']
