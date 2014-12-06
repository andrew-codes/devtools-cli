'use strict';
var exec = require('child_process').exec;
var Promise = require('bluebird');

module.exports = {
	run: run
}

function run(command, args) {
	return new Promise(function (resolve, reject) {
		var child = exec(command);
		child.on('exit', function (code, args) {
			if (code !== 0) {
				reject();
			} else {
				resolve();
			}
		});
	});
}
