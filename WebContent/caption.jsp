<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<sql:query var="blocks" dataSource="jdbc/N3CCohort">
	select block from n3c_public_site.block where tag = ?
	<sql:param>${param.tag}</sql:param>
 </sql:query>
<c:forEach items="${blocks.rows}" var="row" varStatus="rowCounter">
	${row.block }
</c:forEach>
