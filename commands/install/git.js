'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Template = require('./../../lib/utils/Template');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');
var _ = require('underscore');
var Symlink = require('./../../lib/utils/Symlink');
var path = require('path');

var git = {
	install: install
};
module.exports = git;

	var component = 'git';
function install(options) {
	return installGit(options)
		.catch(function (e) {
			Log.error('Error installing', component, e);
		})
		.then(_.constant(options))
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

function installGit(options) {
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
			return Template.copy('settings/git/.gitignore', path.join(options.targetDir, '.gitignore'));
		})
		.then(_.constant(options));
}

function finalizeGit(options) {
	return Symlink.mklink(options.platform, path.join(options.targetDir, '.gitconfig'), path.join(options.userDirectory, '.gitconfig'))
		.then(function () {
			return Symlink.mklink(options.platform, path.join(options.targetDir, '.gitignore'), path.join(options.userDirectory, '.gitignore'));
		});
}
