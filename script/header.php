<html>

<head>
  <script>
    window.onload = function() {
      var height = document.body.scrollHeight;
      window.parent.postMessage({'iframeHeight': height}, '*');
    };
  </script>
</head>

<body>

<!---  generated file; do not change manually -->

<style>
table.program {
	border-collapse:collapse;
	width:90%;
}

table.program td {
	border: 1px solid black; 
	vertical-align: top;
}

table.program td.empty {
	border: none;
	padding-top: 2em;
}

.day {
	width: 100%;
	background-color: #000080;
	color: #e9fbfc;
	font-weight: 300;
	font-size: 120%;
        padding: .5em;
}

.time {
	font-size: 90%;
	font-style:italic;
        padding-top: .5em;
}

.lecture {
        padding: .5em 0em .5em .5em;
}

.lectitle {
	font-weight: bold;
	color: DarkBlue;
	padding-bottom: .1em;
}

.lecturer {
	font-style: normal;
}

.authors {
        font-style: italic;
}

.break {
	background-color: #F8F8F8;
}

.session {
	font-weight: bold;
	padding-top: .8em;
	padding-left: .5em;
}

.slides {
	margin-left: .5em;
}

.chair {
	float: right;
	font-weight: normal;
	padding-right: 2em;
}
</style>


<table class="program">
<tbody>

