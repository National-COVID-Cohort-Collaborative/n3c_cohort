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

    .toolTip {
        position: absolute;
        display: none;
        height: auto;
        background: none repeat scroll 0 0 #182026;
        /*border: 1px solid #6F257F;*/
        color: #fff;
        font-weight: bold;
        padding: 10px;
        text-align: center;
        border-radius: 8px;
    }
</style>
<script>
    function chartForMedication(medication) {
        let medicationsChartData = [];
        let medAllGroupedData = [];
        let medicationsFeedUrl = "feeds/phenotypes_medications.jsp?name=" + medication;
        let medicationsAllPatientsUrl = "feeds/phenotypes_medications.jsp?name=Azithromycin";


        $.getJSON(medicationsAllPatientsUrl, (data) => {
                    let jsonall = $.parseJSON(JSON.stringify(data));
                    let medAllGrouped = dataGrouped(jsonall['rows']);
                    medAllGrouped.variable = medication;
                    medAllGrouped[0].variable = medication;
                    medAllGroupedData.push(medAllGrouped);

                    $.getJSON(medicationsFeedUrl, medAllGroupedData, (data) => {



                                let json = $.parseJSON(JSON.stringify(data))
                                let headers = json['headers'].map(item => item.value);

                                let medAllGrouped = medAllGroupedData[0];
                                let medTrueData = json['rows'].filter(row => row.value);
                                let medTrueGrouped = dataGrouped(medTrueData);
                                let medPercentage = dataPercentage(medAllGrouped, medTrueGrouped, headers);

                                json['headers'].map(category => {
                                    let currObj = {}

                                    currObj["category"] = category.label
                                    currObj["values"] = [];

                                    medPercentage.forEach(med => {
                                        let currKey = {}

                                        currKey["phenotype"] = med.variable.replaceAll('_',' ');
                                        currKey["value"] = parseFloat(med[category.value]).toFixed(3);
                                        currObj["values"].push(currKey); // each category properties
                                    });

                                    medicationsChartData.push(currObj); // each category
                                });

                                // renderMedicationChart(medicationsChartData);

                                const summaryData = {
                                    'medication': medication,
                                    'medData': medAllGrouped,
                                    'medTrueData': medTrueGrouped,
                                    'medPercentage': medPercentage,
                                    'headers': headers
                                }
                                renderMedicationSummary(summaryData);
                            });
                });

    }

    function renderMedicationSummary(data)
    {
        let headers = Object.assign([], data.headers);
        headers.push('unaffected');

        let medCohort = data.medData[0];
        let medSelected = data.medTrueData[0];

        let medCohortSum = sumObject(filterObject(medCohort, headers));
        let medSelectedSum = sumObject(filterObject(medSelected, headers));
        let medSelectedToCohortPercent = ((medSelectedSum/medCohortSum)*100).toFixed(1);
        $("#medName span").text(data.medication.replaceAll('_',' '));
        $("#medCount span").text(medSelectedSum.toLocaleString());

        let covidPositive = sumObject(filterObject(medSelected, data.headers));
        let covidPositiveCohort = sumObject(filterObject(medCohort, data.headers));
        $("#medCovidSummary span").text(covidPositive.toLocaleString());
        $("#medCovidSelectedStat").text(((covidPositive/medSelectedSum) * 100).toFixed(1));
        $("#medCovidCohortStat").text(((covidPositiveCohort/medCohortSum) * 100).toFixed(1));

        let hospitalized = sumObject(filterObject(medSelected, ["moderate", "severe", "dead_w_covid"]));
        let hospitalizedCohort = sumObject(filterObject(medCohort, ["moderate", "severe", "dead_w_covid"]));
        $("#medHospitalizedSummary span").text(hospitalized.toLocaleString());
        $("#medHospitalizedSelectedStat").text(((hospitalized/medSelectedSum) * 100).toFixed(1));
        $("#medHospitalizedCohortStat").text(((hospitalizedCohort/medCohortSum) * 100).toFixed(1));

        let death = sumObject(filterObject(medSelected, ["severe", "dead_w_covid"]));
        let deathCohort = sumObject(filterObject(medCohort, ["severe", "dead_w_covid"]));
        $("#medDeathSummary span").text(death.toLocaleString());
        $("#medDeathSelectedStat").text(((death/medSelectedSum) * 100).toFixed(1));
        $("#medDeathCohortStat").text(((deathCohort/medCohortSum) * 100).toFixed(1));
        $("#sMedName").text(data.medication.replaceAll('_',' '));
        $("#sMedTotalCohort").text(medSelectedSum.toLocaleString("en-US"));
        $("#sAllTotalCohort").text(medCohortSum.toLocaleString("en-US") + ' (' + medSelectedToCohortPercent + '%)');
        $("#sMedCovidPos").text(covidPositive.toLocaleString("en-US") + ' (' + ((covidPositive/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sAllCovidPos").text(covidPositiveCohort.toLocaleString("en-US") + ' (' + ((covidPositiveCohort/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedOutpatients").text(medSelected.mild.toLocaleString("en-US") + ' (' + ((medSelected.mild/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sMedOutpatientsToCPos").text(((medSelected.mild/covidPositive) * 100).toFixed(1) + ' % of C+');
        $("#sAllOutpatients").text(medCohort.mild.toLocaleString("en-US") + ' (' + ((medCohort.mild/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedEdVisit").text(medSelected.mild_ed.toLocaleString("en-US") + ' (' + ((medSelected.mild_ed/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sMedEdVisitToCPos").text(((medSelected.mild_ed/covidPositive) * 100).toFixed(1) + ' % of C+');
        $("#sAllEdVisit").text(medCohort.mild_ed.toLocaleString("en-US") + ' (' + ((medCohort.mild_ed/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedHostpitalized").text(medSelected.moderate.toLocaleString("en-US") + ' (' + ((medSelected.moderate/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sMedHostpitalizedToCPos").text(((medSelected.moderate/covidPositive) * 100).toFixed(1) + ' % of C+');
        $("#sAllHostpitalized").text(medCohort.moderate.toLocaleString("en-US") + ' (' + ((medCohort.moderate/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedICU").text(medSelected.severe.toLocaleString("en-US") + ' (' + ((medSelected.severe/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sMedICUToCPos").text(((medSelected.severe/covidPositive) * 100).toFixed(1) + ' % of C+');
        $("#sAllICU").text(medCohort.severe.toLocaleString("en-US") + ' (' + ((medCohort.severe/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedDeceased").text(medSelected.dead_w_covid.toLocaleString("en-US") + ' (' + ((medSelected.dead_w_covid/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sMedDeceasedToCPos").text(((medSelected.dead_w_covid/covidPositive) * 100).toFixed(1) + ' % of C+');
        $("#sAllDeceased").text(medCohort.dead_w_covid.toLocaleString("en-US") + ' (' + ((medCohort.dead_w_covid/medCohortSum) * 100).toFixed(1) + '%)');

        $("#sMedCovidNeg").text(medSelected.unaffected.toLocaleString("en-US") + ' (' + ((medSelected.unaffected/medSelectedSum) * 100).toFixed(1) + '%)');
        $("#sAllCovidNeg").text(medCohort.unaffected.toLocaleString("en-US") + ' (' + ((medCohort.unaffected/medCohortSum) * 100).toFixed(1) + '%)');

        $("#medSumTable").removeClass("hidden");
    }

    function renderMedicationChart(data) {
        // set the dimensions and margins of the graph
        //var margin = {top: 30, right: 100, bottom: 60, left: 100},
        var margin = {top: 70, right: 50, bottom: 35, left: 100},
            width = 900 - margin.left - margin.right,
            height = 600 - margin.top - margin.bottom;

        var x0 = d3.scaleBand().rangeRound([0, width]).padding(0.3);
        var x1 = d3.scaleBand().padding(0.3);
        var y = d3.scaleLinear().range([height, 0]);
        var xAxis = d3.axisBottom(x0).scale(x0).tickSize(0);
        var yAxis = d3.axisLeft(y).tickSize(10).tickFormat((d) => { return d + "%" })

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
            .range(["#4B8AC0", "#A76BAD"]);

        // tooltip
        var tooltip = d3.select("body")
            .append("div")
            .attr("class", "toolTip");

        x0.domain(categoriesNames);
        x1.domain(phenotypes).rangeRound([0, x0.bandwidth()]);
        y.domain([0, d3.max(data, (category) => {
            return d3.max(category.values, (d) => {
                return d.value;
            });
        })]);

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
            .on("mousemove", function(d){
                tooltip
                    .style("left", d3.event.pageX - 50 + "px")
                    .style("top", d3.event.pageY - 70 + "px")
                    .style("display", "inline-block")
                    .text(d.value + '%');
            })
            .on("mouseout", function(d) {
                d3.select(this).style("fill", color(d.phenotype));
                tooltip.style("display", "none");
            });

        slice.selectAll("rect")
            .transition()
            .delay((d) => {return Math.random()*1000;})
            .duration(1000)
            .attr("y", (d) => { return y(d.value); })
            .attr("height", (d) => { return height - y(d.value); });

        //Legend
        var legendContainer = svg.append('g')
            .attr('transform', "translate(" + (margin.left - 100) + ", -50)")

        var legend = legendContainer.selectAll(".legend")
            .data(data[0].values.map((d) => { return d.phenotype}))
            .enter().append("g")
            .attr("class", "legend")
            .attr("transform", (d,i) => { return "translate(0," + i * 20 + ")"; })
            .style("opacity","0");

        legend.append("rect")
            .attr("x", width - 15)
            .attr("width", 18)
            .attr("height", 18)
            .style("fill", (d) => { return color(d); });

        legend.append("text")
            .attr("x", width - 24)
            .attr("y", 9)
            .attr("dy", ".35em")
            .attr("font-variant", "capitalize")
            .style("text-anchor", "end")
            .text(function(d) {return d; });

        legend.transition()
            .duration(500)
            .delay((d,i) => { return 1300 + 100 * i; })
            .style("opacity","1");
    }

    // medication selection event handler
    $("${param.med_selector}").on('select2:select', (e) => {
        let data = e.params.data;

        chartForMedication(data.id);
    });

    let  medicationSelection = [];
    $.getJSON("feeds/medications.jsp", (data) => {
        let json = $.parseJSON(JSON.stringify(data));
        medicationSelection.push({'id':'default','text':'Please select a medication'});
        json.map((entry) => {
            let selectData = {};
            for (const [key, value] of Object.entries(entry)) {
                selectData["id"] = value;
                selectData["text"] = value.replaceAll('_', ' ');

                medicationSelection.push(selectData);
            }
        });

        $("${param.med_selector}").select2({data: medicationSelection});

        chartForMedication($("${param.pe_selector} :selected").val());
    });
</script>