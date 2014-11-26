'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Template = require('./../../lib/utils/Template');

var git = {
    install: install
};
module.exports = git;

function install(options) {
    return Template.combineInTemplate('settings/git/.gitconfig.mustache', '', options)
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
