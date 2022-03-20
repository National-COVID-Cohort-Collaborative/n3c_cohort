<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<head>
 <meta charset="UTF-8">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-136610069-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-136610069-2');
</script>
	 <meta charset="utf-8">
	 <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <title>N3C Cohort Exploration</title>
	 
	<!-- jQuery library -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>$.ajaxPrefilter(function( options, originalOptions, jqXHR ) {    options.async = true; });</script>	
	
	<!-- bootstrap Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
<!-- 	<link href="./resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->
	
	<!-- bootstrap Latest compiled JavaScript -->
<!-- 	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script> -->
	<script src="<util:applicationRoot/>/resources/bootstrap/js/bootstrap.js"></script>

	
	<link rel="stylesheet" type="text/css" href="<util:applicationRoot/>/resources/DataTables/css/jquery.dataTables.min.css"/>
	<script type="text/javascript" charset="utf8" src="<util:applicationRoot/>/resources/DataTables/js/jquery.dataTables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.10.19/dataRender/datetime.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.11.5/sorting/datetime-moment.js"></script>
	
	<script type="text/javascript" charset="utf8" src="<util:applicationRoot/>/tables/jquery.hottie.js"></script>
	<script src="https://unpkg.com/@popperjs/core@2"></script>
	<link rel="stylesheet" id='font-awesome' href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
	
    <link href="https://unpkg.com/tabulator-tables@5.1.2/dist/css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.1.2/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.0/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>
    
	<script src="<util:applicationRoot/>/resources/d3.v4.min.js"></script>
	<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>
	<script src="<util:applicationRoot/>/resources/d3-tip.js"></script>
	<script src='https://cdn.plot.ly/plotly-latest.min.js'></script>
    
</head>
