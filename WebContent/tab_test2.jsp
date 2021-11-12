<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="id=edge">
<title>title</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

	<ul class="nav nav-tabs">
		<ul class="nav nav-tabs">
			<li class="active"><a data-src="cohort.jsp" href="#eros"
				data-toggle="tab">EROs</a></li>
			<li><a data-src="feeds/project_roster.jsp" href="#imports"
				data-toggle="tab">Imports</a></li>
			<li><a data-src="feeds/siteRoster.jsp" href="#accounting"
				data-toggle="tab">Accounting</a></li>
		</ul>

		<div class="tab-content clear-fix">
			<div class="tab-pane active" id="eros"></div>
			<div class="tab-pane" id="imports"></div>
			<div class="tab-pane" id="accounting"></div>
		</div>
		<script>
	  var crumbs = '#eros';
	  $( function () {

			$( '.nav-tabs a' ).each( function ( index, el ) {
		  
		  	var $this = $( this );
		    var pane  = $this.attr( 'href' );
		    var which = $this.data( 'src' );
		    
		    if (pane == '#eros') $( pane ).load( which );
		    
		  } );

		} );

      $('.nav-tabs').on('click', 'a', function(e) {
          e.preventDefault();

          var $this = $(this);
		    var pane  = $this.attr( 'href' );
		    var which = $this.data( 'src' );

		    if (!crumbs.includes(pane)) {
		    	$( pane ).load( which );
		    	crumbs = crumbs + pane;
          console.log({
            pane: pane,
            which: which
          });
		    }

        });
  </script>
</body>
</html>