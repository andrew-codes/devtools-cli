'use strict';

var fs = require('fs');
var FileUtils = require('./../lib/utils/FileUtils');
var path = require('path');

var configuration = {
		setup: setup
};
module.exports = configuration;

var prgm;
function setup(program) {
		prgm = program;
		program
				.command('init')
				.description('Initializes installation configuration')
				.action(action);
}

function action() {
	var baseDir = __dirname;
		FileUtils.mkdir(path.join(baseDir, '../users', process.env.USERNAME))
				.then(function (dir) {
						fs.createReadStream(path.join(baseDir, '../settings/config.js'))
								.pipe(fs.createWriteStream(path.join(dir, 'config.js')))});
}
