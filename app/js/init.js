// Main
// ------------------------------
// tag load
var riot = require("riot");
require("./requireTags.js");

require("./globalvar.js");
require("./routing.js");

// global observable
global.Observer = riot.observable();

