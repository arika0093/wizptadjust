// Main
// ------------------------------
// tag load
var riot = require("riot");
require("./requireTags.js");

require("./js/globalvar.js");
require("./js/routing.js");

// global observable
global.Observer = riot.observable();

