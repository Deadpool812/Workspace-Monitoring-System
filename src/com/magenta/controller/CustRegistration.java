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
 * Servlet implementation class CustRegistration
 */

public class CustRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String coname = request.getParameter("coname");
		String password = request.getParameter("password");
		String confirmPass = request.getParameter("confirmPass");
		
		int flag = 0;
		
		RequestDispatcher rd1 = request.getRequestDispatcher("cust_reg.jsp");
		RequestDispatcher rd2 = request.getRequestDispatcher("login.jsp");
		PrintWriter out = response.getWriter();
		
		UserDao dao = new UserDao();
		try {
			if(coname.isEmpty()) {
				flag=1;
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				rd1.forward(request, response);
			}
			else if(password.isEmpty() || confirmPass.isEmpty()) {
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
				boolean isExist = dao.companyExist(coname);
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
							ArrayList<String> tabledata = new ArrayList<String>();
							ArrayList<String> columns = new ArrayList<String>();
							
							columns.add("username");
							columns.add("password");
							columns.add("salt");
							
							tabledata.add(coname);
							tabledata.add(key);
							tabledata.add(salt);
							dao.registerUser("cust_login", columns, tabledata);
							
							columns.clear();
							
							columns.add("company_name");
							
							tabledata.clear();
							tabledata.add(coname);
							dao.registerUser("cust_data", columns, tabledata);
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
