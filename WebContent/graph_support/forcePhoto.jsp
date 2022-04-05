<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

.link {
	stroke: #c1c1c1;
    stroke-width: 1px;
    pointer-events: all;
	}

.node circle {
	pointer-events: all;
	stroke: #777;
	stroke-width: 1px;
	}
  
  
div.tooltip {
    position: absolute;
    background-color: white;
    max-width; 200px;
    height: auto;
    padding: 1px;
    border-style: solid;
    border-radius: 4px;
    border-width: 1px;
    box-shadow: 3px 3px 10px rgba(0, 0, 0, .5);
    pointer-events: none;
  }

</style>

<script>
!(function(){
    "use strict"

    var width,height
    var chartWidth, chartHeight
    var margin
    var svg = d3.select("#${param.target}").append("svg")
    var chartLayer = svg.append("g").classed("chartLayer", true)
    var simulation
    var forceCenter
    var graph
    
	var colorScale = d3.scaleOrdinal()
		.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
		.range(d3.schemeCategory10)

	var tooltip = d3.select("body")
		.append("div")
		.attr("class", "tooltip")
		.style("opacity", 0);

    main()
    
    function main() {
        var range = 10
        var data = {
            nodes:d3.range(0, range).map(function(d){ return {label: "l"+d ,r:~~d3.randomUniform(8, 28)()}}),
            links:d3.range(0, range).map(function(){ return {source:~~d3.randomUniform(range)(), target:~~d3.randomUniform(range)()} })        
        }

        var myObserver = new ResizeObserver(entries => {
    		entries.forEach(entry => {
    			var newWidth = Math.floor(entry.contentRect.width);
   				//console.log(newWidth);
   				setSize(newWidth);
    		});
    	});
    	myObserver.observe(d3.select("#content").node());

    	setSize(900)
        
        d3.json("${param.data_page}", function(error, theGraph) {
        	graph = theGraph;
            drawChart(graph)
        });
    }
    
    function setSize(newWidth) {
        width = newWidth; //document.querySelector("#collaboration_graph").clientWidth
        height = newWidth; //document.querySelector("#collaboration_graph").clientHeight
        margin = {top:0, left:0, bottom:0, right:0 }
        
        chartWidth = width - (margin.left+margin.right)
        chartHeight = height - (margin.top+margin.bottom)
        
        svg.attr("width", width).attr("height", height)
        
        
        chartLayer
            .attr("width", chartWidth)
            .attr("height", chartHeight)
            .attr("transform", "translate("+[margin.left, margin.top]+")")
            
        if (forceCenter != null) {
        	forceCenter.x(chartWidth / 2)
        	forceCenter.y(chartHeight / 2)
        	simulation.restart()
        }
    }
    
    function drawChart(data) {
        forceCenter = d3.forceCenter(chartWidth / 2, chartHeight / 2)
        simulation = d3.forceSimulation()
            .force("link", d3.forceLink().id(function(d) { return d.index }))
            .force("collide",d3.forceCollide( function(d){return d.score + 8 }).iterations(16) )
            .force("charge", d3.forceManyBody())
            .force("center", forceCenter)
            .force("y", d3.forceY(0))
            .force("x", d3.forceX(0))
    		
        var link = svg.append("g")
            .attr("class", "links")
            .selectAll("line")
            .data(data.links)
            .enter()
            .append("line")
        
		link  
		    .attr('class', 'link')
		  	.on('mouseover.tooltip', function(d) {
		      	tooltip.transition()
		        	.duration(300)
		        	.style("opacity", .8);
		      	tooltip.html("Source:"+ d.source.name + 
		                     "<p/>Target:" + d.target.name +
		                    "<p/>Strength:"  + d.value)
		        	.style("left", (d3.event.pageX) + "px")
		        	.style("top", (d3.event.pageY + 10) + "px");
		    	})
		    	.on("mouseout.tooltip", function() {
			      tooltip.transition()
			        .duration(100)
			        .style("opacity", 0);
			    })
		  		.on('mouseout.fade', fade(1))
			    .on("mousemove", function() {
			      tooltip.style("left", (d3.event.pageX) + "px")
			        .style("top", (d3.event.pageY + 10) + "px");
			    });
		;

		var node = svg.append("g")
            .attr("class", "nodes")
            .selectAll("circle")
            .data(data.nodes)
            .enter().append("circle")
            .attr("r", function(d){  return d.score })
            .attr("fill", function(d) { return colorScale(d.group);})
			.on('mouseover.tooltip', function(d) {
      			tooltip.transition()
        			.duration(300)
        			.style("opacity", .8);
      			tooltip.html((d.group == 'N3C' ? d.url+" - " : "") + d.name)
        			.style("left", (d3.event.pageX) + "px")
        			.style("top", (d3.event.pageY + 10) + "px");
    			})
		  	.on('mouseover.fade', fade(0.1))
    		.on("mouseout.tooltip", function() {
        		tooltip.transition()
	        		.duration(100)
	        		.style("opacity", 0);
	    		})
			.on('mouseout.fade', fade(1))
			.call(d3.drag()
                .on("start", dragstarted)
                .on("drag", dragged)
                .on("end", dragended));    
        
        var ticked = function() {
            link
                .attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });
    
            node
                .attr("cx", function(d) { return d.x = Math.max(4, Math.min(width - d.score, d.x)); })
                .attr("cy", function(d) { return d.y = Math.max(4, Math.min(height - d.score, d.y)); });
        }  
        
        <c:if test="${not empty param.legend_div}">
	        drawColorKey(data.sites)
        </c:if>

        simulation
            .nodes(data.nodes)
            .on("tick", ticked);
    
        simulation.force("link")
            .links(data.links);    
        
        
        
        function dragstarted(d) {
            if (!d3.event.active) simulation.alphaTarget(0.3).restart();
            d.fx = d.x;
            d.fy = d.y;
        }
        
        function dragged(d) {
            d.fx = d3.event.x;
            d.fy = d3.event.y;
        }
        
        function dragended(d) {
            if (!d3.event.active) simulation.alphaTarget(0);
            d.fx = null;
            d.fy = null;
        } 

        const linkedByIndex = {};
        graph.links.forEach(d => {
          linkedByIndex[d.source.index + "," + d.target.index] = 1;
        });

        function isConnected(a, b) {
          return linkedByIndex[a.index + "," + b.index] || linkedByIndex[b.index + "," +a.index] || a.index === b.index;
        }

        function fade(opacity) {
          return d => {
            node.style('stroke-opacity', function (o) {
              const thisOpacity = isConnected(d, o) ? 1 : opacity;
              this.setAttribute('fill-opacity', thisOpacity);
              return thisOpacity;
            });

            link.style('stroke-opacity', o => (o.source === d || o.target === d ? 1 : opacity));

          };
        }
                
        function drawColorKey(legendData) {
        	var w = 120;
        	var h = 200;
        	var k = 0;
        	
        	var svg3 = d3.select("#${param.legend_div}")
        		.append("svg")
        		.attr("width", w)
        		.attr("height", h);
        	
        	svg3.selectAll("node")
        		.data(legendData)
         	   .enter().append("circle")
            	.attr("class", "node")
        		.attr("r", 5)
        		.attr("x", 10)
        		.attr("y", function(d,k) { return 10+(16*k); k++;} )
        		.attr("transform", function(d,k) { return "translate(" + 20 + "," + (16+16*k) + ")"; k++;})
        	   	.style("fill", function (d,k) { return colorScale(legendData[k].id);});
        		
        	svg3.selectAll("text")
        		.data(legendData)
        		.enter()
        		.append("text")
        		.text (function (d) { return d.label; })
        		.attr("x", 30)
        		.attr("y", function(d, k) { return 23+(16*k); k++; });
        }
    }
}());
</script>    
