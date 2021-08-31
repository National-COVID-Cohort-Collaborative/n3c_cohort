<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<jsp:include page="../head.jsp" flush="true" />

<style type="text/css" media="all">
@import "../resources/n3c_login_style.css";
</style>


<body>

	<jsp:include page="../navbar.jsp" flush="true" />

	<div class="container-fluid">
		<h2 class="header-text">
			<img src="../images/n3c_logo.png" class="n3c_logo_header"
				alt="N3C Logo">N3C Site Mapping
		</h2>

		<c:choose>
			<c:when test="${empty param.org and empty param.state}">
				<sql:query var="orgs" dataSource="jdbc/N3CCohort">
					select distinct institutionid,institutionname from enclave_cohort.feedout
					where institutionid not in (select institutionid from enclave_cohort.map_site)
					order by institutionname
				</sql:query>
				<ul>
					<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
						<li><a href="mapping.jsp?org=${row.institutionid}&name=${row.institutionname}">${row.institutionname}</a>
					</c:forEach>
				</ul>
			</c:when>
			<c:when test="${empty param.state}">
				<h3>${param.name}</h3>
				<sql:query var="orgs" dataSource="jdbc/N3CCohort">
					select name,abbrev from enclave_cohort.map_state
					order by name
				</sql:query>
				<ul>
					<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
						<li><a href="submit_mapping.jsp?org=${param.org}&state=${row.abbrev}">${row.name}</a>
					</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<sql:update dataSource="jdbc/N3CCohort">
					insert into enclave_cohort.map_site values(?, ?);
					<sql:param>${param.org}</sql:param>
					<sql:param>${param.state}</sql:param>
				</sql:update>
				<c:redirect url="mapping.jsp" />
			</c:otherwise>
		</c:choose>

		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
