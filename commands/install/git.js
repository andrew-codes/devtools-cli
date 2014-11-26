'use strict';

var FileUtils = require('./../../lib/utils/FileUtils');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Mustache = require('mustache');

var git = {
    install: install
};
module.exports = git;

function install(options) {
    return fs.readFileAsync('./settings/git/gitconfig.mustache', 'utf-8')
        .then(function (contents) {
            return Mustache.render(contents, options);
        })
        .then(function (contents) {
            return fs.writeFileAsync(options.targetDir + '/.gitconfig', contents)
        })
        .then(function () {
            return fs.readFileAsync('settings/git/.gitignore', 'utf-8')
                .then(function (data) {
                    return fs.writeFileAsync(options.targetDir + '/.gitignore', data);
                })
                .then(function () {
                    return options;
                });
        });
}
