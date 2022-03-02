<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CCohort">
	select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='covid_positive_patients';
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class=" panel-primary">
		<div class="panel-body">
			<table>
				<tr>
					<td><i class="fas fa-user-plus"></i></td>
					<td>&nbsp;</td>
					<td>COVID+ Patients</td>
				</tr>
			</table>
		</div>
		<div class="panel-heading">${row.count}</div>
	</div>
</c:forEach>
