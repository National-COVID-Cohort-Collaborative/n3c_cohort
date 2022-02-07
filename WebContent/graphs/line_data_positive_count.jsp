<!DOCTYPE html>
<meta charset="utf-8">
<style>
    .axis path,
    .axis line {
        fill: none;
        stroke: #000;
        shape-rendering: crispEdges;
    }

    .x.axis path {
        display: none;
    }

    .line {
        fill: none;
        stroke-width: 1.5px;
    }

    .overlay {
        fill: none;
        pointer-events: all;
    }
	
	.tooltip-duas,
	text.duas{
        fill: #2d5985;
    }
    
    .dua_dta_focus .tooltip{
    	fill: white;
    	opacity: 0.7;
    	stroke:none;
    	width:90px;
    }
    
    path.duas{
    	stroke: #2d5985;
    	stroke-width:2.8px;
    }
    path.dtas{
    	stroke:#6b496b;
    	stroke-width:2.8px;
    }
    
    
    .tooltip-dtas, 
    text.dtas{
    	fill:#6b496b;
    }
    
    .dua_dta_focus text{
        font-size: 12px;
    }

    .tooltip {
        fill: white;
        stroke: #000;
    }

    .tooltip-date_dta_dua, 
    .tooltip-duas, 
    .tooltip-dtas{
        font-weight: bold;
    }

</style>
<body>
	

<script>

// set the dimensions and margins of the graph
	var margin = {top: 30, right: 100, bottom: 60, left: 50},
	    width = 960 - margin.left - margin.right,
	    height = 600 - margin.top - margin.bottom;
	
	d3.json("${param.data_page}", function(error, data) {	
		if (error) throw error;
		
		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("${param.dom_element}").select("svg").remove();
					width = newWidth - margin.left - margin.right;
					height = width/2 - margin.top - margin.bottom;
					draw_dta_dua();
				}
			});
		});
		
		myObserver.observe(d3.select("${param.dom_element}").node());
		
		draw_dta_dua();
		
		function draw_dta_dua() {
	
			// set the ranges
			var x = d3.scaleTime().range([0, width]);
			var y = d3.scaleLinear().range([height, 0]);
			var line = d3.line().x(d => x(d.date)).y(d => y(d.cumsum_positivecases));
		
			// append the svg obgect to the body of the page
			// appends a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var dua_dta_svg = d3.select("#dua_line").append("svg")
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
			
				// Dates
			 	data.forEach(function(d) {
					d.date = new Date(d.date);
				});
			
				// Scales
				x.domain(d3.extent(data, function(d) { return d.date; }));
				y.domain([0, d3.max(data, function(d) { return d.cumsum_positivecases; })]);
			  
				// X & Y 
				var valueline = d3.line()
					.x(function(d) { return x(d.date); })
					.y(function(d) { return y(d.cumsum_positivecases); });
				var valueline2 = d3.line()
					.x(function(d) { return x(d.date); })
					.y(function(d) { return y(d.seven_day_rolling_avg); });
			
				// Lines
				dua_dta_svg.append("path")
					.data([data])
					.attr("class", "line duas")
					.attr("d", valueline);
				dua_dta_svg.append("path")
					.data([data])
					.attr("class", "line dtas")
					.attr("d", valueline2);
				
			
				// Labels & Current Totals
				dua_dta_svg.append("text")
			    	.attr("transform", "translate("+(width+3)+","+y(data[data.length-1].cumsum_positivecases)+")")
			    	.attr("dy", ".35em")
			    	.attr("text-anchor", "start")
			    	.attr("class", "duas")
			    	.text("DUAs (" + String(data[data.length-1].cumsum_positivecases)+ ")");
				dua_dta_svg.append("text")
			    	.attr("transform", "translate("+(width+3)+","+y(data[data.length-1].dtas)+")")
			    	.attr("dy", ".35em")
			    	.attr("text-anchor", "start")
			    	.attr("class", "dtas")
			    	.text("DTAs (" + String(data[data.length-1].dtas)+ ")");
			
				//.tickFormat(d3.time.format("%H")))
			  	// Axis
				dua_dta_svg.append("g")
					.attr("transform", "translate(0," + height + ")")
					.call(d3.axisBottom(x).tickFormat(function(date){
					       if (d3.timeYear(date) < date) {
					           return d3.timeFormat('%b')(date);
					         } else {
					           return d3.timeFormat('%Y')(date);
					         }
					      }))
					.selectAll("text")  
    					.style("text-anchor", "end")
    					.attr("dx", "-.8em")
    					.attr("dy", ".15em")
    					.attr("transform", "rotate(-65)");
				dua_dta_svg.append("g")
					.call(d3.axisLeft(y).ticks(5));
				
				//tooltip line
				var tooltipLine = dua_dta_svg.append('line');
				
				// tooltips
				var dua_dta_focus = dua_dta_svg.append("g")
			    	.attr("class", "dua_dta_focus")
			    	.style("display", "none");
			
				dua_dta_focus.append("rect")
			    	.attr("class", "tooltip")
			    	.attr("height", 70)
			    	.attr("x", 10)
			    	.attr("y", -22)
			    	.attr("rx", 4)
			    	.attr("ry", 4);
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-date_dta_dua")
			    	.attr("x", 18)
			    	.attr("y", -2);
			
				dua_dta_focus.append("text")
			    	.attr("x", 18)
			    	.attr("y", 18)
			    	.text("DUAs:");
				
				dua_dta_focus.append("text")
		    		.attr("x", 18)
		    		.attr("y", 30)
		    		.text("DTAs:");
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-duas")
			    	.attr("x", 60)
			    	.attr("y", 18);
				
				dua_dta_focus.append("text")
					.attr("class", "tooltip-dtas")
					.attr("x", 60)
					.attr("y", 30);
				
			
				var tipBox = dua_dta_svg.append("rect")
			    	.attr("class", "overlay")
			    	.attr("width", width)
			    	.attr("height", height)
			    	.on("mouseover", function() { dua_dta_focus.style("display", null);  tooltipLine.style("display", null);})
			    	.on("mouseout", function() { dua_dta_focus.style("display", "none");  tooltipLine.style("display", "none");})
			    	.on("mousemove", dua_dta_mousemove);
			    
				var parseDate = d3.timeFormat("%m/%e/%Y").parse,
				bisectDate_dua_dta = d3.bisector(function(d) { return d.date; }).left,
				formatValue = d3.format(","),
				dateFormatter = d3.timeFormat("%m/%d/%y");
			
				function dua_dta_mousemove() {
				    var x0 = x.invert(d3.mouse(this)[0]),
				        i = bisectDate_dua_dta(data, x0, 1),
				        d0 = data[i - 1],
				        d1 = data[i],
				        d = x0 - d0.date > d1.date - x0 ? d1 : d0;
				    //dua_focus.attr("transform", "translate(" + x(d.date) + "," + y(d.cumsum_positivecases) + ")");
				    dua_dta_focus.attr("transform", "translate(" + x(d.date) + "," + d3.mouse(this)[1] + ")");
				    dua_dta_focus.select(".tooltip-date_dta_dua").text(dateFormatter(d.date));
				    dua_dta_focus.select(".tooltip-duas").text(formatValue(d.cumsum_positivecases));
				    dua_dta_focus.select(".tooltip-dtas").text(formatValue(d.dtas));
				    
				    tooltipLine.attr('stroke', 'black')
				    	.attr("transform", "translate(" + x(d.date) + "," + 0 + ")")
				    	.attr('y1', 0)
				    	.attr('y2', height);
				}
			};
		});

</script>
</body>