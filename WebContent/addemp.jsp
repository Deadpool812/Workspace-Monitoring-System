<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Magenta: Add Employee</title>
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
<script>
	var data = '${jsonString}';
</script>
<body id="page-top" onload='alert_msg(data);'>
	<script>
		function alert_msg(jsonString) {
			var json = JSON.parse(jsonString);
			if(json == null || json.flag == 0) {
				document.getElementById("alert").innerHTML = "";
			}
			else if(json.flag == 2) {
				document.getElementById("alert").innerHTML = "<div class='alert alert-danger'>Passwords do not match!</div>";
			}
			else if(json.flag == 1) {
				document.getElementById("alert").innerHTML = "<div class='alert alert-danger'><strong>Failed!</strong> User already exists!</div>";
			}
			else if(json.flag == 3) {
				document.getElementById("alert").innerHTML = "<div class='alert alert-success'>Employee added successfully!</div>";
			}
			else if(json.flag == 4) {
				document.getElementById("alert").innerHTML = "<div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Password length should be atleast 6 and it must contain atleast one special character and one number!</div></div>";
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

      <!-- Nav Item - Employees Collapse Menu -->
      <li class="nav-item active">
        <a class="nav-link collapsed" href="employees.jsp" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fa fa-user"></i>
          <span>Employees</span>
        </a>
        <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded" id="emp">
            <a class="collapse-item active" href="addemp.jsp">Add</a>
            <a class="collapse-item" href="employees.jsp" id="delemp">Remove</a>
          </div>
        </div>
      </li>
	  
      <!-- Nav Item - Meetings -->
      <li class="nav-item">
        <a class="nav-link" href="man_meet.jsp">
          <i class="fa fa-users"></i>
          <span>Meetings</span></a>
      </li>
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
            <h1 class="h3 mb-0 text-gray-800">Add Employee</h1>
          </div>
				<div id="alert"></div>
				<div id="reg_table">
					<form action="processAdd" method="post">
						<div class="form-group">
							<label for="firstname">First Name</label> <input type="text"
								name="firstname" id="firstname" placeholder="Enter First Name"
								class="form-control" required="true">
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label> <input type="text"
								name="lastname" id="lastname" placeholder="Enter Last Name"
								class="form-control" required="true">
						</div>
						<div class="form-group">
							<label for="username">Username</label> <input type="text"
								name="username" id="username" placeholder="Enter Username"
								class="form-control" required="true">
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								name="password" id="password" placeholder="Enter Password"
								class="form-control" required="true">
						</div>
						<div class="form-group">
							<label for="confirmPass">Confirm Password</label> <input
								type="password" name="confirmPass" id="confirmPass"
								placeholder="Confirm Password" class="form-control"
								required="true">
						</div>
						<div class="form-group">
							<label for="rad_male">Gender&nbsp</label> <input type="radio"
								name="gender" id="rad_male" value="Male" checked><label
								for="rad_male">&nbspMale</label> <input type="radio" name="gender"
								id="rad_female" value="Female"><label for="rad_female">&nbspFemale</label>
						</div>
						<input type="submit" name="submit" value="Add Employee"
							class="btn btn-primary btn-user btn-block">
					</form>
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
  <script src="vendor/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="js/demo/chart-area-demo.js"></script>
  <script src="js/demo/chart-pie-demo.js"></script>

</body>
</html>