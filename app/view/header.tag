header
	//-.link.toplink
		a(href="/") Wizardcup Point Adjustment Tool
	.link.toplink
		a(href="/")
			.caps W
			.small izardcup 
			.caps P
			.small oint 
			.caps A
			.small djustment 
			.caps T
			.small ool

	.link.sub.information
		| » ポイント調整の計算補助ツール
	.link.sub.github
		a(href="https://github.com/arika0093/wizptadjust" target="_blank") GitHub

	// -------------------------
	style(type="scss").
		
		header {
			display: flex;
			flex-direction: row;
			background-color: #08F;
			padding: 1ex 1ex;
			color: #EEE;
			font-weight: bolder;
			justify-content: stretch;
			align-items: center;
		}
		header:hover{
			color: #FFF;
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
		.link.sub.information {
			flex-grow: 1;
		}

		@media screen and (max-width: 600px) { 
			.link.sub {
				display: none;
			}
		}

		.toplink .caps {
			display: inline;
			font-size: 1.1rem;
			transition: .3s;
		}
		.toplink .small {
			display: none;
			animation-name: popupSmallLatter;
			animation-duration: .3s;
			animation-timing-function: ease-out;
		}
		header:hover .caps {
			margin-left: .5ex;
			margin-right: 1px;
		}
		header:hover .small {
			display: inline-block;
			font-size: .9rem;
			color: #EEE;
		}

		@keyframes popupSmallLatter {
			0% {
				width: 0%;
				opacity: 0;
				letter-spacing: -10px;
			}
			50% {
				width: auto;
				opacity: 0.2;
			}
			100% {
				width: auto;
				opacity: 1;
				letter-spacing: 0px;
			}
		}


		
	// -------------------------
	script.
		
		
		
		