package com.magenta.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.regex.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.magenta.dao.UserDao;
import com.magenta.util.HashUtil;
import com.magenta.util.SaltUtil;

/**
 * Servlet implementation class ProcessRegistration
 */

public class ProcessRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPass = request.getParameter("confirmPass");
		
		int flag = 0;
		
		RequestDispatcher rd1 = request.getRequestDispatcher("register.jsp");
		RequestDispatcher rd2 = request.getRequestDispatcher("login.jsp");
		PrintWriter out = response.getWriter();
		
		UserDao dao = new UserDao();
		try {
			if(firstname.isEmpty() || lastname.isEmpty()) {
				flag=1;
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				rd1.forward(request, response);
			}
			else if(username.isEmpty() || password.isEmpty() || confirmPass.isEmpty()) {
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
				boolean isExist = dao.isExist("login_data", username);
				if(isExist) {
					flag=3;
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
						String regularExpression = "^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$";
						if(!password.matches(regularExpression)) {
							flag=5;
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
							String designation = new String("Manager");
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
							
							tabledata.clear();
							tabledata.add(firstname);
							tabledata.add(lastname);
							dao.registerUser("man_data", columns, tabledata);
							key = null;
							salt = null;
							flag=6;
							response.setContentType("application/json");
							JSONObject json = new JSONObject();
							try {
								json.put("flag", flag);
							} catch(JSONException e) {}
							request.setAttribute("jsonString", json.toString());
							rd2.forward(request, response);
						}
					}
				}
			}
		} catch(Exception e) {
			out.println("<div style='align:center'><div class='alert alert-danger' style='text-align:center;'>Your request could not be processed!</div></div>");
			e.printStackTrace(out);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
