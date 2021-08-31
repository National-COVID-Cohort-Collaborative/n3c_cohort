function buildPhenotypeData(json, headers) {
    let phenotypeData = new Map();
    let phenotypeTrue = new Map();

    //let headers = json['headers'].map(item => item.value)

    json.forEach((row, i) => {
        let currKey = {}

        if (! phenotypeData.has(row['variable'])) {
            phenotypeData.set(row['variable'], row);

            if (row['value']) { // if value is true, push to stack
                headers.map(header => currKey[header] = isNaN(row[header]) ? 0 : row[header]);
                phenotypeTrue.set(row['variable'], currKey);
            }
        } else {
            let tmpValues = Object.entries(phenotypeData.get(row['variable']));

            for (const [key, value] of tmpValues) {

                if (! headers.includes(key))
                    currKey[key] = value;
                else
                    currKey[key] = value + row[key];
            }

            phenotypeData.set(row['variable'], currKey);

            // compute all "value = true"
            if (row['value']) {
                let currTruKey = {};

                headers.map(header => currTruKey[header] = isNaN(row[header]) ? 0 : row[header]);

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

    for (let [key, entries] of phenotypeData.entries()) {
        let trueValue = phenotypeTrue.get(key);

        if (! trueValue)
            continue;

        for (const [category, value] of Object.entries(entries)) {
            if ( ! headers.includes(category))
                continue;

            let percentage = 0;

            if (value && trueValue.hasOwnProperty(category)) {
                percentage = ((trueValue[category] / value) * 100);
            }


            entries[category] = percentage.toFixed(3);
        }
        phenotypeData.set(key, entries);
    }

    return phenotypeData;
}