#!/usr/bin/env node
'use strict';

var Promise = require('bluebird');
var exec = Promise.promisifyAll(require('child_process'));

exec.execAsync('node devtools.js --install >> ~/.bash_profile')
    .catch(function (e) {
        console.log(e);
    });
