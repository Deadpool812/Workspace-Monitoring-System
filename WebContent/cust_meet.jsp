<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.magenta.util.DBUtil, com.magenta.dao.UserDao, java.sql.ResultSet, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Magenta: Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>

	<% 
		if(session.getAttribute("username") == null) {
			out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
			request.setAttribute("title", "Login Problem!");
			response.sendRedirect("login.jsp");
		}
	%>
	<%
		String meet_id = request.getParameter("meet_id");
		String sql = new String();
		if(!request.getHeader("Referer").contains("reschedule.jsp")) {
		sql = "update active_meet set status='completed', completed=true where meet_id='"+meet_id+"'";
		DBUtil.executeUpdate(sql);
		}
	%>
<script>
	var jsonString = '${jsonString}';
</script>
<body id="page-top" onload='alert_msg(jsonString);'>
	<script>
		function alert_msg(jsonString) {
			var json = JSON.parse(jsonString);
			if(json == null || json.flag == 0) {
				document.getElementById("alert").innerHTML = "";
			}
			else if(json.flag == 1) {
				document.getElementById("alert").innerHTML = "<div class='alert alert-success'>Meeting rescheduled successfully!</div>";
			}
		}
	
		function onTableClick(node) {
			if(confirm("Do you want to mark this meeting as completed?")) {
				var row = node.closest("tr");
				var meet_id = row.cells.item(0).innerHTML;
				window.location.href = "<%=request.getContextPath()%>/cust_meet.jsp?meet_id=" + meet_id;
			}
			else{
				var row = node.closest("tr");
				var meet_id = row.cells.item(0).innerHTML;
				var emp_id = row.cells.item(1).innerHTML;
				window.location.href = "<%=request.getContextPath()%>/reschedule.jsp?meet_id=" + meet_id + "&emp_id=" + emp_id;
			}
		}
		
		function reSchedule(node) {
			if(confirm("Do you want to reschedule this meeting?")) {
				var row = node.closest("tr");
				var meet_id = row.cells.item(0).innerHTML;
				window.location.href = "<%=request.getContextPath()%>/reschedule.jsp?meet_id=" + meet_id;
			}
		}
	</script>
<!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

		  <!-- Sidebar - Brand -->
		  <a class="sidebar-brand d-flex align-items-center justify-content-center" href="ManagerHome.jsp">
			<div class="sidebar-brand-text mx-3">Magenta</div>
		  </a>

		  <!-- Divider -->
		  <hr class="sidebar-divider my-0">

		  <!-- Nav Item - Home -->
		  <li class="nav-item">
			<a class="nav-link" href="CustHome.jsp">
			  <i class="fa fa-home"></i>
			  <span>Home</span></a>
		  </li>
		
		  <!-- Nav Item - Meetings Collapse Menu -->
		  <li class="nav-item active">
			<a class="nav-link collapsed" href="cust_meet.jsp" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
			  <i class="fa fa-users"></i>
			  <span>Meetings</span>
			</a>
			<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
			  <div class="bg-white py-2 collapse-inner rounded" >
				<a class="collapse-item" href="addmeet.jsp">Request</a>
				<a class="collapse-item" href="#" id="delemp" onclick="#">Cancel</a>
			  </div>
			</div>
		  </li>
		</ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("username")%></span>
                <img class="img-profile rounded-circle" src="https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="<%=request.getContextPath() %>/logout">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">
			<!-- Page Heading -->
			<h1 class="h3 mb-2 text-gray-800">Meetings</h1>
			<br>
			<div id="alert"></div>
		  
			<!-- Meetings -->
			<div class="card shadow mb-4">
            <div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Active</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTableOne" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Meeting Id</th>
								<th>Employee Id</th>
								<th>Title</th>
								<th>Email</th>
								<th>Description</th>
								<th>Footnotes</th>
								<th>Scheduled Time</th>
								<th>Status</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<% 
								UserDao dao = new UserDao();
								String cust_id = dao.getId("cust_login", "id", (String)session.getAttribute("username"));
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time, status from active_meet where cust_id='" + cust_id + "' and completed='0' and (status='Pending' or status='Assigned')";
								ResultSet rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("meet_id") %></td>
								<td><% if(rs.getString("emp_id")==null){ out.println("Not Assigned"); }else{ out.println(rs.getString("emp_id"));}%></td>
								<td><%=rs.getString("title") %></td>
								<td><%=rs.getString("email") %></td>
								<td><%=rs.getString("descript") %></td>
								<td><%=rs.getString("footnotes") %></td>
								<td><%=rs.getString("sched_time") %></td>
								<td><%=rs.getString("status") %></td>
								<td><button type="button" class="btn btn-primary" onclick="reSchedule(this)" /><span class="text">Reschedule</span></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				</div>
				</div>
				<br>
				<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">Pending for Approval</h6>
				</div>
				<div class="card-body">
				<div class="table-responsive">
                <table class="table table-bordered" id="dataTableTwo" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Meeting Id</th>
								<th>Employee Id</th>
								<th>Title</th>
								<th>Email</th>
								<th>Description</th>
								<th>Footnotes</th>
								<th>Scheduled Time</th>
								<th>Completed Time</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<% 
								cust_id = dao.getId("cust_login", "id", (String)session.getAttribute("username"));
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time,comp_time from active_meet where cust_id='" + cust_id + "' and completed='0' and status='TBV'";
								rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
							%>
							<tr onclick="onTableClick(this)">
								<td><%=rs.getString("meet_id") %></td>
								<td><%=rs.getString("emp_id") %></td>
								<td><%=rs.getString("title") %></td>
								<td><%=rs.getString("email") %></td>
								<td><%=rs.getString("descript") %></td>
								<td><%=rs.getString("footnotes") %></td>
								<td><%=rs.getString("sched_time") %></td>
								<td><%=rs.getString("comp_time") %></td>
								<td><button type="button" class="btn btn-success" onclick="onTableClick(this)" /><span class="text">Verify</span></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				</div>
				</div>
				<br>
				<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">Completed</h6>
				</div>
				<div class="card-body">
				<div class="table-responsive">
                <table class="table table-bordered" id="dataTableThree" width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>Meeting Id</th>
								<th>Employee Id</th>
								<th>Title</th>
								<th>Email</th>
								<th>Description</th>
								<th>Footnotes</th>
								<th>Scheduled Time</th>
								<th>Completed Time</th>
							</tr>
						</thead>
						<tbody>
							<% 
								cust_id = dao.getId("cust_login", "id", (String)session.getAttribute("username"));
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time,comp_time from active_meet where cust_id='" + cust_id + "' and completed='1'";
								rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("meet_id") %></td>
								<td><%=rs.getString("emp_id") %></td>
								<td><%=rs.getString("title") %></td>
								<td><%=rs.getString("email") %></td>
								<td><%=rs.getString("descript") %></td>
								<td><%=rs.getString("footnotes") %></td>
								<td><%=rs.getString("sched_time") %></td>
								<td><%=rs.getString("comp_time") %></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				</div>
				</div>
			</div>
		</div>
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->


  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="js/demo/datatables-one.js"></script>
  <script src="js/demo/datatables-two.js"></script>

</body>
</html>