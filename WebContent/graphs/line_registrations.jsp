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
	
	.reg_focus circle, 
	text.registration{
        fill: #376076;
    }
    .reg_focus .tooltip{
    	fill: white;
    	opacity: 0.7;
    	stroke:none;
    	width:100px;
    }
    
    path.registration{
    	stroke: #376076;
    }

    
    .reg_focus text{
        font-size: 12px;
    }

    .tooltip {
        fill: white;
        stroke: #000;
    }
    
    .tooltip-registration{
    	fill:#376076;
    }

    .tooltip-registration, .tooltip-date{
        font-weight: bold;
    }

</style>
<body>
	
<script src="https://d3js.org/d3.v4.min.js"></script>
<script>
//set the dimensions and margins of the graph
	var reg_margin = {top: 30, right: 100, bottom: 30, left: 50},
		reg_width = 960 - reg_margin.left - reg_margin.right,
		reg_height = 600 - reg_margin.top - reg_margin.bottom;
	
	
	d3.json("${param.data_page}", function(error, data2) {	
		if (error) throw error;

		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("${param.dom_element}").select("svg").remove();
					reg_width = newWidth - reg_margin.left - reg_margin.right;
					reg_height = (reg_width/2) - reg_margin.top - reg_margin.bottom;
					draw_regs();
				}
			});
		});
		
		myObserver.observe(d3.select("${param.dom_element}").node());
		
		draw_regs();
			
		function draw_regs() {
			
			// set the ranges
			var reg_x = d3.scaleTime().range([0, reg_width]);
			var reg_y = d3.scaleLinear().range([reg_height, 0]);
			var reg_line = d3.line().x(d => x(d.date)).y(d => y(d.registrations));
			
			// append the svg obgect to the body of the page
			// appends a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var reg_svg = d3.select("${param.dom_element}").append("svg")
				.attr("width", reg_width + reg_margin.left + reg_margin.right)
				.attr("height", reg_height + reg_margin.top + reg_margin.bottom)
				.append("g")
				.attr("transform", "translate(" + reg_margin.left + "," + reg_margin.top + ")");
		
		
			// Dates
		 	data2.forEach(function(d) {
				d.date = new Date(d.date);
			});
		
			// Scales
			reg_x.domain(d3.extent(data2, function(d) { return d.date; }));
			reg_y.domain([0, d3.max(data2, function(d) { return d.registrations; })]);
		  
			// X & Y 
			var reg_valueline = d3.line()
				.x(function(d) { return reg_x(d.date); })
				.y(function(d) { return reg_y(d.registrations); });
		
		
			// Lines
			reg_svg.append("path")
				.data([data2])
				.attr("class", "line registration")
				.attr("d", reg_valueline);
			
		
			// Labels & Current Totals
			reg_svg.append("text")
		    	.attr("transform", "translate("+(reg_width+3)+","+reg_y(data2[data2.length-1].registrations)+")")
		    	.attr("dy", ".35em")
		    	.attr("text-anchor", "start")
		    	.attr("class", "registration")
		    	.text("Users: (" + String(data2[data2.length-1].registrations)+ ")");
		
		
		  	// Axis
			reg_svg.append("g")
				.attr("transform", "translate(0," + reg_height + ")")
				.call(d3.axisBottom(reg_x).tickFormat(function(date){
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
			reg_svg.append("g")
				.call(d3.axisLeft(reg_y).ticks(5));
			
			//tooltip line
			var reg_tooltipLine = reg_svg.append('line');
			
			// tooltips
			var reg_focus = reg_svg.append("g")
		    	.attr("class", "reg_focus")
		    	.style("display", "none");
		
// 			reg_focus.append("circle")
// 		    	.attr("r", 5);
		
			reg_focus.append("rect")
		    	.attr("class", "tooltip")
		    	.attr("width", 100)
		    	.attr("height", 50)
		    	.attr("x", 10)
		    	.attr("y", -22)
		    	.attr("rx", 4)
		    	.attr("ry", 4);
		
			reg_focus.append("text")
				.attr("class", "tooltip-date")
				.attr("x", 18)
				.attr("y", -2);
		
			reg_focus.append("text")
				.attr("x", 18)
				.attr("y", 18)
				.text("Users:");
		
			reg_focus.append("text")
				.attr("class", "tooltip-registration")
				.attr("x", 60)
				.attr("y", 18);
		
		
			reg_svg.append("rect")
		    	.attr("class", "overlay")
		    	.attr("width", reg_width)
		    	.attr("height", reg_height)
		    	.on("mouseover", function() { reg_focus.style("display", null);  reg_tooltipLine.style("display", null); })
		    	.on("mouseout", function() { reg_focus.style("display", "none"); reg_tooltipLine.style("display", "none"); })
		    	.on("mousemove", reg_mousemove);
		    
			var parseDate = d3.timeFormat("%m/%e/%Y").parse,
			bisectDate = d3.bisector(function(d) { return d.date; }).left,
			formatValue = d3.format(","),
			dateFormatter = d3.timeFormat("%m/%d/%y");
		
			function reg_mousemove() {
			    var x0 = reg_x.invert(d3.mouse(this)[0]),
			        i = bisectDate(data2, x0, 1),
			        d0 = data2[i - 1],
			        d1 = data2[i],
			        d = x0 - d0.date > d1.date - x0 ? d1 : d0;
			    reg_focus.attr("transform", "translate(" + reg_x(d.date) + "," +  d3.mouse(this)[1] + ")");
			    reg_focus.select(".tooltip-date").text(dateFormatter(d.date));
			    reg_focus.select(".tooltip-registration").text(formatValue(d.registrations));
			    
			    reg_tooltipLine.attr('stroke', 'black')
		    		.attr("transform", "translate(" + reg_x(d.date) + "," + 0 + ")")
		    		.attr('y1', 0)
		    		.attr('y2', reg_height);
			}
		};
	});

</script>
</body>