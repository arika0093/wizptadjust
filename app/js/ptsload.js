const Pts = require("../data/pts.js");

module.exports = {
	load: () => {
		var s = localStorage;
		var i = JSON.parse(s.getItem("pts"));
		if(!i){
			s.setItem("pts", JSON.stringify(Pts));
			return Pts
		} else {
			return i
		}
	},
	load_filtered: function() {
		return this.load().filter(e => !e.is_deleted);
	},
	save: (ls) => {
		var s = localStorage;
		s.setItem("pts", JSON.stringify(ls));
	}
}