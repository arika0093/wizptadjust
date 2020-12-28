toppage
	header
	main
		.information
			//- TODO: アプリの概要説明

		.tool
			.pointInputForm
				label.iform(for="evh1pt")
					span.desc 覇級1位の獲得ポイント
					input#evh1pt(type="number" placeholder="[必須] 覇級を周回しない場合は0を入力")
				label.iform(for="nowtpt")
					span.desc 現在の総合ポイント
					input#nowtpt(type="number" placeholder="[必須]")
				label.iform(for="tgttpt")
					span.desc 目標の総合ポイント
					input#tgttpt(type="number" placeholder="[必須]")
				label.iform(for="nowdpt")
					span.desc 現在のデイリーポイント
					input#nowdpt(type="number" placeholder="[任意] 指定すると調整が楽になります。")

			.pointCalcOpts
				label.iform(for="ptmargin")
					span.desc ポイント調整開始マージン
					input#ptmargin(type="number" placeholder="指定したポイント差以内で調整を開始します。")
					span.default 初期値: {DEFAULT_START_MARGIN}
				label.iform(for="noDowngrade")
					input#noDowngrade(type="checkbox" checked="true") 
					span.chdesc 降段しないように調整する

			.pointCalcUsedList

			.calcStartButton
				input(onclick="{startCalculation}" type="button" value="Calculation Start") 


		.calculationConsole(if="{consoleList.length > 0 & todoQsts.length <= 0}")
			.console(each="{c in consoleList}") {c}

		.calculationResult(if="{todoQsts.length > 0}")
			table
				tr.header
					th.type 種別
					th.name クエスト名
					th.rank 順位
					th.point 取得Pt
					th.count 周回数
					th.added_tp 総合Pt
					th.added_dp(if="{isUseDailyPtList}") デイリーPt
				tr.route.init
					td.beforerun(colspan=5) (周回前)
					td.added_tp {runInitTp}
					td.added_dp(if="{isUseDailyPtList}") {runInitDp}
				tr.route(each="{r in todoQsts}" class="{un: r.rankNum > 1}")
					td.type {r.type}
					td.name {r.name}
					td.rank {r.rank}
					td.point {r.point}
					td.count {r.count} 回
					td.added_tp {r.added_tp}
					td.added_dp(if="{isUseDailyPtList}") {r.added_dp}
				tr.route.end
					td.afterrun(colspan=5) (周回終了)
					td.added_tp {runEndTp}
					td.added_dp(if="{isUseDailyPtList}") {runEndDp}
		
	//- footer


	// -------------------------
	style(type="scss").
		main {
			max-width: 850px;
			margin: 0 auto;
		}

		.tool {
			display: flex;
			flex-direction: column;
			margin: 1ex 2ex;
			padding: 1ex 1ex;
			border: 1px solid #08F;
			border-radius: 8px;
			background-color: #E0EEFF;
		}

		label.iform {
			display: flex;
			flex-direction: row;
			justify-content: stretch;
			align-items: center;
			margin: .3ex .5ex;
			font-size: 0.9rem;
		}
		label.iform > input[type="text"],
		label.iform > input[type="number"] {
			flex-shrink: 1;
			font-family: "Meiryo";
			font-size: .8rem;
			width: 300px;
		}

		span.desc {
			width: 200px;
			text-align: right;
		}
		span.desc:after {
			display: inline-block;
			content: ":";
			margin-right: 1em;
		}
		span.default {
			margin-left: 1ex;
			font-size: .8rem;
			color: #444;
		}

		@media screen and (max-width: 600px) { 
			.tool {
				align-items: center;
			}
			label.iform {
				flex-direction: column;
			}
			span.desc {
				text-align: center;
			}
		}

		.pointCalcOpts {
			border-top: 1px dashed #08F;
			margin-top: .5ex;
			padding-top: .5ex;
		}

		.calcStartButton {
			margin-top: .5ex;
		}
		.calcStartButton > input {
			padding: 1.5ex 5ex;
			font-family: "Meiryo";
		}

		/* ----- */

		.calculationConsole {
			margin: 1ex 3ex;
			padding: 1ex 1ex;
			background-color: #222;
			color: #0C0;
			font-family: "Source Code Pro", "Courier New", monospace;
			font-size: .8rem;
			height: 350px;
			overflow-y: scroll;
		}

		/* ----- */
		.calculationResult {
			overflow: auto;
			width: calc(100% - 4ex);
			border: 1px solid #048;
			margin: 1.5ex 2ex 3ex;
		}

		.calculationResult > table {
			width: 100%;
			min-width: 600px;
			text-align: center;
			/* margin: 1.5ex 2ex 3ex;
			padding: .5ex 1ex;
			border: 1px solid #48C; */
			border-collapse: collapse;
		}

		th, td {
			border: 1px solid #DDD;
		}
		th {
			border-top: 0px solid #048;
			border-bottom: 1px solid #048;
			line-height: 2.5;
		}
		tr {
			line-height: 2;
		}
		tr.route.init, tr.route.end {
			background: #E0FFE0;
		}
		tr.route.un {
			background-color: #EEF;
		}
		tr > th:first-child ,
		tr > td:first-child {
			border-left: 0px solid #048;
		}
		tr > th:last-child ,
		tr > td:last-child {
			border-right: 0px solid #048;
		}
		tr:last-child > td {
			border-bottom: 0px solid #048;
		}

		

	// ---------------------------
	// Script
	script.
		const $ = require("jquery");
		const Pts = require("../js/ptsload.js");

		this.DEFAULT_START_MARGIN = 100000;
		this.consoleList = [];
		this.todoQsts = [];
		this.isUseDailyPtList = false;
		this.runInitTp = 0;
		this.runInitDp = 0;
		this.runEndTp = 0;
		this.runEndDp = 0;

		this.startCalculation = () => {
			var opts = {}
			opts.evh_pt = $("#evh1pt").val() - 0;
			opts.nowPt = $("#nowtpt").val() - 0;
			opts.nowDailyPt = $("#nowdpt").val() - 0;
			opts.targetPt = $("#tgttpt").val() - 0;
			opts.getPoint = opts.targetPt - opts.nowPt;
			this.isUseDailyPtList = opts.nowDailyPt > 0;

			opts.isNoDowngrade = $("#noDowngrade").prop("checked");
			var mrg_s = $("#ptmargin").val();
			var mrg = mrg_s.length > 0 ? mrg_s - 0 : this.DEFAULT_START_MARGIN;
			opts.startMargin = opts.getPoint > mrg ? mrg : 0;

			opts.quests = $.extend([], Pts.load()).filter(e => {
				return !(e.is_dg && opts.isNoDowngrade)
			});
			if(opts.evh_pt > 0){
				opts.quests.push({
					name: "覇級",
					rank: "1位",
					pt: opts.evh_pt,
					is_ev: true,
					is_added: true,				
				})
			}

			opts.calcText = this.generateCalcText(opts);
			this.outputLog(`--- Running Start ------------`, true);
			this.runAdjustPtWorker(opts);
		}

		this.generateCalcText = (opts) => {
			var quests = opts.quests;
			var genText = (sep_flag, is_coeff) => {
				return quests.map((e, i) => {
					var s = sep_flag ? "+" : "";
					var c = is_coeff ? " " + e.pt : "";
					return ` ${s}${c} x${i+1}`;
				}).join("");
			};
			var genBounds = (is_flag) => {
				return quests.map(chk = (e,i) => {
					return `x${i+1} >= ${(is_flag && e.is_up) ? 1 : 0}`;
				});
			}

			return `Min
				obj: ${genText(true, false)}

				Subject To
				cap:
				${genText(true, true)} = ${opts.getPoint}

				Bounds
				${genBounds(false)}

				Generals
				${genText(false, false)}

				END
				`.replace(/^(\t| )+/gm, "");
		}

		this.runAdjustPtWorker = (opts) => {
			var job = new Worker("t.js");
			var quests = opts.quests,
				getpt = opts.getPoint,
				text = opts.calcText;

			this.todoQsts = [];
			job.onmessage = e => {
				var obj = e.data;
				switch (obj.action){
					case 'log':
						this.outputLog(obj.message);
						break;
					case 'done':
						var arr = $.map(obj.result, e => e);
						opts.quests.forEach((e,i) => e.count = arr[i]);
						this.outputResult(opts);
						break;
				}
			};
			// 解は整数固定(MIP:true)
			job.postMessage({action: 'load', data: text, mip: true});
		}

		this.outputLog = (txt, isCleanup) => {
			if(isCleanup){
				this.consoleList = [];
			}
			this.consoleList.push(txt);
			this.update();
			var cs = $(".calculationConsole > .console:last-child");
			cs && cs[0] && cs[0].scrollIntoView(true);
		}

		this.outputResult = (opts) => {
			var qs = $.extend(true, [], opts.quests),
				getpt = opts.getPoint,
				nowsp = opts.nowPt,
				nowdp = opts.nowDailyPt,
				targetPt = opts.targetPt;
				margin = opts.startMargin;
			this.runInitTp = nowsp;
			this.runInitDp = nowdp;
			this.runEndTp = targetPt;
			this.runEndDp = nowdp + opts.getPoint;
			this.todoQsts = [];

			qst = qs.filter(e => {
				return e.count > 0;
			}).sort((a,b) => {
				if(a.rankNum > b.rankNum) return +1; // 順位: 昇順
				if(a.rankNum < b.rankNum) return -1;
				if(a.count > b.count) return -1; // クリア回数: 降順
				if(a.count < b.count) return +1;
				if(a.pt > b.pt) return -1; // ポイント: 降順
				if(a.pt < b.pt) return +1;
				return 0;
			});

			var qfst = qst[0];
			qfst.isMainQuest = true;
			if(targetPt >= margin){
				var diffCount = Math.ceil(margin / qfst.pt);
				qfst.count -= diffCount;
				var qlst = $.extend(true, {}, qfst);
				qlst.count = diffCount;
				qst.push(qlst);
			}

			var tp = nowsp, dp = nowdp;
			while(tp < targetPt){
				var q = qst.filter(e => {
					return e.count > 0;
				})[0];

				var getp = q.pt * q.count;
				tp += getp, dp += getp;

				this.todoQsts.push({
					type: q.is_ev ? "イベント" : "通常",
					name: q.name,
					rank: q.rank,
					rankNum: q.rankNum,
					point: q.pt,
					count: q.count,
					added_tp: tp,
					added_dp: (nowdp > 0 ? dp : ""),
				});

				q.count = 0;
			}
			console.log(opts);
			this.update();
		}