'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Template = require('./../../lib/utils/Template');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');
var _ = require('underscore');
var Symlink = require('./../../lib/utils/Symlink');
var path = require('path');
var Config = require('./../../lib/utils/Config');

var git = {
	install: install
};
module.exports = git;

var component = 'git';
var config;
function install() {
	config = Config.get();
	return installGit()
		.catch(function (e) {
			Log.error('Error installing', component, e);
		})
		.then(configureGit)
		.catch(function (e) {
			Log.error("Error configuring", component, e);
			throw e;
		})
		.then(finalizeGit)
		.catch(function (e) {
			Log.error("Error finalizing", component, e);
		});
}

function installGit() {
	if (config.isOsx()) {
		return Shell.run('brew install git');
	} else if (config.isWindows()) {
		return Shell.run('choco install git');
	} else {
		throw config.unsupportedPlatformError;
	}
}

function configureGit() {
	return Template.combineInTemplate('settings/git/.gitconfig.mustache', '')
		.then(function () {
			return Template.copy('settings/git/.gitignore', path.join(config.targetDir, '.gitignore'));
		});
}

function finalizeGit() {
	return Symlink.mklink(path.join(config.targetDir, '.gitconfig'), path.join(config.userDirectory, '.gitconfig'))
		.then(function () {
			return Symlink.mklink(path.join(config.targetDir, '.gitignore'), path.join(config.userDirectory, '.gitignore'));
		});
}
