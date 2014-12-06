'use strict';

var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var _ = require('underscore');
var Shell = require('./../../lib/utils/Shell');
var Log = require('./../../lib/utils/Log');

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

function install(options) {
	return installAtom(options)
		.then(function () {
			return Promise.settle(installPackages())
				.then(function (results) {
					_.chain(results)
						.filter(function (r) {
							return r.isRejected();
						})
						.each(function (r) {
							Log.error(r.reason());
						})
				});
		})
		.then(_.constant(options));
}

function installAtom(options) {
	if (options.isOsx()) {
		return Shell.run('brew cask install atom');
	} else if (options.isWindows()) {
		return Shell.run('choco install Atom');
	} else {
		throw 'Platform not supported for Atom: ' + options.platform;
	}
}

function installPackages() {
	return _.map(packages, function (pkg) {
		return Shell.run('apm install ' + pkg);
	});
}
