<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


    <style>
        .text-hosp div.tabulator-col-title{
            color: #003f5c !important;
        }
        .text-non-hosp div.tabulator-col-title{
            color: #995196 !important;
        }
        .text-all div.tabulator-col-title{
            color: #DD5181 !important;
        }
        .tabulator-cell{
            padding: 1px !important;
        }
        .tabulator-cell:first-child{
            padding: 1px 10px !important;
        }
        .tabulator-col-title{
            color: #444E86;
            text-align: center;
        }
 
 		.tooltip-inner.override{
 			max-width: 200px;
    		padding: 0px;
    		color: inherit;
    		text-align: center;
    		background-color: inherit;
    		border-radius: 0px;
 		}
 


    </style>

    <div class="p-2">
        <div class="d-flex justify-content-center">
            <div class="col-md-6 text-center p-1">
                <small class="text-muted m-0 d-block">How to read these plots</small>
                <svg version="1.1"
                width="150"
                 id="Layer_1" x="0px" y="0px"
                    viewBox="0 0 42.7 10.4" style="enable-background:new 0 0 42.7 10.4;" xml:space="preserve">
                <style type="text/css">
                    .st0{fill:#808080;}
                    .st1{fill:#EFEFEF;}
                    .st2{fill:#995196;}
                    .st3{fill:#DDDDDD;}
                    .info:hover{fill:rgb(250, 116, 116) !important;}
                </style>
                <rect 
                data-toggle="tooltip" 
                data-placement="top" 
                title="Odd Ratio" 
                id="odds" x="21" y="0" class="st0 info" width="0.7" height="10.4"/>
                <g id="left" data-toggle="tooltip" 
                data-placement="bottom" 
                title="Decreased risk of condition">
                    <rect class="st1" width="21" height="10.4"/>
                    <rect x="5.8" y="5.2"
                    data-toggle="tooltip" 
                    data-placement="top" 
                    title="95% confidence interval" class="st0 info" width="9.7" height="0.5"/>
                    <circle class="st2 info" data-toggle="tooltip" 
                    data-placement="top" 
                    title="Estimated risk factor" cx="10" cy="5.4" r="1.5"/>
                </g>
                <g id="right" data-toggle="tooltip" 
                data-placement="bottom" 
                title="Increased risk of condition">
                    <rect x="21.6" class="st3" width="21" height="10.4"/>
                    <rect x="27.1" y="4.9" class="st0 info" data-toggle="tooltip" 
                    data-placement="top" 
                    title="95% confidence interval" width="9.7" height="0.5"/>
                    <circle class="st2 info" data-toggle="tooltip" 
                    data-placement="top" 
                    title="Estimated risk factor" cx="34.2" cy="5.2" r="1.5"/>
                </g>
                </svg>
            </div>
        </div>
        <div id="fig4"></div>
    </div>
    
    <script type="text/javascript">

        var d3_hor_bar = function(cell, formatterParams, onRendered){
            let v = cell.getValue()
            let max = formatterParams.max
            let percentage = (v * 100) / max;
            // console.log(`${v} of ${max} = ${percentage}`)
            if (cell.getValue() !== "*") {
                var width = 100;
                var height = 20;

                var svg = d3.create('svg');
                //Create SVG element
                svg.attr("width", width)
                .attr("height", height)

                //percentage bar
                svg.append("rect")
                    .attr("x", 0)
                    .attr("y", 0)
                    .attr("width", percentage)
                    .attr("height", height)
                    .attr('fill', formatterParams.color)
                    .attr('data-toggle', "tooltip")
                    .attr('data-placement',"top")
                    .attr('title', cell.getValue())

                return svg.node()
            } else {
                return "<p class='text-center m-0'><i data-toggle='tooltip' title='data not in top 20'>~</i></p>"
            }
        }

        var d3_dot = function(cell, formatterParams, onRendered){
            let v = cell.getValue()
            

            if (!v.includes('see discussion')) {
                var width = 150;
                var height = 20;

                var svg = d3.create('svg');
                //Create SVG element
                svg.attr("width", width)
                .attr("height", height)

                if (v.length) {
                    
                    // Create scale
                    var x = d3.scaleLinear()
                        .domain([-v[3], v[3]])
                        .range([ 0, width]);

                    //middle line
                    svg.append("rect")
                    .attr("x", x(1))
                    .attr("y", 0)
                    .attr("width", 1)
                    .attr("height", height)
                    .attr('fill', formatterParams.color)
                    .attr('data-toggle', "tooltip")
                    .attr('data-placement',"top")
                    .attr('title', "1")

                    svg.append("g")
                        .attr("transform", "translate(0," + height/2 + ")")
                        .call(d3.axisBottom(x).ticks(0))

                    svg.append("line")
                        .attr("x1", function(d) { return x(v[1]); })
                        .attr("x2", function(d) { return x(v[2]); })
                        .attr("y1", height/2)
                        .attr("y2", height/2)
                        .attr("stroke", "gray")
                        .attr("stroke-width", "3px")

                    svg.append("circle")
                        .attr("cx", function(d) { return x(v[0]) })
                        .attr("cy", function(d) { return height; })
                        .attr("cy", height/2)
                        .attr("r", 4)
                        .attr('fill', formatterParams.color)
                        .attr('data-toggle', "tooltip")
                        .attr('data-placement',"top")
                        .attr('title', `\${v[0]} (\${v[1]} - \${v[2]})`)
                    //hide domain x-axis
                    d3.selectAll("path.domain")
                        .style("stroke","transparent");
                }
                return svg.node()
            } else {
                return "<p style='color:" + formatterParams.color + "' class='text-center m-0'><small><i>see discussion</i></small></p>"
            }
        }

        let tableData = []
        let hospMax, nonHospMax, allMax;

        function draw(){
            var table = new Tabulator("#fig4", {
            // height:"500px",
            data: tableData,
            layout: "fitDataTable",
            selectable:true, //make rows selectable
            addRowPos:"top",//when adding a new row, add it to the top of the table
            movableColumns:false,
            resizableRows:false,
            initialSort:[ 
                //set the initial sort order of the data
                {column:"nonhosp_importance", dir:"desc"},
            ],
            columns:[ 
                {
                    title:"Feature", 
                    field:"feature", 
                    frozen:true,
                    formatter: function(cell){
                        cell.getElement().style.fontWeight = 'bold';
                        return cell.getValue()
                    },
                    vertAlign:"middle"
                },
                {
                    title:'Qualifying Non-hospitalized Patients',
                    cssClass:"text-non-hosp",
                    columns:[
                        {
                            title:"Importance", 
                            field:"nonhosp_importance", 
                            sorter: 'number',
                            formatterParams:{
                                color: function(value){
                                    if(value !== "*"){
                                        return '#995196'
                                    }
                                },
                                max: nonHospMax
                            },
                            formatter: d3_hor_bar
                        },
                        {
                            title:"Odds Ratio (95% CI)", 
                            field:"nonhosp_odds_box",
                            formatter: d3_dot,
                            formatterParams:{
                                color:'#995196',
                            },
                            // headerSort:false
                            sorter:function(a, b, aRow, bRow, column, dir, sorterParams){
                                //you must return the difference between the two values
                                return a[0] - b[0];
                            },
                        },
                    ]
                },
                {   
                    title:'Qualifying Hospitalized Patients', 
                    cssClass:"text-hosp",
                    columns:[
                        {
                            title:"Importance", 
                            field:"hosp_importance",
                            sorter: 'number',
                            formatterParams:{
                                color: function(value){
                                    if(value !== "*"){
                                        return '#003f5c'
                                    }
                                },
                                max: hospMax
                            },
                            formatter: d3_hor_bar
                        },
                        {
                            title:"Odds Ratio (95% CI)", 
                            field:"hosp_odds_box",
                            formatter: d3_dot,
                            formatterParams:{
                                color:'#003f5c',
                            },
                            // headerSort:false
                            sorter:function(a, b, aRow, bRow, column, dir, sorterParams){
                                //you must return the difference between the two values
                                return a[0] - b[0];
                            },
                        },
                    ]
                },
                {   
                    title:'All Qualifying Patients',
                    cssClass:"text-all",
                    columns:[
                        {
                            title:"Importance", 
                            field:"all_importance",
                            sorter: 'number',
                            formatterParams:{
                                color: function(value){
                                    if(value !== "*"){
                                        return '#DD5181'
                                    }
                                },
                                max: allMax
                            },
                            formatter: d3_hor_bar
                        },
                        {
                            title:"Odds Ratio (95% CI)", 
                            field:"all_odds_box",
                            formatter: d3_dot,
                            formatterParams:{
                                color:'#DD5181',
                            },
                            // headerSort:false
                            sorter:function(a, b, aRow, bRow, column, dir, sorterParams){
                                //you must return the difference between the two values
                                return a[0] - b[0];
                            },
                        },
                    ]
                }
                
            ],
        });
        }
        // axios.get('https://labs.cd2h.org/n3c-cohort/feeds/long_covid_summary.jsp').then(res=>{
        axios.get('<util:applicationRoot/>/long_covid_downloads/data.json').then(res=>{
            //get box figure boundaries
            let boxConfig ={};
            //collect all numbers of 
            let nonHospOddsNumbers = [];
            let HospOddsNumbers = [];
            let allOddsNumbers = [];
            //prep data
            let data = res.data.map(function(o) { 
                //Non Hosp Odds Plot Points
                o.nonhosp_odds_box = [];
                if (o.nonhospodds_ratio__95__ci_ !== null) {
                    if (o.nonhospodds_ratio__95__ci_ == 'see discussion') {
                        o.nonhosp_odds_box.push('see discussion');
                    }else{
                        // data looks like "5.59 (4.98 - 6.28)"
                        let v = o.nonhospodds_ratio__95__ci_.replace(/[()]/g, '').replace(' - ', ' ');
                        //[5.59, 4.98, 6.28]
                        let parts = v.split(' ').map(n => parseFloat(n));
                        parts.forEach(n => {
                            o.nonhosp_odds_box.push(n);
                            nonHospOddsNumbers.push(n);
                        })
                    }
                }
                //Hosp Odds Plot Points
                o.hosp_odds_box = [];
                if (o.hosp_odds_ratio__95__ci_ !== null) {
                    if (o.hosp_odds_ratio__95__ci_ == 'see discussion') {
                        o.hosp_odds_box.push('see discussion');
                    } else {
                        // data looks like "5.59 (4.98 - 6.28)"
                        let v = o.hosp_odds_ratio__95__ci_.replace(/[()]/g, '').replace(' - ', ' ');
                        //[5.59, 4.98, 6.28]
                        let parts = v.split(' ').map(n => parseFloat(n));
                        parts.forEach(n => {
                            o.hosp_odds_box.push(n);
                            HospOddsNumbers.push(n);
                        })
                    }
                    
                }
                //All Odds Plot Points
                o.all_odds_box = [];
                if (o.all_odds_ratio__95__ci_ !== null) {
                    if (o.all_odds_ratio__95__ci_ == 'see discussion') {
                        o.all_odds_box.push('see discussion');
                    } else {
                        // data looks like "5.59 (4.98 - 6.28)"
                        let v = o.all_odds_ratio__95__ci_.replace(/[()]/g, '').replace(' - ', ' ');
                        //[5.59, 4.98, 6.28]
                        let parts = v.split(' ').map(n => parseFloat(n));
                        parts.forEach(n => {
                            o.all_odds_box.push(n);
                            allOddsNumbers.push(n);
                        })
                    }
                }
                //return new object with new fields
                return o
            });

            boxConfig['nonhospodds_ratio__95__ci_']= {max: 0, min: 0}
            boxConfig['nonhospodds_ratio__95__ci_'].max = Math.max.apply(Math, nonHospOddsNumbers)
            boxConfig['nonhospodds_ratio__95__ci_'].min = Math.min.apply(Math, nonHospOddsNumbers)

            boxConfig['hosp_odds_ratio__95__ci_']= {max: 0, min: 0}
            boxConfig['hosp_odds_ratio__95__ci_'].max = Math.max.apply(Math, HospOddsNumbers)
            boxConfig['hosp_odds_ratio__95__ci_'].min = Math.min.apply(Math, HospOddsNumbers)

            boxConfig['all_odds_ratio__95__ci_']= {max: 0, min: 0}
            boxConfig['all_odds_ratio__95__ci_'].max = Math.max.apply(Math, allOddsNumbers)
            boxConfig['all_odds_ratio__95__ci_'].min = Math.min.apply(Math, allOddsNumbers)
            // console.log('nonHospOddsNumbers', nonHospOddsNumbers)
            // console.log('CONFIG', JSON.stringify(boxConfig, null, 2))

            tableData = data.map((obj) => {
                
                //remove all commas
                if(Object.hasOwnProperty.call(obj, 'all_importance')){
                    obj.all_importance = obj.all_importance.replace(/,/g, '');
                }
                if(Object.hasOwnProperty.call(obj, 'nonhosp_importance')){
                    obj.nonhosp_importance = obj.nonhosp_importance.replace(/,/g, '')
                }
                if(Object.hasOwnProperty.call(obj, 'hosp_importance')){
                    obj.hosp_importance = obj.hosp_importance.replace(/,/g, '');
                }
                //add box plot max and min
                if (obj && obj.nonhosp_odds_box.length) {
                    if (obj && boxConfig['nonhospodds_ratio__95__ci_']) {
                        obj.nonhosp_odds_box.push(boxConfig['nonhospodds_ratio__95__ci_'].max)
                    }
                }
                if (obj && obj.hosp_odds_box.length) {
                    if (obj && boxConfig['hosp_odds_ratio__95__ci_']) {
                        obj.hosp_odds_box.push(boxConfig['hosp_odds_ratio__95__ci_'].max)
                    }
                }
                if (obj && obj.all_odds_box.length) {
                    if (obj && boxConfig['all_odds_ratio__95__ci_']) {
                        obj.all_odds_box.push(boxConfig['all_odds_ratio__95__ci_'].max)
                    }
                }
                return obj
            })
            //remove * values, then get max for bars
            nonHospMax = Math.max.apply(Math, data.map(function(o) { return o.nonhosp_importance }).filter((value) => value !== '*'))
            hospMax = Math.max.apply(Math, data.map(function(o) { return o.hosp_importance }).filter((value) => value !== '*'))
            allMax = Math.max.apply(Math, data.map(function(o) { return o.all_importance }).filter((value) => value !== '*'))
            draw();
        }).catch(err=> {
            throw err;
        });

        //give enough time to render before initializing tooltips
        setTimeout(function(){
            $(function () {
                $('[data-toggle="tooltip"]').tooltip({
                    container: 'body',
                    template: '<div class="tooltip" role="tooltip"><div class="tooltip-inner override"></div></div>'
                })
            })
        }, 1000)        
    </script>
