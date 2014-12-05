'use strict';

var path = require('path');
var fs = require('fs');
var _ = require('underscore');

var machineConfig = {
  platform: process.platform,
  isWindows: isWindows,
  isOsx: isOsx
};

var Config = {
  applyForUser: applyForUser
};
module.exports = Config;

function applyForUser(user){
  var configurationPath = path.join('./users/', user, '/config.js');
  if (!fs.existsSync(configurationPath)) {
    throw 'No configuration file specified. Did you mean to run `devtools init` first?';
  }
  var userConfig = require('../../' + configurationPath);
  var targetDir = path.join('./dist', user);
  return _.extend({}, machineConfig, userConfig, {
    targetDir: targetDir,
    user: user,
    dest: function (filePath) {
      return path.resolve('/Users', user, path.relative(targetDir, filePath));
    }
  });
}

function isWindows(){
  return process.platform === 'win32';
}

function isOsx(){
  return process.platform === 'darwin';
}
