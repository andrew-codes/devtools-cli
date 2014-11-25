'use strict';

var Promise = require('bluebird');
var mkdirp = require('mkdirp-then');
var fs = Promise.promisifyAll(require('fs'));
var _ = require('underscore');

var FileUtils = {
    mkdir: mkdir,
    rmdir: rmdir
};
module.exports = FileUtils;

function mkdir(directory) {
    return mkdirp(directory)
        .then(function () {
            return directory;
        });
}

function rmdir(directory) {
    return fs.readdirAsync(directory)
        .then(function (files) {
            var items = _.chain(files)
                .map(function (file) {
                    return directory + '/' + file;
                });
            var directories = items.filter(function (file) {
                return fs.lstatSync(file).isDirectory();
            });
            var files = items.filter(function (file) {
                return !fs.lstatSync(file).isDirectory();
            });
            var promises = files.map(function (file) {
                return fs.unlinkAsync(file);
            }).value();
            promises.concat(directories.map(function (dir) {
                return rmdir(dir);
            }).value());
            return promises;
        }).
        then(function () {
            return fs.rmdirAsync(directory);
        })
        .then(function () {
            return directory;
        })
        .error(function (e) {
            return directory;
        });
}
