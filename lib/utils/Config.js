'use strict';

var path = require('path');
var fs = require('fs');
var _ = require('underscore');

var machineConfig = {
	platform: process.platform,
	isWindows: isWindows,
	isOsx: isOsx,
	userDirectory: process.env.HOME,
	targetDir: path.join('./dist', process.env.USERNAME),
	user: process.env.USERNAME
};

var configurationPath = path.join('./users/', machineConfig.user, '/config.js');
if (!fs.existsSync(configurationPath)) {
	throw 'No configuration file specified. Did you mean to run `devtools init` first?';
}
var userConfig = require('../../' + configurationPath);

var Config = {
	get: get
};
module.exports = Config;

function get() {
	return _.extend({}, machineConfig, userConfig, {
		distToUserDir: distToUserDir,
		unsupportedPlatformError: 'Platform (' + machineConfig.platform + ') not supported'
	});
}

function isWindows() {
	return process.platform === 'win32';
}

function isOsx() {
	return process.platform === 'darwin';
}

function distToUserDir(filePath) {
	return path.resolve(this.userDirectory, this.user, path.relative(this.targetDir, filePath));
}
