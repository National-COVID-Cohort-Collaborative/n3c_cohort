<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

		<div class="container-fluid">
			<h1>N3c Enclave Collaborations</h1>
			<ul>
				<li>Large blue icons are projects - mousing over shows the ID and title
				<li>Small blue icons are project members - mouse over to see a name
			</ul>
           <div id="content">
                <div id="collaboration_graph"></div>
            </div>
                <c:url var="encodedMapURL" value="data.jsp">
                    <c:param name="detectionAlg" value="site"/>
                    <c:param name="resolution" value="1"/>
                    <c:param name="mode" value="${param.mode}"/>
                    <c:param name="query" value="${param.query}"/>
                    <c:param name="selectedNode" value="${param.selectedNode}"/>
                    <c:param name="radius" value="${param.radius}"/>
                </c:url>
                <jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
                    <jsp:param name="charge" value="-350" />
                    <jsp:param name="ld" value="70" />
                    <jsp:param name="data_page" value="feeds/project_graph.jsp" />
                    <jsp:param name="detectionAlg" value="sites"/>
                </jsp:include>
		</div>
