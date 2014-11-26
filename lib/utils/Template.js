'use strict';

var path = require('path');
var Promise = require('bluebird');
var fs = Promise.promisifyAll(require('fs'));
var Mustache = require('mustache');
var _ = require('underscore');
var merge = require('merge');

var Template = {
    combineInTemplate: combineInTemplate
};
module.exports = Template;


function combineInTemplate(templatePath, destDirectory, options) {
    var returnOptions = _.constant(options);
    var dataFileName = path.basename(templatePath).replace(path.extname(templatePath), '');
    return fs.readFileAsync(templatePath, 'utf-8')
        .then(function (template) {
            return fs.readFileAsync(dataFileName + '.' + options.platform)
                .error(function (e) {
                    return '';
                })
                .then(function (platformSpecificContent) {
                    var content = Mustache.render(template, merge({platformSpecific: platformSpecificContent}, options));
                    return fs.writeFileAsync(path.join(options.targetDir, destDirectory, dataFileName), content);
                })
                .then(returnOptions);
        });
}
