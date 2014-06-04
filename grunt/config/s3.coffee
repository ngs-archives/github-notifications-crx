module.exports = (grunt, config) ->
  options:
    key:    process.env.AWS_ACCESS_KEY_ID
    secret: process.env.AWS_SECRET_ACCESS_KEY
    region: process.env.S3_REGION
    bucket: config.s3bucket
    access: 'private'
  dist:
    upload: [
      {
        src: '<%= config.dist %>/<%= config.crxname %>'
        dest: '<%= config.s3path %><%= config.crxname %>'
      }
      {
        src: '<%= config.dist %>/<%= config.zipname %>'
        dest: '<%= config.s3path %><%= config.zipname %>'
      }
    ]
