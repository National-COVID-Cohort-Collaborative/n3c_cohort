<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
<script>
var comorbidityTable;
var phenotypeTrue;

/**
 *  Load additional details for the given Phenotype
 */
function loadAdditionalPhenotypeDetailsForPhenotype(phenotypeId) {
    comorbidityTable = [];

    $.getJSON("feeds/phenotypes_comorbidity.jsp?pid=" + phenotypeId, (data) => {
        let json = $.parseJSON(JSON.stringify(data))

        let comorbidityAll = new Map();
        comorbidityAll = buildPhenotypeData(json);

        // build the data for the comorbidity table
        comorbidityAll.forEach(buildComorbidityTable);

        // Build the Comorbidity DataTable
        var peComorbidityTable;
        if ($.fn.dataTable.isDataTable('#pe_comorbidity_table')) {
            peComorbidityTable = $('#pe_comorbidity_table').DataTable();
            peComorbidityTable.clear().draw();
            peComorbidityTable.rows.add(comorbidityTable).draw();
        } else {
            var table = document.createElement("table");
                table.className = 'table table-hover';
                table.style.width = '100%';
                table.id = "pe_comorbidity_table";

            var divContainer = document.getElementById("pe-comorbidity");
            divContainer.appendChild(table);

            peComorbidityTable = $('#pe_comorbidity_table').DataTable( {
                data: comorbidityTable,
                paging: false,
                retrieve: true,
                order: [[0, 'asc']],
                columnDefs: [
                    {className: "dt-center", targets: [1,2,3,4,5,6] },
                    {className: "dt-right", targets: [0]}
                ],
                columns: [
                    { data: "variable" },
                    { data: "unaffected", title: "Unaffected" },
                    { data: "mild", title: "Mild" },
                    { data: "mild_ed", title: "Mild ED" },
                    { data: "moderate", title: "Moderate" },
                    { data: "severe", title: "Severe" },
                    { data: "dead_w_covid", title: "Death" }
                ]
            });
        }
    });
}

/**
 * Build the Comorbidity Table Object
 */
function buildComorbidityTable(comorbidity, variable) {
    let comorbidityRow = {};

    comorbidityRow['variable'] = variable.replace('_', ' ');
    for (const [key, value] of Object.entries(comorbidity)) {
        comorbidityRow[key] = value + '%';
    }
    comorbidityTable.push(comorbidityRow);
}

function buildPhenotypeData(json) {
    let phenotypeData = new Map();
    phenotypeTrue = new Map();

    let headers = json['headers'].map(item => item.value)

    json['rows'].forEach((row, i) => {
        let currKey = {}

        headers.forEach(header => {
            currKey[header] = row[header];
        });

        if (! phenotypeData.has(row['variable'])) {
            phenotypeData.set(row['variable'], currKey);

            if (row['value']) { // if value is true, push to stack
                phenotypeTrue.set(row['variable'], currKey);
            }
        } else {
            let tmpValues = Object.entries(phenotypeData.get(row['variable']));

            for (const [key, value] of tmpValues) {
                currKey[key] += value;
            }

            phenotypeData.set(row['variable'], currKey);

            // compute all "value = true"
            if (row['value']) {
                let currTruKey = {};

                headers.forEach(header => {
                    currTruKey[header] = row[header];
                });

                if (! phenotypeTrue.has(row['variable'])) {
                    phenotypeTrue.set(row['variable'], currTruKey);
                } else {
                    let tmpTruValues = Object.entries(phenotypeTrue.get(row['variable']));

                    for (const [key, value] of tmpTruValues) {
                        currTruKey[key] += value;
                    }
                }

                phenotypeTrue.set(row['variable'], currTruKey);
            }
        }
    });

    for (const [key, entries] of phenotypeData.entries()) {
        let trueValue = phenotypeTrue.get(key);
        for (const [category, value] of Object.entries(entries)) {
            let percentage = ((trueValue[category] / value) * 100).toFixed(3);
            entries[category] = percentage;
        }
        phenotypeData.set(key, entries);
    }

    return phenotypeData;
}
</script>