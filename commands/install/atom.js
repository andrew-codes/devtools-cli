'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var _ = require('underscore');
var shell = require('./../../lib/utils/Shell');

var packages = [
  'solarized-dark-ui',
  'merge-conflicts',
  'minimap',
  'atom-beautify',
  'refactor',
  'js-refactor',
  'coffee-refactor',
  'grammar-selector',
  'react',
  'git-history',
  'todo-show',
  'es-navigation',
  'coffee-navigation',
  'atomic-rest',
  'tabs-to-spaces',
  'snippets',
  'linter',
  'linter-jshint',
  'linter-jsxhint',
  'linter-coffeelint',
  'linter-less',
  'linter-csslint',
  'linter-spellcheck',
  'linter-htmlhint',
  'lang-csharp',
  'autocomplete-plus-asyc',
  'omnisharp-atom',
  'package-generator',
  'branch-status'
];

var atom = {
  install: install
};
module.exports = atom;

var envOptions;
function install(options) {
  envOptions = options;
  if (!isInstalled()) {
    return options;
  }
  return Promise.all(installPackages())
  .catch(function(e){
    console.log(e);
  })
  .then(_.constant(options));
}

function isInstalled() {
  if (envOptions.isOsx()){
    return fs.existsSync('/Applications/Atom.app');
  }
  if (envOptions.isWindows()){
    var isInstalledOnWindows = false;
    fs.readdirSync('C:\\ProgramData\\chocolatey\\lib', function(items){
      isInstalledOnWindows = isInstalledOnWindows || items.toLowerCase().indexOf('atom') === 0;
    });
    return isInstalledOnWindows;
  }
}

function installPackages() {
  return _.map(packages, function(pkg){
    return shell.run('apm install ' + pkg);
  });
}
