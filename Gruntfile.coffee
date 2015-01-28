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
#run unit tests with karma (server needs to be already running)
            karma: {
                files: ['app/assets/coffee/*.coffee', 'app/assets/test/**/*.coffee'],
#NOTE the :run flag
                tasks: ['karma:unit:run']
            }

        karma:
            unit:
                options:
                    files: [
                       'app/assets/vendor/angularjs/angular.js',
                       'app/assets/vendor/angular-route/angular-route.js',
                       'app/assets/vendor/angular-resource/angular-resource.js',
                       'app/assets/vendor/angular-animate/angular-animate.js',
                       'app/assets/vendor/angular-mocks/angular-mocks.js',
                       'app/assets/coffee/*.coffee',
                       'app/assets/test/unit/*.coffee'
                    ],
                background: true,
                singleRun: false
#                basePath: '../'
                preprocessors:
                    '**/*.coffee': ['coffee']

                frameworks: ['jasmine']

                browsers: ['Chrome'],

                plugins: [
                   'karma-junit-reporter',
                   'karma-chrome-launcher',
                   'karma-firefox-launcher',
                   'karma-jasmine',
                   'karma-coffee-preprocessor'
                ]

                junitReporter:
                    outputFile: 'tests/out/unit.xml',
                    suite: 'unit'
        notify_hooks:
            options:
                title: "Moje rodina"

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-karma'
    grunt.loadNpmTasks 'grunt-notify'

    grunt.task.run('notify_hooks')

    grunt.registerTask 'default', [
        'build'
    ]

    grunt.registerTask 'build', [
        'less'
        'coffee'
    ]

    grunt.registerTask 'dev', [
        'build'
        'karma'
        'watch'
    ]
