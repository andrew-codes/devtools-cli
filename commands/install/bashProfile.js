'use strict';

var Template = require('./../../lib/utils/Template');
var _ = require('underscore');

var bashProfile = {
    install: install
};
module.exports = bashProfile;

function install(options) {
    return createAlias(options)
        .then(createRc)
        .then(createProfile);
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
