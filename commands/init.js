'use strict';

var fs = require('fs');
var FileUtils = require('./../lib/utils/FileUtils');

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
		FileUtils.mkdir('./users/' + process.env.user)
				.then(function (dir) {
						fs.createReadStream('./settings/config.js')
								.pipe(fs.createWriteStream(dir + '/config.js'));

				});
}
