<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.magenta.util.DBUtil, java.sql.ResultSet, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Magenta: Employees</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
</head>

<% 
	if(session.getAttribute("firstname") == null || session.getAttribute("lastname") == null) {
		out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
		request.setAttribute("title", "Login Problem!");
		response.sendRedirect("login.jsp");
	}

	String pre = new String("SELECT firstname, lastname, count(firstname) as count FROM emp_data where man_firstname='" 
		+ (String)session.getAttribute("firstname") + "' and man_lastname='"
		+ (String)session.getAttribute("lastname") + "'");
	
	ResultSet rs1 = DBUtil.executeQuery(pre);
	while(rs1.next()) {
		if(rs1.getInt("count") == 0) {
			request.setAttribute("flag", 1);
			RequestDispatcher rd = request.getRequestDispatcher("man_meet.jsp");
			rd.forward(request, response);
		}
	}
%>
<script>
</script>
<body id="page-top">
	<script>
		
		function assign(node) {
			var meet_id = getParameter("meet_id");
			var emp_id = node.getElementsByClassName('card-body')[0].querySelectorAll('div')[0].textContent;
			window.location.href = "<%=request.getContextPath()%>/man_meet.jsp?meet_id=" + meet_id + "&emp_id=" + emp_id + "&flag=2";
		}
		
		function getParameter(theParameter) { 
			  var params = window.location.search.substr(1).split('&');
			 
			  for (var i = 0; i < params.length; i++) {
			    var p=params[i].split('=');
				if (p[0] == theParameter) {
				  return decodeURIComponent(p[1]);
				}
			  }
			  return false;
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
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Assign Employee</h1>
          </div>

			<div id="alert"></div>
			<!-- Page Content -->
			<div class="container">
				<div class="row">
				<%
					String sql = new String("SELECT emp_id, firstname, lastname, gender FROM emp_data where man_firstname='"
					+ (String) session.getAttribute("firstname") + "' and man_lastname='"
					+ (String) session.getAttribute("lastname") + "'");
					ResultSet rs = DBUtil.executeQuery(sql);
					while (rs.next()) {
				%>
				<!-- Employees -->
				<div class="col-xl-3 col-md-6 mb-4">
				  <div class="card border-0 shadow" onclick="assign(this);">
					<%
						if (rs.getString("gender").equals("Male")) {
					%>
					<img src="images/icons/img_avatar.png" alt="Avatar" class="card-img-top">
					<div class="card-body text-center">
					  <h5 class="card-title mb-0"><%=rs.getString("firstname")%><%=rs.getString("lastname")%></h5>
					  <div class="card-text text-black-50"><%=rs.getString("emp_id")%></div>
					</div>
					<%
						} else {
					%>
					<img src="images/icons/img_avatar2.png" alt="Avatar" class="card-img-top">
					<div class="card-body text-center">
					  <h5 class="card-title mb-0"><%=rs.getString("firstname")%><%=rs.getString("lastname")%></h5>
					  <div class="card-text text-black-50"><%=rs.getString("emp_id")%></div>
					</div>
					<%
						}
					%>
				  </div>
				</div>
				<% 
					} 
				%>
			  </div>
			  <!-- /.row -->

			</div>
			<!-- /.container -->
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

</body>
</html>