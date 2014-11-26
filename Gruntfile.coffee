module.exports = (grunt) ->
    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')

        less:
            style:
                files:
                    'app/assets/css/main.css': 'app/assets/less/main.less'

        coffee:
            default:
                expand: true
                cwd: "app/assets/coffee/"
                src: ["**/*.coffee"]
                dest: "app/assets/js/"
                ext: ".js"

        watch:
            less:
                files: ['app/assets/less/*.less']
                tasks: 'less'
            coffee:
                files: ['app/assets/coffee/**/*.coffee']
                tasks: 'coffee'

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'default', [
        'build'
    ]

    grunt.registerTask 'build', [
        'less'
        'coffee'
    ]

    grunt.registerTask 'dev', [
        'build'
        'watch'
    ]
