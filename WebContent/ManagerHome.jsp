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
</head>

<% 
	if(session.getAttribute("firstname") == null || session.getAttribute("lastname") == null) {
		out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
		request.setAttribute("title", "Login Problem!");
		response.sendRedirect("login.jsp");
	}
%>

<body id="page-top">

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
      <li class="nav-item active">
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
      <li class="nav-item">
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
            <h1 class="h3 mb-0 text-gray-800">Home</h1>
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Tasks -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
						<%
							UserDao dao = new UserDao();
							String man_id = (String)session.getAttribute("man_id");
							String sql = "select count(meet_id) as task_inc from active_meet where man_id='" + man_id + "' and (status='Assigned' or status='TBV')";
							ResultSet rs = DBUtil.executeQuery(sql);
							while(rs.next()) {
								String ver = "select count(meet_id) as task_comp from active_meet where man_id='" + man_id + "' and status='Completed'";
								ResultSet rs1 = DBUtil.executeQuery(ver);
								while(rs1.next()) {
									int task_inc = Integer.parseInt(rs.getString("task_inc"));
									int task_comp = Integer.parseInt(rs1.getString("task_comp"));
									int task = 0;
									if((task_inc+task_comp)==0) {
										task = 0;
									}else{
										task = task_comp*100/(task_inc+task_comp);
									}
						%>
							<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><%out.println(task + "%");%></div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: <%out.println(task + "%");%>" aria-valuenow="<%out.println(task);%>" aria-valuemin="0" aria-valuemax="100"></div>
							<%
									}
								}
							%>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Meetings</div>
						<%
							man_id = (String)session.getAttribute("man_id");
							sql = "select count(meet_id) as meet_count from active_meet where man_id='" + man_id + "' and status='Assigned'";
							rs = DBUtil.executeQuery(sql);
							while(rs.next()) {
						%>
						<div class="h5 mb-0 font-weight-bold text-gray-800"><%=rs.getString("meet_count") %></div>
						<%
							}
						%>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
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

</body>
</html>