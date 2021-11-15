<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	

<div class="row stats">
	<div class="col-xs-12 ">
		<div class=" panel-primary shadow-border top_panel">
			<div class="panel-heading">Engagement and Registration Statistics</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-12 col-lg-6" id="instituions_metrics">
						<table class="table table-hover">
		    				<thead>
		    					<tr><th>Institutions</th><th>Count</th></tr>
		    				</thead>
		    				<sql:query var="duas" dataSource="jdbc/N3CCohort">
		        				select count(*) from n3c_admin.dua_master where duaexecuted is not null;
		    				</sql:query>
		    				<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
		        				<tr><td>Institutions with Executed DUAs</td><td align=right>${row.count}</td></tr>
		    				</c:forEach>
		    				<sql:query var="duas" dataSource="jdbc/N3CCohort">
		        				select count(*) from n3c_admin.dua_master where duaexecuted is not null and institutionid in (select ror_id from n3c_admin.gsuite_view );
		    				</sql:query>
		    				<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
		        				<tr><td>DUA Institutions with Registered Users</td><td align=right>${row.count}</td></tr>
		    				</c:forEach>
		    				<sql:query var="dtas" dataSource="jdbc/N3CCohort">
		        				select count(*) from n3c_admin.dta_master where dtaexecuted is not null;
		    				</sql:query>
		    				<c:forEach items="${dtas.rows}" var="row" varStatus="rowCounter">
		        				<tr><td>Institutions with Executed DTAs</td><td align=right>${row.count}</td></tr>
		    				</c:forEach>
	    				</table>
					</div>
					<div class="col-xs-12 col-lg-6">
						<div id="dua_line">
							<jsp:include page="../graphs/line_data_dua.jsp">
                				<jsp:param name="data_page" value="feeds/line_dta_dua_regs.jsp" />
                				<jsp:param name="dom_element" value="#dua_line" />
                			</jsp:include>
                		</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-xs-12 col-lg-6" id="user_metrics">
						<table class="table table-hover">
				    		<thead>
				    			<tr><th>Users</th><th>Count</th></tr>
				    		</thead>
				    		<sql:query var="duas" dataSource="jdbc/N3CCohort">
				        		select count(*) from n3c_admin.registration;
				    		</sql:query>
				    		<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
				        		<tr><td>Total User Registrations</td><td align=right>${row.count}</td></tr>
				    		</c:forEach>
				    		<sql:query var="duas" dataSource="jdbc/N3CCohort">
				        		select count(*) from n3c_admin.registration where enclave;
				    		</sql:query>
				   			<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
				        		<tr><td>Users Requesting Enclave Access</td><td align=right>${row.count}</td></tr>
				    		</c:forEach>
				    		<sql:query var="duas" dataSource="jdbc/N3CCohort">
				        		select count(*) from palantir.n3c_user;
				    		</sql:query>
				    		<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
				        		<tr><td>Registered Enclave Users From DUA Institutions</td><td align=right>${row.count}</td></tr>
				    		</c:forEach>
				    	</table>
					</div>
					<div class="col-lg-6 col-xs-12">
						<div id="registration_line">
							<jsp:include page="../graphs/line_registrations.jsp">
								<jsp:param name="data_page" value="feeds/line_dta_dua_regs.jsp" />
								<jsp:param name="dom_element" value="#registration_line" />
							</jsp:include>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>


<div class="row comor" style="margin-top:30px;">
	<div class="col-xs-12 col-md-6">
		<div class="panel panel-primary">
			<div class="panel-heading">Data Transfer Agreements</div>
			<div class="panel-body">
				<div id="dta-roster"></div>
				<jsp:include page="../tables/dta_roster.jsp"/>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-md-6">
		<div class="panel panel-primary">
			<div class="panel-heading">Data Use Agreements</div>
			<div class="panel-body">
				<div id="dua-roster"></div>
				<jsp:include page="../tables/dua_roster.jsp"/>
			</div>
		</div>
	</div>
</div>
<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Domain Team Roster</div>
			<div class="panel-body">
				<div id="domain-team-roster"></div>
				<jsp:include page="../tables/domain_team_roster.jsp"/>
			</div>
		</div>
	</div>
</div>
<div class="row comor">
	<div class="col-xs-12">
		<div class="panel panel-primary">
			<div class="panel-heading">Project Roster</div>
			<div class="panel-body">
				<div id="project-roster"></div>
				<jsp:include page="../tables/project_roster_styled.jsp"/>
			</div>
		</div>
	</div>
</div>



