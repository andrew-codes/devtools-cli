'use strict';

var path = require('path');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Mustache = require('mustache');
var _ = require('underscore');
var FileUtils = require('./FileUtils');
var Config = require('./Config');

var Template = {
	combineInTemplate: combineInTemplate,
	copy: copy
};
module.exports = Template;


function combineInTemplate(templatePath, destDirectory) {
	templatePath = path.join(__dirname, '../../', templatePath);
	var config = Config.get();
	var fileName = path.basename(templatePath).replace(path.extname(templatePath), '');
	return fs.readFileAsync(templatePath, 'utf-8')
		.then(function (template) {
			return fs.readFileAsync(path.join(path.dirname(templatePath), fileName + '.' + config.platform), 'utf-8')
				.error(function (e) {
					return '';
				})
				.then(function (platformSpecificContent) {
					var content = Mustache.render(template, _.extend({
						platformSpecific: platformSpecificContent
					}, config));
					return fs.writeFileAsync(path.join(config.targetDir, destDirectory, fileName), content);
				});
		});
}

function copy(src, dest) {
	src = path.join(__dirname, '../../', src);
	var destPath = path.dirname(dest);
	return FileUtils.mkdir(destPath)
		.then(function () {
			return fs.readFileAsync(src, 'utf-8')
				.then(function (data) {
					return fs.writeFileAsync(dest, data);
				});
		});
}
