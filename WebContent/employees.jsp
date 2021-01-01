<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.magenta.util.DBUtil, java.sql.ResultSet, java.util.*"%>
<!DOCTYPE html>
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
	if (session.getAttribute("firstname") == null || session.getAttribute("lastname") == null) {
		out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
		request.setAttribute("title", "Login Problem!");
		response.sendRedirect("login.jsp");
	}
%>
<script>
	var data = '${jsonString}';
</script>
<body id="page-top">
	<script>
		window.onload = function (jsonString) {
			var json = JSON.parse(jsonString);
			if(json == null || json.flag == 0) {
				document.getElementById("alert").innerHTML = "";
			}
			else if(json.flag == 3) {
				document.getElementById("alert").innerHTML = "<div class='alert alert-success'><strong>Success!</strong> User has been registered.</div>";
			}
			
		}
		
		function delEmp() {
			const nodeList = document.getElementsByClassName('card');
			const nodeArray = [].slice.call(nodeList);
			var i;
			for(i=0;i<nodeList.length;i++) {
				var newDiv = document.createElement('div');
				newDiv.innerHTML = "<button class='btn btn-danger btn-circle' onclick='remEmp(this);' style='position:absolute; top:5px; left:5px'><i class='fas fa-trash'></i></button>";
				nodeArray[i].insertBefore(newDiv.firstChild, nodeArray[i].childNodes[1]);
			}
			var newDiv = document.createElement('div');
			newDiv.innerHTML = "<a class='collapse-item' id='cancel' onclick='cancel();' href='#'>Cancel</a>";
			document.getElementById('emp').appendChild(newDiv.firstChild);
			document.getElementById('delemp').setAttribute('onclick', '');
		}
		
		function cancel() {
			const nodeList = document.getElementsByClassName('card');
			var i;
			for (i=0; i < nodeList.length; i++) {
				nodeList[i].removeChild(nodeList[i].childNodes[1]);
			}
			var cancelDiv = document.getElementById('cancel');
			document.getElementById('emp').removeChild(cancelDiv);
			document.getElementById('delemp').setAttribute('onclick', 'delEmp();');
		}
		
		function remEmp(node) {
			if(confirm("Are you sure you want to delete this employee?")) {
				var thisdiv = node.parentNode;
				var emp_id = thisdiv.getElementsByClassName('card-body')[0].querySelectorAll('div')[0].textContent;
				var url_cur = window.location.href.split('?')[0];
				window.location.href = "<%=request.getContextPath()%>/employees.jsp?emp_id=" + emp_id;
				//var new_url = url_cur + "?emp_id=" + emp_id;
				//window.location.href = new_url;
			}
		}

	</script>
	<%
		String eid = request.getParameter("emp_id");
		if(eid != null) {
			String delquery = new String("delete from emp_data where emp_id='" + eid + "'");
			DBUtil.executeUpdate(delquery);
		}
	%>
	
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
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded" id="emp">
            <a class="collapse-item" href="addemp.jsp">Add</a>
            <a class="collapse-item" href="#" id="delemp" onclick="delEmp();">Remove</a>
          </div>
        </div>
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
            <h1 class="h3 mb-0 text-gray-800">Employees</h1>
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
				  <div class="card border-0 shadow">
					<%
						if (rs.getString("gender").equals("Male")) {
					%>
					<img src="images/icons/img_avatar.png" alt="Avatar" class="card-img-top">
					<div class="card-body text-center">
					  <h5 class="card-title mb-0"><%=rs.getString("firstname")%> <%=rs.getString("lastname")%></h5>
					  <div class="card-text text-black-50"><%=rs.getString("emp_id")%></div>
					</div>
					<%
						} else {
					%>
					<img src="images/icons/img_avatar2.png" alt="Avatar" class="card-img-top">
					<div class="card-body text-center">
					  <h5 class="card-title mb-0"><%=rs.getString("firstname")%> <%=rs.getString("lastname")%></h5>
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