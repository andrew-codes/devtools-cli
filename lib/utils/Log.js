var _ = require('underscore');

var Log = {
	error: error,
	log: log
};
module.exports = Log;

function error(message, component, error) {
		logMessage('%s : %s : %s', component, message, error);
}

function log(message, component) {
	console.log((component === undefined ? '' : component + ' : ') + message);
}

function logMessage() {
	var args = _.keys(logMessage.arguments)
		.map(function (key) {
			return logMessage.arguments[key];
		});
	console.log.apply(this, args);
}
