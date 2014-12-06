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
var Config = require('./../lib/utils/Config');
var Log = require('./../lib/utils/Log');
var Shell = require('./../lib/utils/Shell');

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
	var options = getOptions(this.user);
	FileUtils.rmdir(dist)
		.then(function () {
			return FileUtils.mkdir(options.targetDir);
		})
		.then(function () {
			return initializeEnvironment(options);
		})
		.then(function () {
			var installations = _.chain(Object.keys(installSteps))
				.filter(function (key) {
					return _.contains(options.includeApplications, key);
				})
				.map(function (key) {
					Log.log('Starting installation', key);
					return installSteps[key].install(options)
						.tap(function () {
							Log.log('Finished installation', key);
						});
				}).value();
			Promise.all(installations);
		});
}

function finalize(options) {
	console.log('Finalizing...');
	return finalizeItems(options.targetDir, options);
}

function getOptions(user) {
	return Config.applyForUser(user);
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
					return finalizeItem(file, options);
				}).value();

			promises.concat(_.chain(items)
				.filter(function (item) {
					return item.isDirectory;
				})
				.map(function (dir) {
					return finalizeItems(dir.path, options);
				}).value());

			return _.flatten(promises);
		});
}

function finalizeItem(file, options) {
	return Symlink.mklink(options.platform, file.path, options.dest(file.path));
}


function initializeEnvironment(options) {
	if (options.isOsx()) {
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
	} else if (options.isWindows()) {
		return Shell.run('@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString(\'https://chocolatey.org/install.ps1\'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin\\')
			.catch(function (e) {
				Log.error('Chocolately', e);
			});
	}
}
