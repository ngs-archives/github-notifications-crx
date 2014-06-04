module.exports = (grunt, config) ->
  options:
    sassDir: '<%= config.src %>/styles',
    cssDir: '<%= config.app %>/styles',
    generatedImagesDir: '<%= config.app %>/images/generated',
    imagesDir: '<%= config.src %>/images',
    javascriptsDir: '<%= config.app %>/scripts',
    fontsDir: '<%= config.app %>/styles/fonts',
    importPath: '<%= config.app %>/bower_components',
    httpImagesPath: '/images',
    httpGeneratedImagesPath: '/images/generated',
    relativeAssets: false
  dev: {}
