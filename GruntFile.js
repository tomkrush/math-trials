module.exports = function(grunt) {
  "use strict";
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks);
  
  grunt.initConfig({
    sass: {                              // Task
      build: {                            // Target
        files: {                         // Dictionary of files
          'css/style.css': 'sass/style.scss',       // 'destination': 'source'
        }
      }
    },
    watch: {
      css: {
        files: ['sass/**/*.scss'],
        tasks: ['buildcss']
      } 
    }
  });

  grunt.loadNpmTasks('grunt-contrib-sass');
  
  grunt.registerTask('buildcss',  ['sass']);
  
};