// route manage
var riot = require("riot");
var route = require("riot-route");

const DefaultTag = "toppage";

// 引数のタグをbodyにmountする
route(function(tag) {
	
	var mountTag = (tag || DefaultTag);
	if(mountTag.includes("htl") && arguments.length >= 2){
		mountTag = [...arguments].join("_");
	}
	
	var mountsList = riot.util.tags.selectTags();
	//console.log(arguments);
	if(mountsList.includes(mountTag)){
		global.activeTag = mountTag;
		riot.mount('body', mountTag, {
			urls: arguments,
			query: urlhashquery(arguments),
		});
		riot.update();
	} else {
		console.log("ERROR: invalid tag:::", mountTag);
	}
});

// routing開始
route.base('#!');
route.start(true);

window.addEventListener("DOMContentLoaded", () => {
	riot.mount("*");
});
