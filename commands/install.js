'use strict';

var complete = require('complete');
var FileUtils = require('./../lib/utils/FileUtils');
var merge = require('merge');
var fs = require('fs');
var requireDir = require('require-dir');
var installSteps = requireDir('./install');
var _ = require('underscore');

var install = {
    getCompletion: getCompletion,
    setup: setup
};
module.exports = install;

function getCompletion() {
    return function (words, prev, cur) {
        complete.output(cur, ['windows', 'osx']);
    };
}

function setup(program) {
    program
        .command('install')
        .description('Install to target platform')
        .action(action)
        .option('-u, --user [user]', 'User name');
}

var dist = './dist';
function action(platform) {
    var self = this;
    var configuration = './users/' + self.user + '/config.js';
    if (!fs.existsSync(configuration)) {
        console.log('No configuration file specified. Did you mean to run `devtools init` first?');
        return;
    }
    var config = require('../' + configuration);
    var installStream = FileUtils.rmdir(dist)
        .then(function (dir) {
            return merge(config, {
                platform: platform,
                targetDir: dir + '/' + self.user
            });
        })
        .then(function (options) {
            return FileUtils.mkdir(options.targetDir).
                then(function () {
                    return options;
                });
        });
    _.each(Object.keys(installSteps), function (key) {
        installStream.then(installSteps[key].install);
    });
}
