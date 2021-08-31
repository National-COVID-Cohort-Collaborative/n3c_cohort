<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:update dataSource="jdbc/N3CCohort">
	insert into enclave_cohort.map_site values(?, ?);
	<sql:param>${param.org}</sql:param>
	<sql:param>${param.id}</sql:param>
</sql:update>
<c:redirect url="mapping.jsp" />
