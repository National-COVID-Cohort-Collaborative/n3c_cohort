<script type="text/javascript">
var comorbidityTable;
function comorbidityForPhenotype(phenotypeId) {
   comorbidityTable = [];

    $.getJSON("feeds/phenotypes_comorbidity.jsp?pid=" + phenotypeId, (data) => {
        let json = $.parseJSON(JSON.stringify(data))
        let headers = json['headers'].map(item => item.value)

        let comorbidityAll = new Map();
        comorbidityAll = buildPhenotypeData(json['rows'], headers);

        // TODO: revisit why HIV -> Severe number is off
        // build the data for the comorbidity table
        comorbidityAll.forEach(buildComorbidityTable);

        // Build the Comorbidity DataTable
        let peComorbidityTable;
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

    for (const [key, value] of Object.entries(comorbidity)) {
        comorbidityRow[key] = value + '%';
    }
    comorbidityRow['variable'] = variable.replaceAll('_', ' ');

    comorbidityTable.push(comorbidityRow);
}
</script>