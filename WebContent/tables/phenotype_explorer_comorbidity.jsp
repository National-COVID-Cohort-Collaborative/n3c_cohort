<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.js"></script>
<script>
var comorbidityTable;
var comorbidityTrue;

function loadAdditionalPhenotypeDetailsForPhenotype(phenotypeId) {
    comorbidityTable = [];
    comorbidityTrue = new Map();

    $.getJSON("feeds/phenotypes_comorbidity.jsp?pid=" + phenotypeId, (data) => {
        let json = $.parseJSON(JSON.stringify(data))
        let headers = json['headers'].map(item => item.value)

        let comorbidityAll = new Map();

        json['rows'].forEach((row, i) => {
            let currKey = {}

            headers.forEach(header => {
                currKey[header] = row[header];
            });

            if (! comorbidityAll.has(row['variable'])) {
                comorbidityAll.set(row['variable'], currKey);

                if (row['value']) {
                    comorbidityTrue.set(row['variable'], currKey);
                }
            } else {
                let tmpValues = Object.entries(comorbidityAll.get(row['variable']));

                for (const [key, value] of tmpValues) {
                    currKey[key] += value;
                }

                comorbidityAll.set(row['variable'], currKey);

                if (row['value']) {
                    let currTruKey = {};

                    headers.forEach(header => {
                        currTruKey[header] = row[header];
                    });

                    if (! comorbidityTrue.has(row['variable'])) {
                        comorbidityTrue.set(row['variable'], currTruKey);
                    } else {
                        let tmpTruValues = Object.entries(comorbidityTrue.get(row['variable']));

                        for (const [key, value] of tmpTruValues) {
                            currTruKey[key] += value;
                        }
                    }

                    comorbidityTrue.set(row['variable'], currTruKey);
                }
            }

        });

        comorbidityAll.forEach(buildComorbidityTable);

        var peComorbidityTable;
        if ($.fn.dataTable.isDataTable('#phenotype_comorbidity_table')) {
            peComorbidityTable = $('#phenotype_comorbidity_table').DataTable();
            peComorbidityTable.clear().draw();
            peComorbidityTable.rows.add(comorbidityTable).draw();
        } else {
            var table = document.createElement("table");
                table.className = 'table table-hover';
                table.style.width = '100%';
                table.id = "phenotype_comorbidity_table";

            var divContainer = document.getElementById("phenotype-explorer-comorbidity");
            divContainer.appendChild(table);

            peComorbidityTable = $('#phenotype_comorbidity_table').DataTable( {
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

function buildComorbidityTable(comorbidity, variable) {
    let comorbidityRow = {};

    comorbidityRow['variable'] = variable.replace('_', ' ');
    for (const [key, value] of Object.entries(comorbidity)) {
        let trueValue = comorbidityTrue.get(variable);
        let percentage = ((trueValue[key] / value) * 100).toFixed(3);
        comorbidityRow[key] = percentage + '%';
    }
    comorbidityTable.push(comorbidityRow);

    return comorbidityTable;
}
</script>