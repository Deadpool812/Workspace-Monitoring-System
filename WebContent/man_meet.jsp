<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.magenta.util.DBUtil, com.magenta.dao.UserDao, java.sql.ResultSet, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Magenta: Meetings</title>
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
	if(session.getAttribute("firstname") == null || session.getAttribute("lastname") == null) {
		out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
		request.setAttribute("title", "Login Problem!");
		response.sendRedirect("login.jsp");
	}
%>
<script>
	var flag='${flag}';
</script>

<%
	String emp_id = request.getParameter("emp_id");
	String man_id = (String)session.getAttribute("man_id");
	String sql = null;
	if(emp_id != null) {
		String flag = request.getParameter("flag");
		String meet_id = request.getParameter("meet_id");
		sql = "update active_meet set man_id='" + man_id + "', emp_id='" + emp_id + "', status='Assigned' where meet_id='" + meet_id + "'";
		DBUtil.executeUpdate(sql);
	}
%>
<body id="page-top" onload='alert_msg(flag);'>
	<script>
		function alert_msg(flag) {
			if (flag != null && flag == 1) {
				document.getElementById('alert').innerHTML = "<div class='alert alert-danger'>You have no employees.</div>";
			}
			else if (flag == 0) {
				document.getElementById('alert').innerHTML = "";
			}
		}
	
		function onTableClick(node) {
			if(confirm("Do you want to accept this meeting?")) {
				var row = node.closest("tr");
				var meet_id = row.cells.item(0).innerHTML;
				window.location.href = "<%=request.getContextPath()%>/emp_addtomeet.jsp?meet_id=" + meet_id;
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
        <a class="nav-link" href="ManagerHome.jsp">
          <i class="fa fa-home"></i>
          <span>Home</span></a>
      </li>

      <!-- Nav Item - Employees -->
      <li class="nav-item">
        <a class="nav-link" href="employees.jsp">
          <i class="fa fa-user"></i>
          <span>Employees</span></a>
      </li>
	  
      <!-- Nav Item - Meetings -->
      <li class="nav-item active">
        <a class="nav-link" href="man_meet.jsp">
          <i class="fa fa-users"></i>
          <span>Meetings</span></a>
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
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("firstname")%> <%=session.getAttribute("lastname") %></span>
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
			<div id="alert"></div>
			<h1 class="h3 mb-2 text-gray-800">Meetings</h1>
			<br>
		  
			<div class="card shadow mb-4">
			<!-- Table Heading -->
			<div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Requests</h6>
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
								<th>Request Time</th>
								<th>Action</th>
							  </tr>
						  </thead>   
						  <tbody>
							<% 
								UserDao dao = new UserDao();
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time from active_meet where completed='0' and status='Pending'";
								ResultSet rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
							%>
								<tr>
									<td><%=rs.getString("meet_id") %></td>
									<td>Not Assigned</td>
									<td><%=rs.getString("title") %></td>
									<td><%=rs.getString("email") %></td>
									<td><%=rs.getString("descript") %></td>
									<td><%=rs.getString("footnotes") %></td>
									<td><%=rs.getString("sched_time") %></td>
									<td><button type="button" class="btn btn-primary" onclick="onTableClick(this)" /><span class="text">Accept</span></td>
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
				<!-- Table Heading -->
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">Scheduled</h6>
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
								<th>Request Time</th>
							</tr>
						</thead>
						<tbody>
							<% 
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time from active_meet where completed='0' and (status='Assigned' or status='TBV') and man_id='"+man_id+"'";
								rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
									String eid = rs.getString("emp_id");
									String ver = "select man_id from emp_data where emp_id='" + eid + "'";
									ResultSet rs1 = DBUtil.executeQuery(ver);
									while(rs1.next()) {
							%>
							<tr>
								<td><%=rs.getString("meet_id") %></td>
								<td><%=rs.getString("emp_id") %></td>
								<td><%=rs.getString("title") %></td>
								<td><%=rs.getString("email") %></td>
								<td><%=rs.getString("descript") %></td>
								<td><%=rs.getString("footnotes") %></td>
								<td><%=rs.getString("sched_time") %></td>
							</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
				</div>
				</div>
				</div>
				<br>
				<div class="card shadow mb-4">
				<!-- Table Heading -->
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
								<th>Request Time</th>
								<th>Completed Time</th>
							</tr>
						</thead>
						<tbody>
							<% 
								sql = "select meet_id,cust_id,emp_id,title,email,descript,footnotes, sched_time, comp_time from active_meet where completed='1' and man_id='"+man_id+"'";
								rs = DBUtil.executeQuery(sql);
								while(rs.next()) {
									String eid = rs.getString("emp_id");
									String ver = "select man_id from emp_data where emp_id='" + eid + "'";
									ResultSet rs1 = DBUtil.executeQuery(ver);
									while(rs1.next()) {
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
  <script src="js/demo/datatables-three.js"></script>
</body>
</html>