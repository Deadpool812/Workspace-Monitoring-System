package com.magenta.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.regex.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.magenta.dao.UserDao;
import com.magenta.util.HashUtil;
import com.magenta.util.SaltUtil;

/**
 * Servlet implementation class ProcessAdd
 */
@WebServlet("/ProcessAdd")
public class ProcessAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessAdd() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession thisSession = request.getSession();
		
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPass = request.getParameter("confirmPass");
		String gender = request.getParameter("gender");
		String manFirst = (String) thisSession.getAttribute("firstname");
		String manLast = (String) thisSession.getAttribute("lastname");
		
		int flag=0;
		
		RequestDispatcher rd1 = request.getRequestDispatcher("addemp.jsp");
		RequestDispatcher rd2 = request.getRequestDispatcher("employees.jsp");
		PrintWriter out = response.getWriter();
		
		UserDao dao = new UserDao();
		try {
			if(firstname.isEmpty() || lastname.isEmpty()) {
				out.println("<span style='color:red'>Name fields cannot be empty!</span>");
				rd1.include(request, response);
			}
			else if(username.isEmpty() || password.isEmpty() || confirmPass.isEmpty()) {
				out.println("<span style='color:red'>Username or password cannot be empty!</span>");
				rd1.include(request, response);
			}
			else {
				boolean isExist = dao.isExist("login_data", username);
				if(isExist) {
					flag=1;
					response.setContentType("application/json");
					JSONObject json = new JSONObject();
					try {
						json.put("flag", flag);
					} catch(JSONException e) {}
					request.setAttribute("jsonString", json.toString());
					rd1.forward(request, response);
				}
				else {
					if(!password.equals(confirmPass)) {
						flag=2;
						response.setContentType("application/json");
						JSONObject json = new JSONObject();
						try {
							json.put("flag", flag);
						} catch(JSONException e) {}
						request.setAttribute("jsonString", json.toString());
						rd1.forward(request, response);
					}
					else {
						String regularExpression = "^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$";
						if(!password.matches(regularExpression)) {
							//out.println("<div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Password length should be atleast 6 and it must contain atleast one special character and one number!</div></div>");
							//rd1.include(request, response);
							flag=4;
							response.setContentType("application/json");
							JSONObject json = new JSONObject();
							try {
								json.put("flag", flag);
							} catch(JSONException e) {}
							request.setAttribute("jsonString", json.toString());
							rd1.forward(request, response);
						}
						else {
							String salt = SaltUtil.generateSalt(512).get();
							String key = HashUtil.hashPassword(password, salt).get();
							String designation = new String("Employee");
							ArrayList<String> tabledata = new ArrayList<String>();
							ArrayList<String> columns = new ArrayList<String> ();
							
							columns.add("firstname");
							columns.add("lastname");
							columns.add("username");
							columns.add("password");
							columns.add("designation");
							columns.add("salt");
							
							tabledata.add(firstname);
							tabledata.add(lastname);
							tabledata.add(username);
							tabledata.add(key);
							tabledata.add(designation);
							tabledata.add(salt);
							dao.registerUser("login_data", columns, tabledata);
							
							columns.clear();
							
							columns.add("firstname");
							columns.add("lastname");
							columns.add("man_firstname");
							columns.add("man_lastname");
							columns.add("gender");
							columns.add("man_id");
							
							tabledata.clear();
							tabledata.add(firstname);
							tabledata.add(lastname);
							tabledata.add(manFirst);
							tabledata.add(manLast);
							tabledata.add(gender);
							tabledata.add((String)thisSession.getAttribute("man_id"));
							dao.registerUser("emp_data", columns, tabledata);
							key = null;
							salt = null;
							
							flag=3;
							response.setContentType("application/json");
							JSONObject json = new JSONObject();
							try {
								json.put("flag", flag);
							} catch(JSONException e) {}
							request.setAttribute("jsonString", json.toString());
							rd1.forward(request, response);
						}
					}
				}
			}
		} catch(Exception e) {
			out.println("<span style='color:red'>Your request could not be processed!</span>");
			e.printStackTrace(out);
		}
	}

}
