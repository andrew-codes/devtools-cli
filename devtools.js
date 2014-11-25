#!/usr/bin/env node
'use strict';

var pkg = require('./package.json');
var _ = require('underscore');
var complete = require('complete');
var requireDir = require('require-dir');
var program = require('commander');
var commands = requireDir('./commands');
var commandCompletion = {};
program
    .version(pkg.version);
_.each(Object.keys(commands), function (key) {
    var command = commands[key];
    command.setup(program);
    commandCompletion[key] = command.getCompletion();
});

complete({
    program: pkg.name,
    commands: commandCompletion,
    options: {
        '--help': {},
        '-h': {},
        '--version': {},
        '-v': {}
    }
});

program.parse(process.argv);
