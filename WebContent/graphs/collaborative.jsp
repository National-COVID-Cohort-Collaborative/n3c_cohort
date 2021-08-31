<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row stats">
	<div class="col-xs-12 ">
		<div class=" panel-primary">
			<div class="panel-heading">Engagement and Registration Statistics</div>
			<div class="panel-body shadow-border">
			<div class="col-sm-12 col-md-6" id="registration_metrics">
				<h4 class="table-label">Registration Summary</h4>
		    	<table class="table table-hover">
		    		<thead>
		    			<tr><th>Institutions / DUAs</th><th>Count</th></tr>
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
		    	</table>
				<br>
		    	<table class="table table-hover">
		    		<thead>
		    			<tr><th>User Registrations</th><th>Count</th></tr>
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
		
			<div class="col-sm-12 col-md-6" id="dua_timeline">
				<h4 class="table-label">By Date</h4>
				<div style="height:400px; overflow:scroll;">
		    		<table class="table table-hover" >
		    			<thead>
		    				<tr><th>Date</th><th># DUAs Signed</th><th># Users Registered</th></tr>
		    			</thead>
		    			<tbody>
			    			<sql:query var="duas" dataSource="jdbc/N3CCohort">
			        			select * from
			           				(select created::date as date, count(*) as registrations from n3c_admin.registration group by 1) as foo
			        			natural full outer join
			           				(select duaexecuted::date as date,count(*) as duas from n3c_admin.dua_master where duaexecuted is not null group by 1) as bar
			        			order by 1 desc;
			    			</sql:query>
			    			<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
			        			<tr><td>${row.date}</td><td align=right>${row.duas}</td><td align=right>${row.registrations}</td></tr>
			    			</c:forEach>
		    			</tbody>
		    		</table>
		    	</div>
	    	</div>
			</div>
		</div>
	</div>
</div>
<div class="row comor">
	<div class="col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">Data Transfer Agreements</div>
			<div class="panel-body">
				<div id="dta-roster"></div>
				<jsp:include page="../tables/dta_roster.jsp"/>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
				 <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
			</div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="panel panel-primary">
			<div class="panel-heading">Data Use Agreements</div>
			<div class="panel-body">
				<div id="dua-roster"></div>
				<jsp:include page="../tables/dua_roster.jsp"/>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
				 <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
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
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
				 <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
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
				<jsp:include page="../tables/project_roster.jsp"/>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
				 <script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
				 <script type="text/javascript" charset="utf8" src="tables/jquery.hottie.js"></script>
			</div>
		</div>
	</div>
</div>
