<style type="text/css">
.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.y.axis path,
.y.axis line {
  display: none;
}

.x.axis path {
  stroke: #999;
}
</style>
<script>
var medicationSelector = [];
var phenotypeCategories = [];
var phenotypeMedications = new Map();
var cohortMedications = new Map();

function medicationsForPhenotype(phenotypeId) {
    buildPhenotypeMedicationData(phenotypeId)
}

function buildPhenotypeMedicationData(phenotypeId) {
    let medicationsFeedUrl = "feeds/phenotypes_medications.jsp";
    if (phenotypeId != 1) {
        medicationsFeedUrl += "?pid=" + phenotypeId;
    }

    $.getJSON(medicationsFeedUrl, (data) => {
        let json = $.parseJSON(JSON.stringify(data))
        phenotypeCategories = json['headers'];

        let headers = phenotypeCategories.map(item => item.value);
        let cohortMedicationsIn = json["rows"].filter(f => f.phenotype == "All Patients");
        cohortMedications = buildPhenotypeData(cohortMedicationsIn, headers);

        if (phenotypeId != 1) {
            let selectedPhenotype = $("${param.pe_selector} :selected").text();
            let phenotypeMedicationsIn = json["rows"].filter(f => f.phenotype == selectedPhenotype);

            phenotypeMedications = buildPhenotypeData(phenotypeMedicationsIn, headers);
        }

        medicationsDropDown(phenotypeId);
    });
}

function medicationsDropDown(phenotypeId) {
    // selectors
    let medicationsData = phenotypeId == 1 ? cohortMedications : phenotypeMedications;
    medicationsData.forEach(buildMedicationsDropDown);

    $("${param.med_selector}").select2({data: medicationSelector});
    chartForMedication($("${param.med_selector} :selected").val());
}

function buildMedicationsDropDown(medications, key) {
    medicationSelector.push({id: key, text: medications.name.replaceAll('_', ' ')});
}

function chartForMedication(medicationId) {
    let allMedications = [];
    let medicationsChartData = [];

    if (phenotypeMedications.size) {
        let currMedication = phenotypeMedications.get(medicationId);
        allMedications.push(currMedication);
    }

    let currMedicationAll = cohortMedications.get(medicationId);
    allMedications.push(currMedicationAll);

    phenotypeCategories.map(category => {
        let currObj = {}

        currObj["category"] = category.label
        currObj["values"] = [];

        allMedications.forEach(med => {
            let currKey = {}

            currKey["phenotype"] = med.phenotype;
            currKey["value"] = parseFloat(med[category.value]);
            currObj["values"].push(currKey);
        });

        medicationsChartData.push(currObj);
    });

    renderMedicationChart(medicationsChartData);
}

function renderMedicationChart(data) {
    // set the dimensions and margins of the graph
    //var margin = {top: 30, right: 100, bottom: 60, left: 100},
    var margin = {top: 70, right: 50, bottom: 35, left: 100},
    width = 900 - margin.left - margin.right,
    height = 600 - margin.top - margin.bottom;

    var x0 = d3.scaleBand().rangeRound([0, width]).padding(0.1);
    var x1 = d3.scaleBand().padding(0.1);
    var y = d3.scaleLinear().range([height, 0]);
    var xAxis = d3.axisBottom(x0).scale(x0).tickSize(0);
    var yAxis = d3.axisLeft(y).tickFormat((d) => { return d + "%" })

    // remove any existing svg
    d3.select("${param.med_chart_container}").select('svg').remove();

    // create the chart
    var svg = d3.select("${param.med_chart_container}").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    let categoriesNames = data.map((d) => { return d.category; });
    let phenotypes = data[0].values.map((d) => { return d.phenotype; });
    let subGroup = data.map((d) => { return d.values })
        .slice(data.length-1)
        .map((n) => { return n })[0]
        .map((i) => { return i.phenotype });

    var color = d3.scaleOrdinal()
        .domain(subGroup)
        .range(subGroup.length > 1 ? ["#4B8AC0", "#A76BAD"] : ["#4B8AC0"]);

    x0.domain(categoriesNames);
    x1.domain(phenotypes).rangeRound([0, x0.bandwidth()]);
    y.domain([0, d3.max(data, (category) => { return d3.max(category.values, (d) => { return d.value; }); })]);

    svg.append("g")
       .attr("class", "x axis")
       .attr("transform", "translate(0," + height + ")")
       .call(xAxis);

    svg.append("g")
       .attr("class", "y axis")
      //.style('opacity','0')
       .call(yAxis)
       .append("text")
       .attr("transform", "rotate(-90)")
       .attr("y", 6)
       .attr("dy", "-5.5em")
       .attr("dx", "-15.8em")
       .attr("letter-spacing", "0.3em")
       .attr("stroke", "black")
       .attr("text-anchor", "end")
      //.attr("font-weight", "bold")
       .attr("font-variant", "small-caps")
       .text("Percentage of Patients");

    svg.select('.y')
       .transition()
       .duration(500)
       .delay(1300)
       .style('opacity','1');

    var slice = svg.selectAll(".slice")
        .data(data)
        .enter().append("g")
        .attr("class", "g")
        .attr("transform", (d) => { return "translate(" + x0(d.category) + ",0)"; });

    slice.selectAll("rect")
         .data((d) => { return d.values; })
         .enter().append("rect")
         .attr("width", x1.bandwidth())
         .attr("x", (d) => { return x1(d.phenotype); })
         .style("fill", (d) => { return color(d.phenotype) })
         .attr("y", (d) => { return y(0); })
         .attr("height", (d) => { return height - y(0); })
         .on("mouseover", function(d) {
            d3.select(this).style("fill", d3.rgb(color(d.phenotype)).darker(2));
         })
         .on("mouseout", function(d) {
            d3.select(this).style("fill", color(d.phenotype));
         });

    slice.selectAll("rect")
         .transition()
         .delay((d) => {return Math.random()*1000;})
         .duration(1000)
         .attr("y", (d) => { return y(d.value); })
         .attr("height", (d) => { return height - y(d.value); });

    //Legend
    var legend = svg.selectAll(".legend")
         .data(data[0].values.map((d) => { return d.phenotype; }))
         .enter().append("g")
         .attr("class", "legend")
         .attr("transform", (d,i) => { return "translate(0," + i * 20 + ")"; })
         .style("opacity","0");

    legend.append("rect")
          .attr("x", width - 5)
          .attr("width", 18)
          .attr("height", 18)
          .style("fill", (d) => { return color(d); });

    legend.append("text")
          .attr("x", width - 24)
          .attr("y", 9)
          .attr("dy", ".35em")
          .attr("font-variant", "small-caps")
          .style("text-anchor", "end")
          .text(function(d) {return d; });

      legend.transition()
            .duration(500)
            .delay((d,i) => { return 1300 + 100 * i; })
            .style("opacity","1");
}

$("${param.med_selector}").on('select2:select', (e) => {
    let data = e.params.data;

    chartForMedication(data.id);
});
</script>