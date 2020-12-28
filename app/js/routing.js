// route manage
var riot = require("riot");
var route = require("riot-route");

const DefaultTag = "toppage";

// 引数のタグをbodyにmountする
route(function(tag) {
	var mountTag = (tag || DefaultTag);
	var mountsList = riot.util.tags.selectTags();
	//console.log(arguments);
	if(mountsList.includes(mountTag)){
		global.activeTag = mountTag;
		riot.mount('body', mountTag, {
			urls: arguments,
			// query: urlhashquery(arguments),
		});
		riot.update();
	} else {
		console.log("ERROR: invalid tag:::", mountTag);
	}
});

// routing開始
if(window.location.href.includes("http")){
	route.base('/wizptadjust/');
} else {
	route.base('#!');
}
route.start(true);

window.addEventListener("DOMContentLoaded", () => {
	riot.mount("*");
});
