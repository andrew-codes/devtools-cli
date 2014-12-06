#!/usr/bin/env node

'use strict';

var Shell = require('./lib/utils/Shell');
var Log = require('./lib/utils/Log');

Shell.run('node devtools.js --install >> /Users/andrewsmith/.bash_profile')
.catch(Log.error);
