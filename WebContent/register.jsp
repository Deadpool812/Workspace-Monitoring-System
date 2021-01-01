<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">

<title>Magenta: Register</title>
</head>
<script>
	var data = '${jsonString}';
</script>
<body class="bg-gradient-primary" onload='alert_msg(data);'>
	<script>
		function alert_msg(jsonString) {
			var json = JSON.parse(jsonString);
			if(json == null || json.flag == 0) {
				document.getElementById("alert").innerHTML = "";
			}
			else if(json.flag == 1) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Name fields cannot be empty!</div></div>";
			}
			else if(json.flag == 2) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Username or password cannot be empty!</div></div>";
			}
			else if(json.flag == 3) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>User already exists!</div></div>";
			}
			else if(json.flag == 4) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Password and confirm password don't match!</div></div>";
			}
			else if(json.flag == 5) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Password length should be atleast 6 and it must contain atleast one special character and one number!</div></div>";
			}
		}
	</script>
	<div class="container">
	<div id="alert"></div>
    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create a Manager Account!</h1>
              </div>
              <form class="user" action="processRegistration" method="post">
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" name="firstname" id="FirstName" placeholder="First Name">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" name="lastname" id="LastName" placeholder="Last Name">
                  </div>
                </div>
                <div class="form-group">
                  <input type="text" class="form-control form-control-user" name="username" id="InputUser" placeholder="Username">
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user" name="password" id="exampleInputPassword" placeholder="Password">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" name="confirmPass" id="exampleRepeatPassword" placeholder="Repeat Password">
                  </div>
                </div>
				<button class="btn btn-primary btn-user btn-block" name="submit">Register Account</button>
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="login.jsp">Already have an account? Login!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>
</body>
</html>