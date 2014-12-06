'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Template = require('./../../lib/utils/Template');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');

var git = {
	install: install
};
module.exports = git;

function install(options) {
	return installGit(options).
	then(function () {
			return Template.combineInTemplate('settings/git/.gitconfig.mustache', '', options)
				.then(function () {
					return fs.readFileAsync('settings/git/.gitignore', 'utf-8')
						.then(function (data) {
							return fs.writeFileAsync(options.targetDir + '/.gitignore', data);
						})
				});
		})
		.catch(Log.error)
		.then(function () {
			return options;
		});
}

function installGit(options) {
	if (options.isOsx()) {
		return Shell.run('brew install git');
	} else if (options.isWindows()) {
		return Shell.run('choco install git');
	}
	throw 'Platform not supported for Git: ' + options.platform;
}
