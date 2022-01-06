<script type="text/javascript">
	//Width and height of map
	var width = 960;
	var height = 500;

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
					height = width / 2;
					draw();
				}
			});
		});
		myObserver.observe(d3.select("${param.dom_element}").node());

		draw();

		function draw() {
			var legendText = ["Data Available", "Data transfer signed, pending availability"];
			var legendStatus = ["Yes", "No"];
			var legendLocation = [];
			var legendPosition = [];
			
			// D3 Projection 
			var projection = d3.geoAlbersUsa()
				.translate([width / 2, (height / 2)+20]) // translate to center of screen
				.scale([width]); // scale things down so see entire US

			// Define path generator
			var path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
				.projection(projection); // tell path generator to use albersUsa projection

			legendPosition.push(projection([-125.0, 20.0]));
			legendPosition.push(projection([-125.0, 25.0]));

			var svg = d3.select("${param.dom_element}")
				.append("svg")
				.attr("width", width)
				.attr("height", height+20);

			// Color Scale For Legend and Map 
			var color = d3.scaleOrdinal() 
				.domain(["available", "submitted", "pending"])
				.range(["#6b486b", "#bce4d8", "#bce4d8"]);

			var stroke = d3.scaleOrdinal() 
				.domain(["available", "submitted", "pending"])
				.range(["#fff", "#6b486b", "#6b486b"]);

			var dataArray = [];

			var states = data.states;

			for (var d = 0; d < states.length; d++) {
				dataArray.push(parseFloat(states[d].count))
			}

			// Load GeoJSON data and merge with cohort data
			d3.json("${param.state_page}", function(json) {

				// Loop through each state data value in the json array
				for (var i = 0; i < states.length; i++) {
					var dataState = states[i].name;
					var dataValue = states[i].count;
					var dataRegion = states[i].region;
					// Find the corresponding state inside the GeoJSON
					for (var j = 0; j < json.features.length; j++) {
						var jsonState = json.features[j].properties.name;
						if (dataState == jsonState) {
							// Copy the data value into the JSON
							json.features[j].properties.value = dataValue;
							json.features[j].properties.color = dataRegion;
							break;
						}
					}
				}

				// Bind the data to the SVG and create one path per GeoJSON feature
				svg.selectAll("path")
					.data(json.features)
					.enter()
					.append("path")
					.attr("d", path)
					.style("stroke", "#fff")
					.style("stroke-width", "1")
					.style("fill", "#bce4d8");
				
				d3.json("feeds/ochinLocations.jsp", function(graph) {
					var locationBySite = [],
						positions = [];
	
					var sites = graph.sites.filter(function(site) {
						var location = [site.longitude, site.latitude];
						locationBySite[site.id] = projection(location);
						positions.push(projection(location));
						return true;
					});
	
					var tool_tip = d3.tip()
						.attr("class", "d3-tip")
						.offset([-8, 0])
						.html(function(d) { return d.site + status_label(d.status); });
					svg.call(tool_tip);
	
					svg.selectAll("path")
						.data(sites)
						.enter().append("path")
    				.attr("d", function(d) {return d3.symbol().type(d3.symbolDiamond).size("20")()})
					.attr("transform", function(d, i) {return "translate("+positions[i][0]+", "+positions[i][1]+")";})
      				.attr("stroke", stroke("No"))
      				.attr("fill",color("No"));
				});

				d3.json("${param.site_page}", function(graph) {
					var locationBySite = [],
						positions = [];
	
					var sites = graph.sites.filter(function(site) {
						var location = [site.longitude, site.latitude];
						locationBySite[site.id] = projection(location);
						positions.push(projection(location));
						return true;
					});
	
					var tool_tip = d3.tip()
						.attr("class", "d3-tip")
						.offset([-8, 0])
						.html(function(d) { return d.site + org_label(d.data_model) + status_label(d.status); });
					svg.call(tool_tip);
	
					svg.selectAll("circle")
						.data(sites)
						.enter().append("svg:circle")
						.style("stroke", function(d) { return stroke(d.status); })
						.style("stroke-width", "1")
						.style("fill", function(d) { return color(d.status); })
						//.on("click", function(d) { window.open(d.url, "_self"); })
						.attr("cx", function(d, i) { return positions[i][0]; })
						.attr("cy", function(d, i) { return positions[i][1]; })
						.attr("r", function(d, i) { return 4; })
						.on("mouseover", tool_tip.show)
						.on("mouseout", tool_tip.hide);
				});

				svg.append("circle")
					.attr("cx", 5)
					.attr("cy",8)
					.attr("r", 4)
					.style("stroke", stroke("Yes"))
					.style("fill", color("Yes"))
				svg.append("circle")
					.attr("cx", 5)
					.attr("cy",20)
					.attr("r", 4)
					.style("stroke", stroke("No"))
					.style("fill", "#fff")
				svg.append("path")
    				.attr("d", function(d) {return d3.symbol().type(d3.symbolDiamond).size("20")()})
					.attr("transform", function(d, index) {return "translate(5, 32)";})
      				.attr("stroke", "black")
      				.attr("fill", "#fff")
 				svg.append("text").attr("x", 15).attr("y", 8).text("Data Available").style("font-size", "12px").attr("alignment-baseline","middle")
				svg.append("text").attr("x", 15).attr("y", 20).text("Data transfer signed, pending availability").style("font-size", "12px").attr("alignment-baseline","middle")
				svg.append("text").attr("x", 15).attr("y", 32).text("OCHIN contributing site").style("font-size", "12px").attr("alignment-baseline","middle")
			});
		};
	});

	function org_label(x) {
		return "<br>"+x;
	}

	function status_label(x) {
		return "<br>"+x;
	}

</script>

