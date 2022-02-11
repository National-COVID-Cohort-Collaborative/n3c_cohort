<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    
    path.duas,rect.duas{
    	stroke: #2d5985;
    	stroke-width:2.8px;
    }
    path.dtas,rect.dtas{
    	stroke:#6b496b;
    	stroke-width:2.8px;
    }
    
    .tooltip-dtas, text.dtas{
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

.axis1 text{
  fill: #2d5985;
}

.axis2 text{
  fill: #6b496b;
}
</style>
<body>
	

<script>

// set the dimensions and margins of the graph
	var margin = {top: 30, right: 150, bottom: 80, left: 80},
	    width = 960 - margin.left - margin.right,
	    height = 600 - margin.top - margin.bottom;
	
	d3.json("${param.data_page}", function(error, data) {	
		if (error) throw error;
		
		var column1_opacity = 1;
		var column2_opacity = 1;
		
		<c:if test="${not empty param.column1_opacity}">
			column1_opacity = ${param.column1_opacity};
		</c:if>
		<c:if test="${not empty param.column2_opacity}">
			column2_opacity = ${param.column2_opacity};
		</c:if>
		
		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("${param.dom_element}").select("svg").remove();
					width = newWidth - margin.left - margin.right;
					height = width/2 - margin.top - margin.bottom;
					draw();
				}
			});
		});
		
		myObserver.observe(d3.select("${param.dom_element}").node());
		
		draw();
		
		function draw() {
	
			// set the ranges
			var x = d3.scaleTime().range([0, width]);
			var y1 = d3.scaleLinear().range([height, 0]);
			var y2 = d3.scaleLinear().range([height, 0]);
			var line = d3.line().x(d => x(d.${param.date_column})).y(d => y(d.${param.column1}));
		
			// append the svg obgect to the body of the page
			// appends a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var svg = d3.select("${param.dom_element}").append("svg")
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
			
				// Dates
			 	data.forEach(function(d) {
					d.${param.date_column} = new Date(d.${param.date_column});
				});
			
				// Scales
				x.domain(d3.extent(data, function(d) { return d.${param.date_column}; }));
				<c:choose>
					<c:when test="${not empty param.useColumn1Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
					</c:when>
					<c:when test="${not empty param.useColumn2Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
					</c:when>
					<c:otherwise>
						y1.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
					</c:otherwise>
				</c:choose>
			  
				// X & Y 
				var valueline = d3.line()
					.x(function(d) { return x(d.${param.date_column}); })
					.y(function(d) { return y1(d.${param.column1}); });
				var valueline2 = d3.line()
					.x(function(d) { return x(d.${param.date_column}); })
					.y(function(d) { return y2(d.${param.column2}); });
			
				// Lines
				svg.append("path")
					.data([data])
					.attr("opacity", column1_opacity)
					.attr("class", "line duas")
					.attr("d", valueline);
				svg.append("path")
					.data([data])
					.attr("opacity", column2_opacity)
					.attr("class", "line dtas")
					.attr("d", valueline2);
				
			
				// Labels & Current Totals
				<c:if test="not empty param.lineLabels">
					svg.append("text")
				    	.attr("transform", "translate("+(width+3)+","+y1(data[data.length-1].${param.column1})+")")
				    	.attr("dy", ".35em")
				    	.attr("text-anchor", "start")
				    	.attr("class", "duas")
				    	.text("${param.column1_tip}");
					svg.append("text")
				    	.attr("transform", "translate("+(width+3)+","+y2(data[data.length-1].${param.column2})+")")
				    	.attr("dy", ".35em")
				    	.attr("text-anchor", "start")
				    	.attr("class", "dtas")
				    	.text("${param.column2_tip}");
				</c:if>
				
				//.tickFormat(d3.time.format("%H")))
			  	// Axis
				svg.append("g")
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

				// text label for the x axis
				  svg.append("text")             
				      .attr("transform",
				            "translate(" + (width/2) + " ," + 
				                           (height + margin.top + 20) + ")")
				      .style("text-anchor", "middle")
				      .text("Date");

				  svg.append("g")
			      .attr("class", "axis1")
			      .call(d3.axisLeft(y1));

				  // text label for the y axis
				  svg.append("text")
				      .attr("transform", "rotate(-90)")
				      .attr("y", 0 - margin.left)
				      .attr("x",0 - (height / 2))
				      .attr("dy", "1em")
				      .style("text-anchor", "middle")
				      .text("${param.column1_label}");      
				  
				  svg.append("g")
			      .attr("class", "axis2")
			      .attr("transform", "translate( " + width + ", 0 )")
			      .call(d3.axisRight(y2));
				
				  // text label for the y axis
				  svg.append("text")
				      .attr("transform", "rotate(-90)")
				      .attr("y", width + 50)
				      .attr("x",0 - (height / 2))
				      .attr("dy", "1em")
				      .style("text-anchor", "middle")
				      .text("${param.column2_label}");      

		        // Add the Legend
			    var legend_keys = {"nodes":[{"text": "${param.column1_tip}", "tag": "duas"}, {"text": "${param.column2_tip}", "tag": "dtas"}]};

			    var lineLegend = svg.selectAll(".lineLegend").data(legend_keys.nodes)
			    	.enter().append("g")
			    	.attr("class","lineLegend")
			    	.attr("transform", function (d, i) {
			            return "translate(" + (margin.left - 10) + "," + (i*20)+")";
			        });

				lineLegend.append("text").text(function (d) {return d.text;})
				    .attr("transform", "translate(25, 6)"); //align texts with boxes
	
				lineLegend.append("rect")
				    .attr("width", 22)
				    .attr("class", function(d){return d.tag;})
				    .attr('height', 2);

			     //tooltip line
				var tooltipLine = svg.append('line');
				
				// tooltips
				var dua_dta_focus = svg.append("g")
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
			    	.text("${param.column1_tip}:");
				
				dua_dta_focus.append("text")
		    		.attr("x", 18)
		    		.attr("y", 30)
		    		.text("${param.column2_tip}:");
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-duas")
			    	.attr("x", ${param.column1_tip_offset})
			    	.attr("y", 18);
				
				dua_dta_focus.append("text")
					.attr("class", "tooltip-dtas")
					.attr("x", ${param.column2_tip_offset})
					.attr("y", 30);
				
			
				var tipBox = svg.append("rect")
			    	.attr("class", "overlay")
			    	.attr("width", width)
			    	.attr("height", height)
			    	.on("mouseover", function() { dua_dta_focus.style("display", null);  tooltipLine.style("display", null);})
			    	.on("mouseout", function() { dua_dta_focus.style("display", "none");  tooltipLine.style("display", "none");})
			    	.on("mousemove", dua_dta_mousemove);
			    
				var parseDate = d3.timeFormat("%m/%e/%Y").parse,
				bisectDate_dua_dta = d3.bisector(function(d) { return d.${param.date_column}; }).left,
				formatValue = d3.format(","),
				dateFormatter = d3.timeFormat("%m/%d/%y");
			
				function dua_dta_mousemove() {
				    var x0 = x.invert(d3.mouse(this)[0]),
				        i = bisectDate_dua_dta(data, x0, 1),
				        d0 = data[i - 1],
				        d1 = data[i],
				        d = x0 - d0.first_diagnosis_date > d1.first_diagnosis_date - x0 ? d1 : d0;
				    //dua_focus.attr("transform", "translate(" + x(d.${param.date_column}) + "," + y(d.${param.column1}) + ")");
				    dua_dta_focus.attr("transform", "translate(" + x(d.${param.date_column}) + "," + d3.mouse(this)[1] + ")");
				    dua_dta_focus.select(".tooltip-date_dta_dua").text(dateFormatter(d.${param.date_column}));
				    dua_dta_focus.select(".tooltip-duas").text(formatValue(d.${param.column1}));
				    dua_dta_focus.select(".tooltip-dtas").text(formatValue(d.${param.column2}));
				    
				    tooltipLine.attr('stroke', 'black')
				    	.attr("transform", "translate(" + x(d.${param.date_column}) + "," + 0 + ")")
				    	.attr('y1', 0)
				    	.attr('y2', height);
				}
			};
		});

</script>
</body>