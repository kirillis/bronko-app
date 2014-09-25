module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    webfont: {
      icons: {
        src: 'icons/*.svg',
        dest: '../app/assets/fonts',
        options: {
          font: 'bronko-icons',
          relativeFontPath: '/assets',
          syntax: 'bem',
          hashes: false,
          engine: 'node'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-webfont');

  // Default task(s).
  grunt.registerTask('default', ['webfont:icons']);

};