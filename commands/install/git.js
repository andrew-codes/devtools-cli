'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Template = require('./../../lib/utils/Template');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');
var _ = require('underscore');

var git = {
	install: install
};
module.exports = git;

function install(options) {
	var returnOptions = _.constant(options);
	return installGit(options)
		.then(returnOptions)
		.then(configureGit)
		.catch(Log.error);
}

function installGit(options) {
	var installation;
	if (options.isOsx()) {
		return Shell.run('brew install git');
	} else if (options.isWindows()) {
		return Shell.run('choco install git');
	} else {
		throw 'Platform not supported for Git: ' + options.platform;
	}
}

function configureGit(options) {
	return Template.combineInTemplate('settings/git/.gitconfig.mustache', '', options)
		.then(function () {
			return Template.copy('settings/git/.gitignore', options.targetDir + '/.gitignore');
		});
}
