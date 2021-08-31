<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>

d3.json("${param.data_page}", function(data) {

    var margin = {top: 0, right: 13, bottom: 20, left: 50};
    var width = 1400 - margin.left - margin.right;
    var height = 400 - margin.top - margin.bottom;
    <c:choose>
	<c:when test="${not empty param.maxValue}">
    var maxValue = ${param.maxValue};
	</c:when>
	<c:otherwise>
    var maxValue = d3.max(data, function(race) { return d3.max(race.values, function(d) { return d.sum; }); });
	</c:otherwise>
	</c:choose>
    
	const color = d3.scaleOrdinal().range(["#2d5985", "#8a89a6", "#bce4d8"]);
    
	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("${param.dom_element}").select("svg").remove();
				//console.log('${param.dom_element} width '+newWidth);
				width = newWidth - margin.left - margin.right;
				draw();
			}
		});
	});
	myObserver.observe(d3.select("${param.dom_element}").node());

	draw();

	function draw() {
    var svg = d3.select('${param.dom_element}').append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
		.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    
    var categoriesNames = data.map(function(d) { return d.abbrev; });
    var rateNames = data[0].values.map(function(d) { return d.ethnicity; });

   
    var x0 = d3.scaleSqrt()
    	.range([0, width])
    	.domain([1, maxValue]);
    
    var y0 = d3.scaleBand()
		.rangeRound([0, height])
		.domain(categoriesNames)
		.paddingInner(0.1);
    
    var y1 = d3.scaleBand()
    	.domain(rateNames)
    	.rangeRound([0, y0.bandwidth()])
    	.padding(0.05);
    
    
    
  
    
  
	var axis_label_list= [0, ((Math.round((maxValue * .05)/100000))*100000)/2, (Math.round((maxValue * .2)/100000))*100000, (Math.round((maxValue * .5)/100000))*100000, (Math.round((maxValue)/100000))*100000];
	
    var xAxis = d3.axisBottom(x0)
    	.ticks(5)
    	.tickFormat(d3.format(",.1s"))
    	//.tickSize(6, 0)
    	.tickValues(axis_label_list);
    	
    var yAxis = d3.axisLeft()
    	.tickValues(data.map(d=>d.abbrev))
    	.scale(y0);
    
    svg.append("g")
    	.attr("class", "x axis")
    	.attr("transform", "translate(0," + height + ")")
    	.call(xAxis)
    	.append("text")
    		.attr("transform", "rotate(-90)")
    		.attr("y", 6)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .style('font-weight','bold');

    svg.append("g")
    	.attr("class", "y axis")
    	.call(yAxis);

    var slice = svg.selectAll(".slice")
    	.data(data)
    	.enter().append("g")
    	.attr("class", "g")
    	.attr("transform",function(d) { return "translate(0," + y0(d.abbrev) + ")"; });

		slice.selectAll("rect")
			.data(function(d) { return d.values; })
			.enter().append("rect")
				.attr("height", y1.bandwidth())
				.attr("x", 0)
				.style("fill", function(d) { return color(d.ethnicity) })
				.attr("y", function(d) { return y1(d.ethnicity); })
      			.attr("width", function(d) { return x0(d.sum); });


      //Legend
	var legend = svg.selectAll(".legend")
		.data(data[0].values.map(function(d) { return d.ethnicity; }).reverse())
			.enter().append("g")
 			.attr("class", "legend")
			.attr("transform", function(d,i) { return "translate(0," + ((i * 20)+height*0.8) + ")"; })
			.style("opacity","1");

		legend.append("rect")
			.attr("x", width - 18)
			.attr("width", 18)
			.attr("height", 18)
			.style("fill", function(d) { return color(d); });

		legend.append("text")
			.attr("x", width - 24)
			.attr("y", 9)
			.attr("dy", ".35em")
			.style("text-anchor", "end")
			.text(function(d) {return d; });
	}
});

</script>