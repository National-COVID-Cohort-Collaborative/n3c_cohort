	<script type="text/javascript">
		//Width and height of map
		var width = 400;
		var height = 600;
		
		// Load the Cohort Data
		d3.json("${param.data_page}", function(error, data) {
			if (error) throw error;
			  
			var myObserver = new ResizeObserver(entries => {
				entries.forEach(entry => {
					var newWidth = Math.floor(entry.contentRect.width);
					// console.log('body width '+newWidth);
					if (newWidth > 0) {
						d3.select("${param.dom_element}").select("svg").remove();
						width = newWidth;
						height=300;
						draw();
					}
				});
			});
			myObserver.observe(d3.select("${param.dom_element}").node());

			draw();

			function draw() {
				
				var svg = d3.select("${param.dom_element}")
				  .append("svg")
				  .attr("width", width)
				  .attr("height", height);
				
			// Color Scale For Legend and Map 
			//var color = d3.scaleOrdinal() 
			//	.domain([1, 2, 3, 4, 5, 6, 7, 8, 9])
			//	.range(["#bce4d8", "#b6e1d8", "#a8d9d4", "#a4d8d3", "#9ed4d2", "#80c3cb", "#65b4c3", "#3791b0", "#2d5985"]);
			
			// Legend ******************************************************** 
			var regions = data.regions;
			var formatComma = d3.format(",");
			
			var color = d3.scaleLinear()
			  .domain([d3.min(regions, function(d) { return d.cumulative; }), d3.max(regions, function(d) { return d.cumulative; })])
			  .range(["#bce4d8", "#2d5985"]);
			
			var legend = svg.append("g")
				.attr("font-size", 14)
				.attr("text-anchor", "start")
				.selectAll("g")
				.data(regions)
				.enter().append("g")
				.attr("transform", function(d, i) { return "translate(0," + ((i * 27) + 20) + ")"; });
				
			legend.append("rect")
				.attr("x", 0)
				.attr("width", 75)
				.attr("height", 25)
				.attr("fill", function(d) { return color(d.cumulative); })
				.on("mouseover",function(d,i){
		      		reg = d.id;
      				d3.selectAll("path")
						.style("opacity", function(p) {
							if (p){
								if (p.properties){
									return p.properties.color == reg ? 1 : 0.3;
								}
							}
						})
					svg.selectAll("rect")
						.style("opacity", function(d) {
							return d.id == reg ? 1 : 0.3;
						})
				})
				.on("mouseout",function(d,i){
					d3.selectAll("path")
		      	    	.style("opacity", 1);
					d3.selectAll("rect")
		      			.style("opacity", 1); 
				});
				
			svg.append("text")
				.attr("x", 0)
				.attr("y", 0)
				.attr("dy", ".9em")
				.attr("font-weight", 600)
				.attr("font-size", "16px")
				.attr("fill", "black")
				.text("Total Patients in Region");

			legend.append("text")
				.attr("x", 5)
				.attr("y", 13.5)
				.attr("dy", "0.32em")
				.style("font-size", "18px")
				.attr("fill", "white")
				.text(function(d){return formatComma(d.cumulative).toString() ;})
				.on("mouseover",function(d,i){
		      		reg = d.id;
      				d3.selectAll("path")
						.style("opacity", function(p) {
							if (p){
								if (p.properties){
									return p.properties.color == reg ? 1 : 0.3;
								}
							}
						})
					svg.selectAll("rect")
						.style("opacity", function(d) {
							return d.id == reg ? 1 : 0.3;
						})
				})
				.on("mouseout",function(d,i){
					d3.selectAll("path")
		      	    	.style("opacity", 1);
					d3.selectAll("rect")
		      			.style("opacity", 1); 
				});
		
			legend.append("text")
				.attr("x", 80)
				.attr("y", 13.5)
				.attr("dy", "0.32em")
				.text(function(d) { return d.name;})
				.on("mouseover",function(d,i){
		      		reg = d.id;
      				d3.selectAll("path")
						.style("opacity", function(p) {
							if (p){
								if (p.properties){
									return p.properties.color == reg ? 1 : 0.3;
								}
							}
						})
					svg.selectAll("rect")
						.style("opacity", function(d) {
							return d.id == reg ? 1 : 0.3;
						})
				})
				.on("mouseout",function(d,i){
					d3.selectAll("path")
		      	    	.style("opacity", 1);
					d3.selectAll("rect")
		      			.style("opacity", 1); 
				});
			
			}
		});
	</script>
