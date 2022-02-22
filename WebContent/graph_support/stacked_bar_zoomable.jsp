<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta charset="utf-8">

<style>
rect{
	cursor: auto;
}

.dua_dta_focus{
	fill: black;
	pointer-events:none;
}


.bar_rect{
	shape-rendering: crispEdges;
}

.overlay {
	fill: none;
	pointer-events: bounding-box;
}

.tool_line{
	pointer-events:none;
}

.tooltip-first,
text.tooltip-first{
	fill: ${param.column1_color} ;
}

.tooltip-second, 
text.tooltip-second{
	fill: ${param.column2_color} ;
}

.tooltip-third, 
text.tooltip-third{
	fill: ${param.column3_color} ;
}

.dua_dta_focus text{
	font-size: 12px;
}

.tooltip {
	fill: white;
	stroke: #000;
}

.tooltip-date, 
.tooltip-first, 
.tooltip-second,
.tooltip-third{
	font-weight: bold;
}

.dua_dta_focus .tooltip{
    	opacity: 0.7;
    	stroke:none;
    	width:140px;
    }

</style>

<script>

// set the dimensions and margins of the graph
	var ${param.namespace}margin = {top: 100, right: 10, bottom: 80, left: 80},
	${param.namespace}width = 960 - ${param.namespace}margin.left - ${param.namespace}margin.right,
	${param.namespace}height = 600 - ${param.namespace}margin.top - ${param.namespace}margin.bottom;
	
	
	
	d3.json("${param.data_page}", function(error, data) {	
		if (error) throw error;
		console.log(data);
		
		
		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var ${param.namespace}newWidth = Math.floor(entry.contentRect.width);
				if (${param.namespace}newWidth > 0) {
					d3.select("${param.dom_element}").select("svg").remove();
					${param.namespace}width = ${param.namespace}newWidth - ${param.namespace}margin.left - ${param.namespace}margin.right;
					if ((${param.namespace}width/2 - ${param.namespace}margin.top - ${param.namespace}margin.bottom) > 200){
						${param.namespace}height = ${param.namespace}width/2 - ${param.namespace}margin.top - ${param.namespace}margin.bottom;
					} else { 
						${param.namespace}height = 200;
					}
					draw();
				}
			});
		});
		
		myObserver.observe(d3.select("${param.dom_element}").node());
		
		draw();
		
		function draw() {
		
			var keys = [];
			
			for (key in data[0]){
				if (key != "${param.date_column}" && key != "date" && key != "total")
					keys.push(key);
			};
			
			var	parseDate = d3.isoParse;
			
			data.forEach(function(d){
				d.date = parseDate(d.${param.date_column});
				d.total = 0;
				keys.forEach(function(k){
					d.total += d[k];
				})
			});
			
			// Add axis
			var ${param.namespace}x = d3.scaleBand()
				.range([0, ${param.namespace}width])
				.paddingInner(-1)
				.padding(0)
				.paddingOuter(0)
				.domain(data.map(function(d) {return d.date;}));
			
			var xAxis = d3.axisBottom()
				.scale(${param.namespace}x)
				.tickValues(${param.namespace}x.domain().filter(
						function(d){ 
							return (d.getUTCDate() == 1)
						}))
				.tickFormat(function(date){
					if (date.getUTCMonth() == 1) {
						return d3.timeFormat('%Y')(date);
					} else {
						if (date.getUTCDate()==1){
							return d3.timeFormat('%b')(date);
						} else {
							return d3.timeFormat('%b %d')(date);
						}
					}
				});
			
			var y = d3.scaleLinear()
	    		.rangeRound([${param.namespace}height, 0])
	    		.domain([0, d3.max(data, function(d) {return d.total;})]).nice();
		
			var yAxis = d3.axisLeft()
				.scale(y)
				.ticks(10);
		 
	
			var z = d3.scaleOrdinal()
				.domain(keys)
		    	.range(['${param.column1_color}','${param.column3_color}', '${param.column2_color}']);


			// append the svg object to the body of the page
			var svg = d3.select("${param.dom_element}_graph").append("svg")
				.attr("class", "clear_target")
			    .attr("width", ${param.namespace}width + ${param.namespace}margin.left + ${param.namespace}margin.right)
			    .attr("height", ${param.namespace}height + ${param.namespace}margin.top + ${param.namespace}margin.bottom);
			

			// Add a clipPath: everything out of this area won't be drawn.
			 var clip = svg.append("defs").append("svg:clipPath")
			     .attr("id", "${param.namespace}clip")
			     .append("svg:rect")
			     .attr("width", ${param.namespace}width)
			     .attr("height", ${param.namespace}height)
			     .attr("x", 0)
			     .attr("y", 0);
			
			// Create the scatter variable: where the brush take place
			var graph = svg.append('g')
				.attr("transform", "translate(" + ${param.namespace}margin.left + "," + ${param.namespace}margin.top + ")")
				.attr("clip-path", "url(#${param.namespace}clip)")
  				.attr("class", "overlay");
			
			var graph_bar = graph.append("g");
			
			var bar_container = graph_bar.append("g")
				.attr("class", "top_bar")
				.selectAll("g")
				.data(d3.stack().keys(keys)(data))
				.enter().append("g")
					.attr("class", "cat_bars")
					.attr("fill", function(d) {return z(d.key);})
				.selectAll("rect")
					.data(function(d) {return d;})
					.enter().append("rect")
						.attr("class", "bar_rect")
						.attr("x", function(d) {return ${param.namespace}x(d.data.date);})
						.attr("y", function(d) {return y(d[1]);})
						.attr("height", function(d) {return y(d[0]) - y(d[1]);})
						.attr("width", ${param.namespace}x.bandwidth());
		
			// Add brushing
			var brush = d3.brushX()                   // Add the brush feature using the d3.brush function
				.extent( [ [0,0], [${param.namespace}width,${param.namespace}height] ] )  // initialise the brush area: start at 0,0 and finishes at width,height: it means I select the whole graph area
				.on("brush", tool_focus_mousemove)
				.on("end", ${param.namespace}updateChart);              // Each time the brush selection changes, trigger the 'updateChart' function

			// Add the brush
			var test_tip = graph
			    .append("g")
			    .attr("class", "brush")
			    .call(brush)
			    .on("mouseover", function() { tool_focus.style("display", null);  tooltipLine.style("display", null);})
	    	  	.on("mouseout", function() { tool_focus.style("display", "none");  tooltipLine.style("display", "none");})
	    	  	.on("mousemove", tool_focus_mousemove);
		
			
			// add axis
			var g = svg.append("g")
				.attr("transform", "translate(" + ${param.namespace}margin.left + "," + ${param.namespace}margin.top + ")");
			g.append("g")
	    		.attr("class", "x axis")
				.attr("transform", "translate(0," + ${param.namespace}height + ")")
				.call(xAxis.ticks(3).tickSize(0))
				.selectAll("text")  
					.style("text-anchor", "end")
					.attr("dx", "-.8em")
					.attr("dy", ".15em")
					.attr("transform", "rotate(-65)");
			g.append("g")
				.attr("class", "y axis")
				.call(yAxis.ticks(null).tickSize(0))
				.append("text")
				.attr("y", 6)
				.attr("text-anchor", "middle")
				.text("Value");
			
			// text label for the y axis
			g.append("text")
			    .attr("transform", "rotate(-90)")
			    .attr("y", 0 - ${param.namespace}margin.left)
			    .attr("x",0 - (${param.namespace}height / 2))
			    .attr("dy", "1em")
			    .style("text-anchor", "middle")
			    .text("${param.yaxis_label}");
		
			
			//tooltip line
			var tooltipLine = graph.append('line')
				.attr("class", "tool_line");
			
			// tooltips
			var tool_focus = test_tip.append("g")
		    	.attr("class", "dua_dta_focus")
		    	.style("display", "none");
		
			tool_focus.append("rect")
		    	.attr("class", "tooltip")
		    	.attr("height", 70)
		    	.attr("x", 10)
		    	.attr("y", -22)
		    	.attr("rx", 4)
		    	.attr("ry", 4);
		
			tool_focus.append("text")
		    	.attr("class", "tooltip-date")
		    	.attr("x", 18)
		    	.attr("y", 0);
		
			tool_focus.append("text")
		    	.attr("x", 18)
		    	.attr("y", 18)
		    	.text("${param.column1_tip}:");
			
			tool_focus.append("text")
	    		.attr("x", 18)
	    		.attr("y", 30)
	    		.text("${param.column2_tip}:");
			
			tool_focus.append("text")
    			.attr("x", 18)
    			.attr("y", 42)
    			.text("${param.column3_tip}:");
		
			tool_focus.append("text")
		    	.attr("class", "tooltip-first")
		    	.attr("x", ${param.column1_tip_offset})
		    	.attr("y", 18);
			
			tool_focus.append("text")
				.attr("class", "tooltip-second")
				.attr("x", ${param.column2_tip_offset})
				.attr("y", 30);
			
			tool_focus.append("text")
				.attr("class", "tooltip-third")
				.attr("x", ${param.column3_tip_offset})
				.attr("y", 42);
		
			
			
			// Legend
			var legend = svg.append("g")
			.attr("transform", "translate(0,10)")
			.attr("font-family", "sans-serif")
			.attr("font-size", 10)
			.attr("text-anchor", "end")
			.selectAll("g")
			.data(keys.slice().reverse())
			.enter().append("g")
				.attr("transform", function(d, i) {
					return "translate(0," + i * 20 + ")";
				});

			legend.append("rect")
				.attr("x", ${param.namespace}width - 19)
				.attr("width", 19)
				.attr("height", 19)
				.attr("fill", z);

			legend.append("text")
				.attr("x", ${param.namespace}width - 24)
				.attr("y", 9.5)
				.attr("dy", "0.32em")
				.text(function(d) {
					return d;
				});
			
			${param.namespace}x.invert = function(x){ return d3.scaleQuantize().domain(this.range()).range(this.domain())(x);};
			var parseDate = d3.timeFormat("%m/%e/%Y").parse,
				bisectDate_dua_dta = d3.bisector(function(d) { return d.date; }).left,
				formatValue = d3.format(","),
				dateFormatter = d3.timeFormat("%m/%d/%y");
			
			function tool_focus_mousemove() {
			    var x0 = ${param.namespace}x.invert(d3.mouse(this)[0]),
			        i = bisectDate_dua_dta(data, x0, 1),
			        d0 = data[i - 1],
			        d1 = data[i],
			        d = x0 - d0.date > d1.date - x0 ? d1 : d0;
			        
			        
		        if (${param.namespace}width/2 > d3.mouse(this)[0]){
		        	tool_focus.attr("transform", "translate(" + ${param.namespace}x(d.date) + "," + d3.mouse(this)[1] + ")");
			    } else {
			    	tool_focus.attr("transform", "translate(" + ((${param.namespace}x(d.date))-150) + "," + d3.mouse(this)[1] + ")");
			    };
			   
			    tool_focus.select(".tooltip-date").text(dateFormatter(d.date));
			    tool_focus.select(".tooltip-first").text(formatValue(d.${param.column1}));
			    tool_focus.select(".tooltip-second").text(formatValue(d.${param.column2}));
			    tool_focus.select(".tooltip-third").text(formatValue(d.${param.column3}));
		    
			    tooltipLine.attr('stroke', 'black')
			    	.attr("transform", "translate(" + ${param.namespace}x(d.date) + "," + 0 + ")")
			    	.attr('y1', 0)
			    	.attr('y2', height);
			};
			
			// A function that set idleTimeOut to null
			 var idleTimeout;
			 function idled() { idleTimeout = null; };
			 
			
			// A function that update the chart for given boundaries
			   function ${param.namespace}updateChart() {

				   	
					// What are the selected boundaries?
					var extent = d3.event.selection;
					
					var sub_data = [];

			      	// If no selection, back to initial coordinate. Otherwise, update X axis domain
			     	if(!extent){
			        	if (!idleTimeout) return idleTimeout = setTimeout(idled, 350); // This allows to wait a little bit
			        	${param.namespace}x.domain(data.map(function(d) { return d.date; }));
			        	sub_data = data;
			      	}else{
			      		data.map(function(d) {
			      			var large = (${param.namespace}x.invert(extent[0]) > ${param.namespace}x.invert(extent[1]) ? ${param.namespace}x.invert(extent[0]) : ${param.namespace}x.invert(extent[1]));
			      			var small = (${param.namespace}x.invert(extent[0]) < ${param.namespace}x.invert(extent[1]) ? ${param.namespace}x.invert(extent[0]) : ${param.namespace}x.invert(extent[1]));
			      			
			      			if (d.date >= small && d.date <= large){
			      				sub_data.push(d);
			      			};
			      		});
			      		${param.namespace}x.domain(sub_data.map(function(d) { return d.date; }));
			        	graph.select(".brush").call(brush.move, null); // This remove the grey brush area as soon as the selection has been done
			      	};
			      		
				      
			        var day_num = sub_data.length;
			        var num_ticks = 0;
			        
			        if (sub_data.length <= 31){
			        	num_ticks = 1;
			        }else if (sub_data.length <= 93) {
			        	num_ticks = 2;
			        } else {
			        	num_ticks = 0;
			        }
			        
			      	// redraw axis
			      	d3.selectAll('${param.dom_element} .x.axis').remove();
			      	g.append("g")
						.attr("transform", "translate(0," + ${param.namespace}height + ")")
						.attr("class", "x axis")
						.call(xAxis.ticks(null).tickSize(0).tickValues(${param.namespace}x.domain().filter(
								function(d){ 
									if (num_ticks == 1){
										return d == d;
									} else if (num_ticks == 2){
										return d.getUTCDay() == 1;
									} else {
										return d.getUTCDate() == 1;
									}
								})))
						.selectAll("text")  
							.style("text-anchor", "end")
							.attr("dx", "-.8em")
							.attr("dy", ".15em")
							.attr("transform", "rotate(-65)");
			      	
			      	svg.selectAll(".top_bar").remove();
			      	
			    	// redraw bars
			      	var bar = graph_bar.append("g")
 						.attr("class", "top_bar")
 						.selectAll("g")
			        	.data(d3.stack().keys(keys)(sub_data))
			        	.enter().append("g")
			        		.attr("class", "cat_bars")
 							.attr("fill", function(d) {return z(d.key);});
			      	
			      	bar.selectAll("rect")
						.data(function(d) {return d;})
						.enter().append("rect")
							.attr("class", "bar_rect")
							.attr("x", function(d) {return ${param.namespace}x(d.data.date);})
							.attr("y", function(d) {return y(0);})
							.attr("width", ${param.namespace}x.bandwidth())
							.transition()
    						.duration(1000)
    						.attr("y", function(d) {return y(d[1]);})
    						.attr("height", function(d) {return y(d[0]) - y(d[1]);});
			      	
			      	
			      	 bar.exit().remove();
    						
							

			};
			
			
			d3.select("${param.dom_element} ${param.dom_element}_graph .clear_target")
				.on('dblclick', ${param.namespace}updateChart );
			
			$( "${param.dom_element}_btn" ).click(function() {
				
				d3.select("${param.dom_element} ${param.dom_element}_graph .clear_target").dispatch("dblclick");
			});
			
		};		
	});
				

	
	</script>
