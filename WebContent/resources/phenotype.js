/**
 * Group array of Objects by key
 * @param json
 * @returns [{}]
 */
function dataGrouped(json) {
    let grouped = Object.values(json
        .reduce((acc, {mild, severe, mild_ed, moderate, unaffected, dead_w_covid, ...r}) => {
            let key = r.variable;
            acc[key] = (acc[key] || {
                ...r,
                mild: 0,
                severe: 0,
                mild_ed: 0,
                moderate: 0,
                unaffected: 0,
                dead_w_covid: 0
            });
            return (
                acc[key].mild += mild,
                    acc[key].severe += severe,
                    acc[key].mild_ed += mild_ed,
                    acc[key].moderate += moderate,
                    acc[key].unaffected += unaffected,
                    acc[key].dead_w_covid += dead_w_covid,
                    acc);
        }, {}));

    return grouped;
}

/**
 * Calculate the percentage values of the True / All data
 * @param dataAll [[]]
 * @param dataTrue [[]]
 * @param allowedKeys [[]]
 * @returns {*}
 */
function dataPercentage(dataAll, dataTrue, allowedKeys) {
    const calculated = dataAll.map(row => {
        let trueValue = dataTrue.filter(obj => obj.variable === row.variable).pop()
        let calculatedRow = {}

        for (const [category, value] of Object.entries(row)) {
            if (! allowedKeys.includes(category)) {
                calculatedRow[category] = value;
            } else {

                let percentage = 0;

                if (value && trueValue.hasOwnProperty(category)) {
                    percentage = ((trueValue[category] / value) * 100);
                }

                calculatedRow[category] = percentage; //.toFixed(3);
            }
        }

        return calculatedRow;
    });


    return calculated;
}

/**
 * Filtered an object to contain only allowed keys
 * @param unfiltered [{}]
 * @param allowed []
 * @returns {{}}
 */
function filterObject(unfiltered, allowed) {
    const filtered = Object.keys(unfiltered)
        .filter(key => allowed.includes(key))
        .reduce((obj, key) => {
            obj[key] = unfiltered[key];
            return obj;
        }, {});

    return filtered;
}

/**
 * Sum all values in an object
 * @param obj {{}}
 * @returns number
 */
function sumObject(obj) {
    return Object.values(obj).reduce((a, b) => a + b)
}