'use strict';

var fs = require('fs');
var FileUtils = require('./../lib/utils/FileUtils');

var configuration = {
    getCompletion: getCompletion,
    setup: setup
};
module.exports = configuration;

function getCompletion() {
    return function (words, prev, cur) {
        complete.output(cur, ['--user']);
    };
}

var prgm;
function setup(program) {
    prgm = program;
    program
        .command('init')
        .description('Initializes installation configuration')
        .action(action)
        .option('-u, --user [name]', 'Your name');
}

function action() {
    if (!this.user) {
        throw 'Must enter user option';
    }
    FileUtils.mkdir('./users/' + this.user)
        .then(function (dir) {
            fs.createReadStream('./settings/config.js')
                .pipe(fs.createWriteStream(dir + '/config.js'));

        });
}
