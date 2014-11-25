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
    return FileUtils.mkdir(options.targetDir + '/git')
        .then(function (targetDir) {
            return fs.readFileAsync('./settings/global/git/.gitconfig', 'utf-8')
                .then(function (contents) {
                    return Mustache.render(contents, options);
                })
                .then(function(contents){
                    return fs.writeFileAsync(options.targetDir + '/git/.gitconfig', contents);
                })
                .then(function () {
                    return targetDir;
                });
        })
        .then(function (targetDir) {
            fs.createReadStream('settings/global/git/.gitignore')
                .pipe(fs.createWriteStream(targetDir + '/.gitignore'));
            return targetDir;
        });
}
