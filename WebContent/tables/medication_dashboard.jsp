<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>

<style>
/*table.drilldown tbody td {
    border: 1px solid darkgoldenrod;
}
table.dataTable tbody td {
    border: 1px solid blue;
}*/
th.dt-center, td.dt-center {
  text-align: center;
}
@media only screen and (max-device-width: 2560px) {
  table.drilldown>tbody>tr>td.spacer {
    width: 35.7%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.5%;
    padding-right: 0.6%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 19.83%;
    padding-right: 0.5%;
  }
  table.drilldown>tbody>tr>td.covid-positive-hosp {
    width: 11.6%;
    padding-right: 0.6%;
  }
  table.drilldown>tbody>tr>td.covid-med8 {
    width: 14.5%;
    padding-right: 0.4%;
  }
}
@media only screen
 and (max-device-width: 1650px) {
  table.drilldown>tbody>tr>td.spacer {
    width: 36%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.6%;
    padding-left: 0.7%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 20%;
    padding-left: 0.6%;
  }
  table.drilldown>tbody>tr>td.covid-positive-hosp {
    width: 11.6%;
  }
  table.drilldown>tbody>tr>td.covid-med8.pad3 {
    padding-left: 1.2%;
  }
  table.drilldown>tbody>tr>td.covid-med8.pad5 {
    padding-left: 1.1%;
  }
}
@media only screen and (max-device-width: 1440px) {
  table.drilldown>tbody>tr>td.spacer {
    width: 36.4%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.6%;
    padding-left: 1%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 20%;
    padding-left: 1.3%;
  }
  table.drilldown>tbody>tr>td.covid-positive-hosp {
    width: 11.6%;
    padding-left: 1.3%;
  }
  table.drilldown>tbody>tr>td.covid-med8,
  table.drilldown>tbody>tr>td.covid-med8.pad3,
  table.drilldown>tbody>tr>td.covid-med8.pad5 {
    padding-left: 1.6% !important;
  }
}
@media only screen and (max-device-width: 1280px) {
  table.drilldown>tbody>tr>td.spacer {
    width: 36.9%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.6%;
    padding-right: 1.3%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 20%;
    padding-right: 1%;
  }
  table.drilldown>tbody>tr>td.covid-positive-hosp {
    width: 11.6%;
  }
  table.drilldown>tbody>tr>td.covid-med8,
  table.drilldown>tbody>tr>td.covid-med8.pad3,
  table.drilldown>tbody>tr>td.covid-med8.pad5 {
    padding-left: 2.3% !important;
    width: 13.5%;
  }
}
@media only screen and (max-device-width: 1152px) {
  table.drilldown>tbody>tr>td.spacer {
    width: 36%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.3%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 19.4%;
  }
  table.drilldown>tbody>tr>td.covid-positive-hosp {
    width: 11.5%;
  }
  table.drilldown>tbody>tr>td.covid-med8 {
    text-align: right;
  }
  table.drilldown>tbody>tr>td.covid-med8.pad5 {
      padding-right: 3.2%;
  }
  table.drilldown>tbody>tr>td.covid-med8.pad3 {
      padding-right: 3.6%;
  }
}
@media only screen and (max-device-width: 800px) {
 table.drilldown>tbody>tr>td.spacer {
    width: 36%;
  }
  table.drilldown>tbody>tr>td.covid-positive {
    width: 14.6%;
  }
  table.drilldown>tbody>tr>td.covid-positive-7d {
    width: 14.7%;
  }
}
</style>
<script>
function format ( d ) {
    // `d` is the original data object for the row

    if(jQuery.isEmptyObject(d.age))
        return '<table style="width:100%"><tr><td class="dt-center">no additional data available for '+d.name+'</td></tr></table>';

    let dropTable = '<table class="drilldown" style="width:100%">';

    d.age.forEach((count, i) => {

        // calculate "all hospitalized and not diff"
        let med8DrillDown = 'N/A';
        if (!isNaN(parseInt(count.ct_covid_positive))
         && !isNaN(parseInt(count.ct_covid_positive_7d))
          && !isNaN(parseInt(count.ct_covid_positive_7d_hosp))) {
            med8DrillDown = parseInt(count.ct_covid_positive) - (parseInt(count.ct_covid_positive_7d) + parseInt(count.ct_covid_positive_7d_hosp));
        }

        let med8PadClass = med8DrillDown.toString().length >= 5 ? 'pad5' : 'pad3';

        dropTable += '<tr>'+
            '<td colspan="3" class="spacer">&nbsp;</td>'+
            '<td class="dt-center covid-positive">'+count.ct_covid_positive+'</td>'+
            '<td class="dt-center covid-positive-7d">'+count.ct_covid_positive_7d+'</td>'+
            '<td class="dt-center covid-positive-hosp">'+count.ct_covid_positive_7d_hosp+'</td>'+
            '<td class="dt-center covid-med8 ' + med8PadClass + '">'+med8DrillDown+'</td>'+
            '<td class="dt-center covid-bracket">'+count.age_bracket+'</td>'+
           '</tr>'
    });

    dropTable += '</table>';

    return dropTable;
}

var ageBreakDowns = {};
$.getJSON("feeds/priority_drug_counts.jsp", (data) => {
    let json = $.parseJSON(JSON.stringify(data));

    json.forEach((row, i) => {
        if(jQuery.isEmptyObject(ageBreakDowns[row.set_name]))
            ageBreakDowns[row.set_name] = [];

        ageBreakDowns[row.set_name].push(row);
    });

    $.getJSON("feeds/meds_by_class.jsp", (data) => {

        var json = $.parseJSON(JSON.stringify(data));

        var col = [];

        for (i in json['headers']){
            col.push(json['headers'][i]['label']);
        }

        var table = document.createElement("table");
        table.className = 'table table-hover';
        table.style.width = '100%';
        table.id="meds_table";

        var header= table.createTHead();

        // Hard Coded top level headers
        var staticHeaders = [
            [
                {"label":"", "colspan": 3},
                {"label":"COVID Positive (n = " + $('#positive').text() + ")", "colspan": 4},
            ],
            [
                {"label":"", "colspan": 3},
                {"label":"Any time", "colspan": 1},
                {"label":"Medication prescribed within +/-7 days of Covid Diagnosis", "colspan": 2},
                {"label":"Med Rx -8 days of Dx", "colspan": 1},
            ]
        ];

        var header_row_top, th;
        staticHeaders.forEach((headers, index) => {
            header_row_top = header.insertRow(index);
            headers.forEach(function(header, i) {
                th = document.createElement("th");
                    th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + header.label + '</span>';
                    th.setAttribute("colspan", header.colspan);
                    if (header.label == "")
                        th.style.border = "0px";
                    else
                        th.style.backgroundColor = "#2d5985";
                    th.style.textAlign = "center";
                    header_row_top.appendChild(th);
             })
         });

        var header_row_bottom = header.insertRow(staticHeaders.length);

        // Auto generate level headers that don't span any rows
        var label;
        for (i in col) {
            label = col[i].toString();
            if (label === "Trend") // skip trend for now
                continue;

            if (label === "N3C") // append "Persons" value
                label += "<br/>(N = " + $('#persons').text() + ")";

            var th = document.createElement("th");
            th.innerHTML = '<span style="color:#FFF; font-weight:600; font-size:16px;">' + label + '</span>';
            th.style.backgroundColor = "#2d5985";
            header_row_bottom.appendChild(th);
        }

        var divContainer = document.getElementById("medication-dashboard");
        divContainer.appendChild(table);

        // inject age drilldown data
        json['rows'].forEach((row, i) => {
            if(jQuery.isEmptyObject(json['rows'][i]['age'])) {

                json['rows'][i]['age'] = ageBreakDowns[row['set_name']];
            }
        });

        var table = $('#meds_table').DataTable( {
            data: json['rows'],
            paging: false,
            order: [[0, 'asc']],
            columnDefs: [
                {"className": "dt-center", "targets": "_all"}
            ],
            columns: [
                { data: 'class', visible: true, orderable: true },
                {
                    data: 'name', visible: true, orderable: true,
                    render: function (data) {
                        return data.toLowerCase();
                    }
                },
                { data: 'total', visible: true, orderable: true },
                { data: 'all__hospitalized_and_not_', visible: true, orderable: true },
                {
                    data: 'all__hospitalized_and_not__1', visible: true, orderable: true,
                    render: function ( data, type, row, meta ) {
                        if (type === 'sort') {
                            return isNaN(row.all__hospitalized_and_not__1) ? 0 : row.all__hospitalized_and_not__1;
                        } else if (type === 'display') {
                            return row.all__hospitalized_and_not__1;
                        } else {
                            return 0;
                        }
                    }
                },
                {
                    data: 'hospitalized', visible: true, orderable: true,
                    render: function ( data, type, row, meta ) {
                        if (type === 'sort') {
                            return isNaN(row.hospitalized) ? 0 : row.hospitalized;
                        } else if (type === 'display') {
                            return row.hospitalized;
                        } else {
                            return 0;
                        }
                    }
                },
                {
                    data: 'all__hospitalized_and_not__2', visible: true, orderable: true,
                    render: function ( data, type, row, meta ) {
                        var covidAll = row.all__hospitalized_and_not_;
                        var covid7d = row.all__hospitalized_and_not__1;
                        var med8 = isNaN(parseInt(covid7d)) ? 0 : (parseInt(covidAll) - parseInt(covid7d));

                        if (type === 'sort') {
                            return med8;
                        } else if (type === 'display') {
                            return med8 > 0 ? med8 : 'N/A';
                        } else {
                            return med8;
                        }
                    }
                 },
                 {
                    data: 'age', visible: true, orderable: false,
                    className: 'dt-center details-control',
                    render: function(data) {
                        return '<span><i class="fas fa-chevron-right"></i></span>';
                    }
                 }
            ]
        } );

        // Add event listener for opening and closing drilldown view
        $('#meds_table tbody').on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var row = table.row( tr );

            if ( row.child.isShown() ) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
                $(this).children().children().removeClass('fa-chevron-down').addClass('fa-chevron-right');
            }
            else {
                // Open this row
                row.child( format(row.data()) ).show();
                tr.addClass('shown');
                $(this).children().children().removeClass('fa-chevron-right').addClass('fa-chevron-down');
            }
        } );
    });
});
</script>