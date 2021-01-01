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

<title>Magenta: Sign In</title>
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
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Username or password cannot be empty!</div></div>";
			}
			else if(json.flag == 2) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Company Name or password incorrect! Please try again.</div></div>";
			}
			else if(json.flag == 3) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Username or password incorrect! Please try again.</div></div>";
			}
			else if(json.flag == 4) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-success' style='text-align:center;'>You logged out successfully</div></div>";
			}
			else if(json.flag == 6) {
				document.getElementById("alert").innerHTML = "<br><div style='align:center'><div class='alert alert-success' style='text-align:center;'>User registered successfully!</div></div>";
			}
		}
	</script>
  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">
		<div id="alert"></div>
        <div class="card o-hidden border-0 shadow-lg my-5">
			
			<div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                  </div>
                  <form class="user" action="processLogin" method=post>
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="InputUser" placeholder="Username" name="username">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="InputPassword" placeholder="Password" name="password">
                    </div>
                    <div class="form-group">
						<input type="radio" id="Yes"
							name="cust" value="Yes" checked>
							<label for="Yes">Customer&nbsp</label>
						<input type="radio" id="No" 
							name="cust" value="No">
							<label for="Yes">Manager&nbsp/&nbspEmployee</label>
					</div>
					<button class="btn btn-primary btn-user btn-block" name="submit">Login</button>
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="<%=request.getContextPath()%>/register.jsp" id="myButton">Create an Account!</a>
                  </div>
				  <script type="text/javascript">
						document.getElementById("myButton").onclick = function() {
							if(document.getElementById("Yes").checked) {
								document.getElementById("myButton").href="<%=request.getContextPath()%>/cust_reg.jsp";
							} else {
								document.getElementById("myButton").href="<%=request.getContextPath()%>/register.jsp";
							}
  						};
				  </script>
                </div>
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