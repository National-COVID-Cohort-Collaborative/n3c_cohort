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
				<form action="mapping.jsp">
					Pattern: <input type="text" name="org">
				</form>
				<sql:query var="orgs" dataSource="jdbc/N3CCohort">
					select distinct institutionid,institutionname from enclave_cohort.feedout
					where institutionid not in (select institutionid from enclave_cohort.map_site)
					order by institutionname
				</sql:query>
				<ul>
					<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
						<li>${row.institutionname}
					</c:forEach>
				</ul>
			</c:when>
			<c:when test="${empty param.state}">
				<div class="container-fluid" style="width: 100%">
					<form method='GET' action='submit_mapping.jsp'>
		<div class="container-fluid" style="float: left; width: 100%">
			<button type="submit" name="action" value="submit">Submit</button>
			</div>
						<div class="container-fluid" style="float: left; width: 30%">
							<sql:query var="orgs" dataSource="jdbc/N3CCohort">
					select distinct institutionid,institutionname from enclave_cohort.feedout
					where institutionname ~ ?
					order by institutionname
					<sql:param>${param.org}</sql:param>
							</sql:query>
							<ul>
								<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
									<input id="org" name=org type="radio" value="${row.institutionid}">${row.institutionname}<br>
								</c:forEach>
							</ul>
						</div>

						<div class="container-fluid" style="float: left; width: 70%">
							<h3>${param.name}</h3>
							<sql:query var="orgs" dataSource="jdbc/N3CCohort">
					select id,org_name from enclave_cohort.ken_master
					where org_name ~ ?
					order by org_name
					<sql:param>${param.org}</sql:param>
							</sql:query>
							<ul>
								<c:forEach items="${orgs.rows}" var="row" varStatus="rowCounter">
									<input id="id" name=id type="radio" value="${row.id}">${row.org_name}<br>
								</c:forEach>
							</ul>
						</div>
					</form>
				</div>
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

		<div class="container-fluid" style="float: left; width: 100%">
			<jsp:include page="../footer.jsp" flush="true" />
		</div>
	</div>
</body>
</html>
