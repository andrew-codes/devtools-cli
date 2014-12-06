'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var _ = require('underscore');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');
var Template = require('./../../lib/utils/Template');
var Symlink = require('./../../lib/utils/Symlink');
var path = require('path');

var packages = [
	'solarized-dark-ui',
	'merge-conflicts',
	'minimap',
	'atom-beautify',
	'refactor',
	'js-refactor',
	'coffee-refactor',
	'grammar-selector',
	'react',
	'git-history',
	'todo-show',
	'es-navigation',
	'coffee-navigation',
	'atomic-rest',
	'tabs-to-spaces',
	'snippets',
	'linter',
	'linter-jshint',
	'linter-jsxhint',
	'linter-coffeelint',
	'linter-less',
	'linter-csslint',
	'linter-spellcheck',
	'linter-htmlhint',
	'lang-csharp',
	'autocomplete-plus-asyc',
	'omnisharp-atom',
	'package-generator',
	'branch-status'
];

var atom = {
	install: install
};
module.exports = atom;

var component = 'Atom';

function install(options) {
	return installAtom(options)
		.catch(function (e) {
			Log.error('Error installing', component, e);
		})
		.then(_.constant(options))
		.then(installPackages)
		.catch(function (e) {
			Log.error('Error installing packages', component, e);
			throw e;
		})
		.then(configureAtom)
		.catch(function (e) {
			Log.error('Error configuring', component, e);
			throw e;
		})
		.then(finalizeAtom)
		.catch(function (e) {
			Log.error('Error finalizing', component, e);
		});
}

function installAtom(options) {
	var installation;
	if (options.isOsx()) {
		return Shell.run('brew cask install atom');
	} else if (options.isWindows()) {
		return Shell.run('choco install Atom');
	}
	throw 'Platform not supported for Atom: ' + options.platform;
}

function installPackages(options) {
	var packageInstalls = _.map(packages, function (pkg) {
		return Shell.run('apm install ' + pkg);
	});
	return Promise.settle(packageInstalls)
		.then(function (results) {
			_.chain(results)
				.filter(function (r) {
					return r.isRejected();
				})
				.each(function (r) {
					Log.error('Error installing package: ' + r.reason().command, component);
				})
		})
		.then(_.constant(options));
}

function configureAtom(options) {
	return Template.copy('settings/atom/config.cson', options.targetDir + '/.atom/config.cson')
		.then(_.constant(options));
}

function finalizeAtom(options) {
	return Symlink.mklink(options.platform, options.targetDir + '/.atom/config.cson', path.join(options.userDirectory, '.atom/config.cson'));
}
