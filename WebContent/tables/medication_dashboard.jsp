<style>
th.dt-center, td.dt-center {
  text-align: center;
}
</style>
<script>
function format ( d ) {
    // `d` is the original data object for the row

    if(jQuery.isEmptyObject(d.age))
        return '<tr class="age-drilldown_'+d.set_hash+'"><td class="dt-center">no additional data available for '+d.name+'</td></tr>';

    let dropTable = '';
    d.age.forEach((count, i) => {

        // calculate "all hospitalized and not diff"
        let med8DrillDown = 'N/A';
        if (!isNaN(parseInt(count.ct_covid_positive))
         && !isNaN(parseInt(count.ct_covid_positive_7d))
          && !isNaN(parseInt(count.ct_covid_positive_7d_hosp))) {
            med8DrillDown = parseInt(count.ct_covid_positive) - (parseInt(count.ct_covid_positive_7d) + parseInt(count.ct_covid_positive_7d_hosp));
        }

        dropTable += '<tr class="age-drilldown-'+d.set_hash+'">'+
            '<td colspan="3" class="spacer">&nbsp;</td>'+
            '<td class="dt-center">'+count.ct_covid_positive+'</td>'+
            '<td class="dt-center">'+count.ct_covid_positive_7d+'</td>'+
            '<td class="dt-center">'+count.ct_covid_positive_7d_hosp+'</td>'+
            '<td class="dt-center">'+med8DrillDown+'</td>'+
            '<td class="dt-center">'+count.age_bracket+'</td>'+
           '</tr>'
    });

    return dropTable;
}

var ageBreakDowns = {};
$.getJSON("feeds/priority_drug_counts.jsp", (data) => {
    let json = $.parseJSON(JSON.stringify(data));

    json.forEach((row, i) => {
        if(jQuery.isEmptyObject(ageBreakDowns[row.set_name])) {
            ageBreakDowns[row.set_name] = [];
        }

        ageBreakDowns[row.set_name].push(row);
    });

    $.getJSON("feeds/meds_by_class.jsp", (data) => {

        var json = $.parseJSON(JSON.stringify(data));

        var col = [];

        var col = json['headers'].map(item => item.label)

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
            if (label === "Trend") { // skip trend for now
                continue;
            }

            if (label === "N3C") { // append "Persons" value
                label += "<br/>(N = " + $('#persons').text() + ")";
            }

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
            let tr = $(this).closest('tr');

            let row = table.row( tr );
            let rowData = row.data();
            let toggleClassName = "tr.age-drilldown-" + rowData.set_hash;

            if ( tr.hasClass('shown') ) {
                // This row is already showing drilldown data - remove it
                $(toggleClassName).each((i, row) => {
                    $(row).remove();
                });

                tr.removeClass('shown');
                $(this).children().children().removeClass('fa-chevron-down').addClass('fa-chevron-right');
            } else {
                // append drilldown data to this row
                tr.after(format(rowData)).addClass('shown');
                $(this).children().children().removeClass('fa-chevron-right').addClass('fa-chevron-down');
            }
        } );

        $('#meds_table').on('order.dt', function() {
            $('#meds_table tr.shown').each((i, row) => {
                $(row).removeClass('shown');

                // reset the toggle image
                $(row).find('td.details-control').children().children()
                    .removeClass('fa-chevron-down')
                    .addClass('fa-chevron-right');
            });
        });
    });
});
</script>