'use strict';

var complete = require('complete');
var git = require('./install/git');
var FileUtils = require('./../lib/utils/FileUtils');
var merge = require('merge');
var fs = require('fs');

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
        .option('-c, --config', 'User configuration');
}

var dist = './dist';
function action(configuration, platform) {
    if (!fs.existsSync(configuration)){
        console.log('No configuration file specified. Did you mean to run `devtools init` first?');
        return;
    }
    var config = require('./../' + configuration);
    FileUtils.rmdir(dist)
        .then(function (dir) {
            return merge(config, {
                platform: platform,
                targetDir: dir
            });
        })
        .then(git.install);
}
