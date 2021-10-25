<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>patient_group,number_of_people<sql:query var="questions" dataSource="jdbc/N3CCohort">select * from n3c_questions.results_censored</sql:query><c:forEach items="${questions.rows}" var="row" varStatus="rowCounter">
"${row.patient_group}","${row.number_of_people}"</c:forEach>
