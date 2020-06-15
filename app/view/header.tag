header
	.link.toplink
		a(href="/") Wizardcup Point Adjustment Tool
	//-.link.sub.deflink
		a(href="/#!/define") 登録データ確認
	//-.link.sub.twitter
		a(href="https://twitter.com/ark4x" target="_blank") Twitter
	.link.sub.github
		a(href="https://github.com/arika0093" target="_blank") GitHub

	// -------------------------
	style(type="scss").
		
		header {
			display: flex;
			flex-direction: row;
			background-color: #08F;
			padding: 1ex 1ex;
			color: #FFF;
			font-weight: bolder;
			justify-content: stretch;
			align-items: center;
		}

		a, a:visited {
			color: #EEE;
			text-decoration: none;
		}
		a:hover {
			text-decoration: underline;
		}

		.link {
			margin: 0 .8ex;
		}
		.link.sub {
			font-size: smaller;    
		}
		.link.toplink {
			flex-grow: 1;
		}

		@media screen and (max-width: 600px) { 
			.link.sub {
				display: none;
			}
		}
		
	// -------------------------
	script.
		
		
		
		