'use strict';

var complete = require('complete');
var FileUtils = require('./../lib/utils/FileUtils');
var Promise = require('bluebird');
var merge = require('merge');
var fs = Promise.promisifyAll(require('fs'));
var requireDir = require('require-dir');
var installSteps = requireDir('./install');
var _ = require('underscore');
var path = require('path');
var exec = Promise.promisifyAll(require('child_process'));

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
    var self = this;
    var options = getOptions(self.user);
    var installStream = FileUtils.rmdir(dist)
        .then(function () {
            return FileUtils.mkdir(options.targetDir)
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
    var configurationPath = path.join('./users/', user, '/config.js');
    if (!fs.existsSync(configurationPath)) {
        throw 'No configuration file specified. Did you mean to run `devtools init` first?';
    }
    var config = require('../' + configurationPath);
    var targetDir = path.join('./dist', user);
    return merge(config, {
        platform: process.platform,
        targetDir: targetDir,
        user: user,
        dest: function (filePath) {
            return path.resolve('/Users', user, path.relative(targetDir, filePath));
        }
    });
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
                    finalizeItem(file, options);
                }).value();

            promises.concat(_.chain(items)
                .filter(function (item) {
                    return item.isDirectory;
                })
                .map(function (dir) {
                    return finalizeItems(dir.path, options)
                }).value());

            return _.flatten(promises);
        });
}

function finalizeItem(file, options) {
    var dest = options.dest(file.path);
    return fs.unlinkAsync(dest)
        .error(function (e) {
        })
        .then(function () {
            var command = '';
            var src = path.resolve(file.path);
            switch (options.platform) {
                case 'darwin':
                    command = 'ln -s ' + src + ' ' + dest;
                    break;
                case 'win32':
                    command = 'mklink ' + dest + ' ' + src;
                    break;
                default:
                    throw options.platform + ' is not supported';
            }
            return exec.execAsync(command);
        });

}
