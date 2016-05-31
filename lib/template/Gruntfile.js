var clientApp = './src/app/';

var files = [
  clientApp + '**/*.module.js',
  '<%= ngtemplates.app.dest %>',
  clientApp + '**/*.js'
];


module.exports = function(grunt) {
  var vendorDependencies = grunt.file.readJSON('surak.json').dependencies;

  console.log("\nSurak Dependencies: \n    " + vendorDependencies.join(',\n    ') + "\n" );

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),


    concat_css: {
      options: {
        // Task-specific options go here.
      },
      all: {
        src: [
          "vendor/angular-material/angular-material.min.css",
          "src/css/*.css"
      ],
        dest: "dist/styles.css"
      },
    },


    concat: {
      options: {
        separator: ';'
      },
      vendor: {
        src: vendorDependencies,
        dest: 'build/vendor.min.js'
      },
      app_src: {
        src: files,
        dest: 'build/app_src.js'
      },
      bundle: {
        src: [
          'build/vendor.min.js',
          'build/app_src.min.js',
        ],
        dest: 'dist/app.min.js'
      },

      bundle_dev: {
        src: [
          'build/vendor.min.js',
          'build/app_src.js',
        ],
        dest: 'dist/app.min.js'
      }
    },


    uglify: {
        options: {
          mangle: true,
          beautify: true
        },
        my_target: {
          files: {
            'build/app_src.min.js': ['build/app_src.js']
          }
        }
      },


    ngtemplates: {
      app: {
        cwd:      'src/app',
        src:      ['templates/**.tpl.html', 'templates/**/**.tpl.html'],
        dest:     'build/app.templates.js',
        options:  {
          htmlmin: {
            collapseBooleanAttributes:      true,
            collapseWhitespace:             true,
            removeAttributeQuotes:          true,
            removeComments:                 true, // Only if you don't use comment directives!
            removeEmptyAttributes:          true,
            removeRedundantAttributes:      true,
            removeScriptTypeAttributes:     true,
            removeStyleLinkTypeAttributes:  true
          }
        }
      }
    }


  });


  grunt.loadNpmTasks('grunt-angular-templates');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-concat-css');


  //grunt.registerTask('default', ['concat_css', 'concat:vendor', 'ngtemplates', 'concat:app_src', 'uglify', 'concat:bundle' ]); // Production
  grunt.registerTask('default', ['concat_css', 'concat:vendor', 'ngtemplates', 'concat:app_src', 'concat:bundle_dev' ]); // Development

};
