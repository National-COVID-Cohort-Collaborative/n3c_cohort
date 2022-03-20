<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/n3c_login_style.css";
@import "<util:applicationRoot/>/resources/main_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<jsp:include page="graphs/reinfection_timeline.jsp" flush="true">
	<jsp:param value="${param.question}" name="question"/>
</jsp:include>
