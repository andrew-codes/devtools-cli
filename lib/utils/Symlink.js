'use strict';

var Promise = require('bluebird');
var path = require('path');
var exec = Promise.promisifyAll(require('child_process'));
var fs = Promise.promisifyAll(require('fs'));

var Symlink = {
	mklink: mklink
};
module.exports = Symlink;

function mklink(platform, src, dest) {
	return fs.unlinkAsync(dest)
		.error(function (e) {})
		.then(function () {
			var command = '';
			var srcPath = path.resolve(src);
			switch (platform) {
			case 'darwin':
				command = 'ln -s ' + srcPath + ' ' + dest;
				break;
			case 'win32':
				command = 'mklink ' + dest + ' ' + srcPath;
				break;
			default:
				throw platform + ' is not supported';
			}
			return exec.execAsync(command);
		});
}
