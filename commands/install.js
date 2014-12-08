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
var config = require('./../lib/utils/Config').get();
var Log = require('./../lib/utils/Log');
var Shell = require('./../lib/utils/Shell');

var install = {
	setup: setup
};
module.exports = install;

function setup(program) {
	program
		.command('install')
		.description('Install to target platform')
		.action(action);
}

function action() {
	FileUtils.rmdir(config.targetDir)
		.then(function () {
			return FileUtils.mkdir(config.targetDir);
		})
		.then(function () {
			return initializeEnvironment();
		})
		.then(function () {
			var installations = _.chain(Object.keys(installSteps))
				.filter(function (key) {
					return _.contains(config.includeApplications, key);
				})
				.map(function (key) {
					Log.log('Starting installation', key);
					return installSteps[key].install()
						.tap(function () {
							Log.log('Finished installation', key);
						});
				}).value();
			Promise.all(installations);
		});
}

function initializeEnvironment() {
	if (config.isOsx()) {
		return Shell.run('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
			.catch(function (e) {
				Log.error('Brew, e');
			})
			.then(function () {
				return Shell.run('brew install cask')
					.catch(function (e) {
						Log.error('Brew Cask', e);
					});
			});
	} else if (config.isWindows()) {
		return Shell.run('@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString(\'https://chocolatey.org/install.ps1\'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\\')
			.catch(function (e) {
				Log.error('Chocolately', e);
			});
	}
	throw config.unsupportedPlatformError;
}
