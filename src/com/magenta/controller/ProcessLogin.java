package com.magenta.controller;

import java.io.IOException;
import java.io.PrintWriter;

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

/**
 * Servlet implementation class ProcessLogin
 */
@WebServlet("/processLogin")
public class ProcessLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = request.getParameter("cust");
		String username = request.getParameter("username");
		String password=request.getParameter("password");
		
		int flag = 0;
		
		HttpSession session=request.getSession();
		PrintWriter out=response.getWriter();
		
		
		if(username.isEmpty() || password.isEmpty()) {
			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
			flag=1;
			response.setContentType("application/json");
			JSONObject json = new JSONObject();
			try {
				json.put("flag", flag);
			} catch(JSONException e) {}
			request.setAttribute("jsonString", json.toString());
			rd.forward(request, response);
		}
		else {
			UserDao dao = new UserDao();
			RequestDispatcher rd1 = null;
			RequestDispatcher rd2 = request.getRequestDispatcher("login.jsp");
			try {
				if(type.equals("Yes")) {
					boolean authenticate = dao.authenticate("cust_login", username, password);
					if(authenticate) {
						session.setAttribute("username", username);
						session.setAttribute("cust_id", dao.getId("cust_login", "id", username));
						rd1 = request.getRequestDispatcher("CustHome.jsp");
						rd1.forward(request, response);
					}
					else {
						flag=2;
						response.setContentType("application/json");
						JSONObject json = new JSONObject();
						try {
							json.put("flag", flag);
						} catch(JSONException e) {}
						request.setAttribute("jsonString", json.toString());
						rd2.forward(request, response);
					}
				}
				else {
					boolean authenticate = dao.authenticate("login_data", username, password);
					if(authenticate) {
						String firstname = dao.getFirstname(username, password);
						String lastname = dao.getLastname(username, password);
						session.setAttribute("firstname", firstname);
						session.setAttribute("lastname", lastname);
						session.setAttribute("man_id", dao.getId("login_data", "id", username));
						String designation = dao.getDesignation(username, password);
						session.setAttribute("designation", designation);
						rd1 = request.getRequestDispatcher("redirect.jsp");
						rd1.forward(request, response);
					}
					else {
						flag=3;
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
			catch (Exception e) {
				out.println("Your request cannot be processed at the time.." + e);
			}
		}
	}

}
