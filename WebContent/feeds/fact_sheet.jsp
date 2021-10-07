<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="facts" dataSource="jdbc/N3CCohort">
	select jsonb_pretty(jsonb_agg(foo)) from (
 	          	select 'Date of Latest Release' as title,to_char(substring(value from '[a-zA-Z]*-v[0-9]*-(.*)')::date, 'Month FMDD, YYYY') as value from n3c_admin.enclave_stats where title='release_name'
           	union
            	select 'Latest Release' as title,value from n3c_admin.enclave_stats where title='release_name'
           	union
            	select 'Sites' as title,value from n3c_admin.enclave_stats where title='sites_ingested'
           	union
            	select 'Persons' as title,trim(to_char(value::int/1000000.0,'999.9')||' million') as value from n3c_admin.enclave_stats where title='person_rows'
           	union
	           	select 'COVID-positive Cases' as title,trim(to_char(value::int,'FM999,999')) as value from n3c_admin.enclave_stats where title='covid_positive_patients'
           	union
            	select 'Total Number of Rows' as title,trim(to_char(value::bigint/1000000000.0,'999.9')||' billion') as value from n3c_admin.enclave_stats where title='total_rows'
           	union
            	select 'Clinical Observations' as title,trim(to_char(value::int/1000000.0,'999.9')||' million') as value from n3c_admin.enclave_stats where title='observation_rows'
           	union
            	select 'Lab Results' as title,trim(to_char(value::bigint/1000000000.0,'999.9')||' billion') as value from n3c_admin.enclave_stats where title='measurement_rows'
           	union
            	select 'Medication Records' as title,trim(to_char(value::int/1000000.0,'999.9')||' million') as value from n3c_admin.enclave_stats where title='drug_exposure_rows'
           	union
            	select 'Procedures' as title,trim(to_char(value::int/1000000.0,'999.9')||' million') as value from n3c_admin.enclave_stats where title='procedure_rows'
           	union
            	select 'Visits' as title,trim(to_char(value::int/1000000.0,'999.9')||' million') as value from n3c_admin.enclave_stats where title='visit_rows'
	) as foo;
</sql:query>
{
    "headers": [
        {"value":"title", "label":"Metric"},
        {"value":"value", "label":"Value"}
    ],
    "rows" : 
<c:forEach items="${facts.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
