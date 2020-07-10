define
	header

	main
		p.information 登録済ポイント一覧
		table
			tr
				th 周回場所
				th 順位
				th ポイント
			tr(each="{p in pts}")
				td {p.name}
				td {p.rank}
				td {p.pt}
		br
		p.t 
			| このデータは20/06現在のデータです。<br/>
			| 修正が必要な場合は
			a(href="https://github.com/arika0093" target="_blank") GitHub
			| にpull requestを送るか、localStorage(key: pts)を修正してください。

	style.
		main {
			max-width: 800px;
			margin: 0 auto;
			text-align: center;
		}

		main table {
			width: 100%;
			text-align: center;
		}

		main table tr th {
			border-bottom: 1px solid #000;
		}



	script.
		var ptsload = require("../js/ptsload.js");
		this.pts = ptsload.load();

