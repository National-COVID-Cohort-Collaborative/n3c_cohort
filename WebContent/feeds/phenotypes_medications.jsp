<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="meds" dataSource="jdbc/N3CCohort">
	SELECT jsonb_pretty(jsonb_agg(foo))
        	FROM (
                SELECT phenotypeid, value,
                CASE WHEN phenotypeid = 1 THEN 'All_Patients' ELSE variable END As variable,
                SUM(dead_w_covid) AS dead_w_covid,
                SUM(mild) AS mild,
                SUM(mild_ed) AS mild_ed,
                SUM(moderate) AS moderate,
                SUM(severe) AS severe
                FROM enclave_data.clamped_med_usage_by_severity
                WHERE variable = ?
                GROUP BY phenotypeid, value, variable
            ) AS foo;
    <sql:param value="${param.name}"/>
</sql:query>
{
   "headers": [
           {"value":"mild", "label":"Mild"},
           {"value":"mild_ed", "label":"Mild ED"},
           {"value":"moderate", "label":"Moderate"},
           {"value":"severe", "label":"Severe"},
           {"value":"dead_w_covid", "label":"Dead"}
       ],
    "rows":
    <c:forEach items="${meds.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
    </c:forEach>
}