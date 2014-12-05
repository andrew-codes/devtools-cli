'use strict';

var complete = require('complete');
var FileUtils = require('./../lib/utils/FileUtils');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var requireDir = require('require-dir');
var installSteps = requireDir('./install');
var _ = require('underscore');
var path = require('path');
var Symlink = require('./../lib/utils/Symlink');
var Config = require('./../lib/utils/Config');

var install = {
    getCompletion: getCompletion,
    setup: setup
};
module.exports = install;

function getCompletion() {
    return function (words, prev, cur) {
        complete.output(cur, ['--user']);
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
function action() {
    var options = getOptions(this.user);
    var installStream = FileUtils.rmdir(dist)
        .then(function () {
            return FileUtils.mkdir(options.targetDir);
        }).
        then(function () {
            return options;
        });
    _.each(Object.keys(installSteps), function (key) {
        installStream = installStream.then(installSteps[key].install);
    });
    installStream.then(finalize)
        .catch(function (e) {
            console.log(e);
        });
}

function finalize(options) {
    return finalizeItems(options.targetDir, options);
}

function getOptions(user) {
    return Config.applyForUser(user);
}

function finalizeItems(directory, options) {
    return fs.readdirAsync(directory)
        .then(function (dirItems) {
            var items = _.map(dirItems, function (item) {
                var itemPath = path.join(directory, item);
                return {
                    path: itemPath,
                    Name: item,
                    isDirectory: fs.lstatSync(itemPath).isDirectory()
                };
            });
            var promises = _.chain(items)
                .filter(function (item) {
                    return !item.isDirectory;
                })
                .map(function (file) {
                    return finalizeItem(file, options);
                }).value();

            promises.concat(_.chain(items)
                .filter(function (item) {
                    return item.isDirectory;
                })
                .map(function (dir) {
                    return finalizeItems(dir.path, options);
                }).value());

            return _.flatten(promises);
        });
}

function finalizeItem(file, options) {
    return Symlink.mklink(options.platform, file.path, options.dest(file.path));
}
