<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(done))
	from (select race,ethnicity,age_bin,gender,severity,patient_count,
			aggregated.age_bin as age_abbrev,age_seq,
			race_abbrev,race_seq,
			ethnicity_abbrev,ethnicity_seq,
			gender_abbrev,gender_seq,
			severity_abbrev,severity_seq
		  from n3c_dashboard.aggregated
		  	natural join n3c_dashboard.age_map
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.ethnicity_map
		  	natural join n3c_dashboard.gender_map
		  	natural join n3c_dashboard.severity_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"age_bin", "label":"Age"},
        {"value":"gender", "label":"Gender"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_count", "label":"Patient Count"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"ethnicity_abbrev", "label":"dummy5"},
        {"value":"ethnicity_seq", "label":"dummy6"},
        {"value":"gender_abbrev", "label":"dummy7"},
        {"value":"gender_seq", "label":"dummy8"},
        {"value":"severity_abbrev", "label":"dummy9"},
        {"value":"severity_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			