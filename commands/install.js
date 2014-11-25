'use strict';

var complete = require('complete');

var install = {
    getCompletion: getCompletion,
    setup: setup
};
module.exports = install;

function getCompletion() {
    return function (words, prev, cur) {
        complete.output(cur, ['windows', 'osx']);
    };
}

function setup(program) {
    program
        .command('install')
        .description('Install to target platform')
        .action(action);
}

function action(platform) {
    console.log(platform);
}
