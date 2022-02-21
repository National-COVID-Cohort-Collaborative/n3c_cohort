<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.axis .domain {
	display: none;
}
</style>
<script>

d3.json("${param.data_page}", function(error, data) {
	if (error) throw error;
  
	var margin = {top: 40, right: 100, bottom: 60, left: 250},
		width = 1200 - margin.left - margin.right,
		height = 500 - margin.top - margin.bottom;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("${param.dom_element}").select("svg").remove();
				width = newWidth - margin.left - margin.right;
				if ((width*1.5 - margin.left - margin.right) > 200){
					height = width*1.5 - margin.left - margin.right;
				} else { 
					height = 200;
				}
				draw();
			}
		});
	});
	
	myObserver.observe(d3.select("${param.dom_element}").node());
	
	draw();
	
	function draw() {
		var svg = d3.select("${param.dom_element}").append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom);
		g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		var y0 = d3.scaleBand()
			.rangeRound([height, 0])
			.paddingInner(0.1);

		var y1 = d3.scaleBand()
			.padding(0.05);

		var x = d3.scaleLinear()
			.rangeRound([0, width]);

		var x1 = d3.scaleBand()

		var z = d3.scaleOrdinal()
			.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

		data.forEach(function(d){
    		d.${param.count} = +d.${param.count};
		})
  
		console.log("data", data);
  
		y0.domain(data.map(function(d) { return d.${param.primary_group}; }));
		y1.domain(data.map(function(d) { return d.${param.secondary_group}; }))
			.rangeRound([0, y0.bandwidth()])
			.padding(0.2);
  
		z.domain(data.map(function(d) { return d.${param.stack_group}; }))
		var keys = z.domain().sort();
		var stringToFilter = '<18';
		keys.unshift(keys.splice(keys.findIndex(item => item.id === stringToFilter), 1)[0])

		console.log("keys", keys)
  
		var groupData = d3.nest()
			.key(function(d) { return d.${param.secondary_group} + d.${param.primary_group}; })
			.rollup(function(d, i){
      
		var d2 = {${param.secondary_group}: d[0].${param.secondary_group}, ${param.primary_group}: d[0].${param.primary_group}, total: 0}
		d.forEach(function(d){
			d2[d.${param.stack_group}] = d.${param.count}
			d2.total += d.${param.count}
		})
		console.log("rollup d", d, d2);
		return d2;
		})
		.entries(data)
		.map(function(d){ return d.value; });
  
		console.log("groupData", groupData)
  
		var stackData = d3.stack()
			.keys(keys)(groupData)
  
		console.log("stackData", stackData)
  
		x.domain([0, d3.max(groupData, function(d) { return d.total; })]).nice();

		console.log("y", d3.max(groupData, function(d) { return d.total; }))
		 
		var tooltip = svg.append("g")
		    .attr("class", "tooltip")
		    .style("display", "none");
		      
		tooltip.append("rect")
		    .attr("width", 60)
		    .attr("height", 20)
		    .attr("fill", "white")
		    .style("opacity", 0.5);

		tooltip.append("text")
		    .attr("x", 30)
		    .attr("dy", "1.2em")
		    .style("text-anchor", "middle")
		    .attr("font-size", "12px")
		    .attr("font-weight", "bold");
  
		var serie = g.selectAll(".serie")
			.data(stackData)
			.enter().append("g")
			.attr("class", "serie")
			.attr("fill", function(d) { return z(d.key); });
  
		serie.selectAll("rect")
			.data(function(d) { return d; })
			.enter().append("rect")
			.attr("class", "serie-rect")
			.attr("transform", function(d) { return "translate(0," + y0(d.data.${param.primary_group}) + ")"; })
			.attr("y", function(d) { return y1(d.data.${param.secondary_group}); })
			.attr("x", function(d) { return x(d[0]); })
			.attr("width", function(d) { return Math.max(1,x(d[1]) - x(d[0])); })
			.attr("height", y1.bandwidth())
			.on("click", function(d, i){ console.log("serie-rect click d", i, d); })
			.on("mouseover", function() { tooltip.style("display", null); })
			.on("mouseout", function() { tooltip.style("display", "none"); })
			.on("mousemove", function(d) {
				console.log(d);
				var xPosition = d3.mouse(this)[0] - 5;
				var yPosition = d3.mouse(this)[1] - 5;
				tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
				tooltip.select("text").text('x');
			})
			;

	    g.append("g")
			.attr("class", "axis")
			.call(d3.axisLeft(y0));

		g.append("g")
			.attr("class", "axis")
			.call(d3.axisTop(x).ticks(null, "s"))
			.append("text")
			.attr("y", 2)
			.attr("x", x(x.ticks().pop()) + 0.5)
			.attr("dx", "0.32em")
			.attr("fill", "#000")
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.text("Patient Count");
  
		var legend = serie.append("g")
			.attr("class", "legend")
			.attr("transform", function(d) { var d = d[d.length - 1]; return "translate(" + ((x(d[0]) + x(d[1])) / 2) + "," + (y0(d.data.${param.primary_group}) + y1(d.data.gender_concept_name) + y1.bandwidth()) + ")"; });

		legend.append("line")
			.attr("y1", -6)
			.attr("y2", 6)
			.attr("stroke", "#000");

		legend.append("text")
			.attr("x", 0)
			.attr("dy", "1.5em")
			.attr("fill", "#000")
			.style("font", "10px sans-serif")
		    .style("text-anchor", "middle")
			.text(function(d) { return d.key; });
		}
	});

</script>
