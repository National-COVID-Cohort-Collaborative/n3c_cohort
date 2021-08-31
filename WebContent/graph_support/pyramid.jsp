<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>

d3.json("${param.data_page}", function(data) {
	// SET UP DIMENSIONS
	var w = 500,
		h = 300;

	// margin.middle is distance from center line to each y-axis
	var margin = {
		top: 10,
		right: -15,
		bottom: 80,
		left: 5,
		middle: 18
	};
	

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			// console.log('body width '+newWidth);
			if (newWidth > 0) {
				d3.select("${param.dom_element}").select("svg").remove();
				w = newWidth;
				draw();
			}
		});
	});
	myObserver.observe(d3.select("${param.dom_element}").node());

	draw();

	function draw() {
		// the width of each side of the chart
		var regionWidth = w / 2 - margin.middle;
		
		// these are the x-coordinates of the y-axes
		var pointA = regionWidth,
			pointB = w - regionWidth;
		
		// GET THE TOTAL POPULATION SIZE AND CREATE A FUNCTION FOR RETURNING THE PERCENTAGE
		var totalPopulation = d3.sum(data, function(d) { return d.left + d.right; }),
			percentage = function(d) { return d / totalPopulation; };
		
		
		// CREATE SVG
		var svg = d3.select('${param.dom_element}').append('svg')
			.attr('width', margin.left + w - margin.right)
			.attr('height', margin.top + h + margin.bottom)
			// ADD A GROUP FOR THE SPACE WITHIN THE MARGINS
			.append('g')
			.attr('transform', translation(margin.left, margin.top));
		
		// find the maximum data value on either side
		//  since this will be shared by both of the x-axes
    <c:choose>
	<c:when test="${not empty param.maxValue}">
	    var maxValue = ${param.maxValue};
	</c:when>
	<c:otherwise>
		var maxValue = Math.max(
				d3.max(data, function(d) { return d.left; }),
				d3.max(data, function(d) { return d.right; })
		);
	</c:otherwise>
	</c:choose>
		
		// SET UP SCALES
		
		// the xScale goes from 0 to the width of a region
		//  it will be reversed for the left x-axis
		var xScale = d3.scaleLinear()
			.domain([0, maxValue])
			.range([0, regionWidth])
			.nice();
		
		var xScaleLeft = d3.scaleLinear()
			.domain([0, maxValue])
			.range([regionWidth, 0]);
		
		var xScaleRight = d3.scaleLinear()
			.domain([0, maxValue])
			.range([0, regionWidth]);
		
		var yScale = d3.scaleBand()
			.domain(data.map(function(d) { return d.group; }))
			.range([h, 0], 0.1);
		
		
		// GRIDLINES ********************************************************************
		// gridlines in y axis function
		function make_y_gridlines() {		
		    return d3.axisLeft(yScale)
		        .tickValues(yScale.domain().filter(function(d,i){ return !(i%10)}));
		}


	  	// add the Y gridlines
	  	
	  	svg.append("g")			
	     	.attr("class", "grid")
	     	.call(make_y_gridlines()
	    		.tickSize(-pointA)
          		.tickFormat("")
	      )
	      
	      svg.append("g")			
	     	.attr("class", "grid")
	     	.attr('transform', translation(pointB, 0))
	     	.call(make_y_gridlines()
	    		.tickSize(-pointA)
          		.tickFormat("")
          		
	      )

		
		// SET UP AXES ********************************************************************
		var yAxisLeft = d3.axisRight()
			.scale(yScale)
			.tickSize(0, 0)
			.tickPadding(margin.middle)
			.tickValues(yScale.domain().filter(function(d,i){ return !(i%10)}));
		
		var yAxisRight = d3.axisLeft()
			.scale(yScale)
			.tickSize(0, 0)
			.tickFormat('')
			.tickValues(yScale.domain().filter(function(d,i){ return !(i%10)}));;
		
		var xAxisRight = d3.axisBottom()
			.scale(xScale)
			.ticks(3, ",s");
		
		var xAxisLeft = d3.axisBottom()
			// REVERSE THE X-AXIS SCALE ON THE LEFT SIDE BY REVERSING THE RANGE
			.scale(xScale.copy().range([pointA, 0]))
			.ticks(3, ",s");


		
		
	    // Labels ********************************************************************
		svg.append("text")
        .attr("transform", "translate(" + (w * .25) + " ," + 0 + ")")
        .style("text-anchor", "middle")
        .text("${param.left_header}");

		svg.append("text")
        .attr("transform", "translate(" + (w * .75) + " ," + 0 + ")")
        .style("text-anchor", "middle")
        .text("${param.right_header}");

		svg.append("text")
        .attr("transform", "translate(" + (w * .15) + " ," + (h + 50) + ")")
        .style("text-anchor", "middle")
        .text("${param.left_label}");

		svg.append("text")
        .attr("transform", "translate(" + (w / 2) + " ," + (h + 40) + ")")
        .style("text-anchor", "middle")
        .text("${param.middle_label}");

		svg.append("text")
        .attr("transform", "translate(" + (w * .85) + " ," + (h + 50) + ")")
        .style("text-anchor", "middle")
        .text("${param.right_label}");

		
		// MAKE GROUPS FOR EACH SIDE OF CHART
		// scale(-1,1) is used to reverse the left side so the bars grow left instead of right
		var leftBarGroup = svg.append('g')
			.attr('transform', translation(pointA, 0) + 'scale(-1,1)');
		var rightBarGroup = svg.append('g')
			.attr('transform', translation(pointB, 0));
		
		// DRAW AXES
		svg.append('g')
			.attr('class', 'axis y left')
			.attr('transform', translation(pointA, 0))
			.call(yAxisLeft)
			.selectAll('text')
			.style('text-anchor', 'middle');
		
		svg.append('g')
			.attr('class', 'axis y right')
			.attr('transform', translation(pointB, 0))
			.call(yAxisRight);
		
		svg.append('g')
			.attr('class', 'axis x left')
			.attr('transform', translation(0, h))
			.call(xAxisLeft)
			.selectAll("text")	
       			.style("text-anchor", "middle")
        		.attr("dy", ".60em");
		
		svg.append('g')
			.attr('class', 'axis x right')
			.attr('transform', translation(pointB, h))
			.call(xAxisRight)
			.selectAll("text")	
       			.style("text-anchor", "middle")
         		.attr("dy", ".60em");
		
		
		
		// DRAW BARS
		leftBarGroup.selectAll('.bar.left')
			.data(data)
			.enter().append('rect')
			.attr('class', 'bar left')
			.attr('x', 0)
			.attr('y', function(d) { return yScale(d.group); })
			.style("stroke", "#2d5985")
			.style("stroke-width", 1)
			.attr('width', function(d) { return xScale(d.left); })
			.attr('height', yScale.bandwidth());
		
		rightBarGroup.selectAll('.bar.right')
			.data(data)
			.enter().append('rect')
			.attr('class', 'bar right')
			.attr('x', 0)
			.attr('y', function(d) { return yScale(d.group); })
			.style("stroke", "#bce4d8")
			.style("stroke-width", 1)
			.attr('width', function(d) { return xScale(d.right); })
			.attr('height', yScale.bandwidth());
		
	}
});

//so sick of string concatenation for translations
function translation(x, y) {
	return 'translate(' + x + ',' + y + ')';
}

</script>
