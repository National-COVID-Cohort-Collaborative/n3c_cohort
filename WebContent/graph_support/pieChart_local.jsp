<style>
chart {
	font: 10px sans-serif;
}

.arc path {
	stroke-width: 1px;
	stroke: #fff;
}
</style>

<script>

function localPieChart(data, domName) {
	var width = 325, //var width = parseInt(d3.select("${param.dom_element}").style("width"))-10,
		height = width,
		border = 10;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select(domName).select("svg").remove();
				//console.log('${param.dom_element} width '+newWidth);
				width = newWidth;
				height = newWidth;
				draw();
			}
		});
	});
	myObserver.observe(d3.select(domName).node());

	draw();

	function draw() {
		var formatComma = d3.format(",");
		var radius = Math.min(width - border, height - border) / 2;
		var color = d3.scaleOrdinal()
			.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

		var arc = d3.arc()
			.outerRadius(radius - 10)
			.innerRadius(0);

		var pie = d3.pie()
			.sort(null)
			.value(function(d) { return d.count; });

		var svg = d3.select(domName).append("svg")
			.attr("width", width)
			.attr("height", height)
			.append("g")
			.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

		data.forEach(function(d) {
			d.count = +d.count;
		});

		var g = svg.selectAll(".arc")
			.data(pie(data))
			.enter().append("g")
			.attr("class", "arc");

		var tooltip = d3.select(domName)
		.append('div')
		.attr('class', 'tooltip');


		tooltip.append('div')
		.attr('class', 'label');

		tooltip.append('div')
		.attr('class', 'count');

		tooltip.append('div')
		.attr('class', 'percent');

		var path = g.append("path")
			.attr("d", arc)
			.style("fill", function(d) { return color(d.data.element); });

		path.on('mouseover', function(d) {
			var total = d3.sum(data.map(function(d) {
				return d.count;
			}));

			var percent = Math.round(1000 * d.data.count / total) / 10;
			tooltip.select('.label').html(d.data.element).style('color','black').style("font-size", "14px");
			tooltip.select('.count').html(formatComma(d.data.count) + " patients");
			tooltip.select('.percent').html(percent + '% of category');

			tooltip.style('display', 'block');
			tooltip.style('opacity',2);

		});

		path.on('mousemove', function(d) {
			tooltip.style('top', (d3.event.layerY + 10) + 'px')
			.style('left', (d3.event.layerX - 25) + 'px');
		});

		path.on('mouseout', function() {
			tooltip.style('display', 'none');
			tooltip.style('opacity',0);
		});

		g.append("text")
			.attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
			.attr("dy", ".35em")
			.style("text-anchor", "middle")
			.text(function(d) { return d.data.element; });
	}
}

</script>