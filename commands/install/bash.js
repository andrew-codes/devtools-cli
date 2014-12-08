'use strict';

var Template = require('./../../lib/utils/Template');
var Log = require('./../../lib/utils/Log');
var Symlink = require('./../../lib/utils/Symlink');
var path = require('path');
var config = require('./../../lib/utils/Config').get();

var bashProfile = {
	install: install
};
module.exports = bashProfile;

var component = 'bash';

function install() {
	return createAlias()
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

function createAlias() {
	return Template.combineInTemplate('./settings/bash/.alias.mustache', '');
}

function createRc() {
	return Template.combineInTemplate('./settings/bash/.bashrc.mustache', '');
}

function createProfile() {
	return Template.combineInTemplate('./settings/bash/.bash_profile.mustache', '');
}

function finalizeBash() {
	return Symlink.mklink(path.join(config.targetDir, '.alias'), path.join(config.userDirectory, '.alias'))
		.then(function () {
			return Symlink.mklink(path.join(config.targetDir, '.bash_profile'), path.join(config.userDirectory, '.bash_profile'));
		})
		.then(function () {
			return Symlink.mklink(path.join(config.targetDir, '.bashrc'), path.join(config.userDirectory, '.bashrc'));
		});
}
