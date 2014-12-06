'use strict';

var Template = require('./../../lib/utils/Template');
var Log = require('./../../lib/utils/Log');
var Symlink = require('./../../lib/utils/Symlink');
var path = require('path');

var bashProfile = {
	install: install
};
module.exports = bashProfile;

	var component = 'bash';
function install(options) {
	return createAlias(options)
		.catch(function (e) {
			Log.error('Error creating alias', component, e);
			throw e;
		})
		.then(createRc)
		.catch(function (e) {
			Log.error('Error creating rc', component, e);
			throw e;
		})
		.then(createProfile)
		.catch(function (e) {
			Log.error('Error creating profile', component, e);
			throw e;
		})
		.then(finalizeBash)
		.catch(function (e) {
			Log.error('Error finalizing', component, e);
		});
}

function createAlias(options) {
	return Template.combineInTemplate('./settings/bash/.alias.mustache', '', options);
}

function createRc(options) {
	return Template.combineInTemplate('./settings/bash/.bashrc.mustache', '', options);
}

function createProfile(options) {
	return Template.combineInTemplate('./settings/bash/.bash_profile.mustache', '', options);
}

function finalizeBash(options) {
	return Symlink.mklink(options.platform, options.targetDir + '/.alias', path.join(options.userDirectory, '.alias'))
		.then(function () {
			return Symlink.mklink(options.platform, options.targetDir + '/.bash_profile', path.join(options.userDirectory, '.bash_profile'));
		})
		.then(function () {
			return Symlink.mklink(options.platform, options.targetDir + '/.bashrc', path.join(options.userDirectory, '.bashrc'));
		});
}
