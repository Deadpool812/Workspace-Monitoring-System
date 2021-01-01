<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstarp/4.1.3/css/bootstrap.min.css">


<title>Forwarding..</title>
</head>
<body>
	<%
	if(session.getAttribute("firstname")==null || session.getAttribute("lastname")==null){
		out.println("<span style='color:red'>You are not logged in! Please login properly.</span>");
		request.setAttribute("title", "Login Problem!");
	}
	else {
		RequestDispatcher rd1 = request.getRequestDispatcher("ManagerHome.jsp");
		RequestDispatcher rd2 = request.getRequestDispatcher("EmpHome.jsp");
		if(session.getAttribute("designation").equals("Manager")) {
			rd1.forward(request,response);
		}
		else if(session.getAttribute("designation").equals("Employee")) {
			rd2.forward(request,response);
		}
	}
	%>
</body>
</html>