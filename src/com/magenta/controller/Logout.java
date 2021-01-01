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

/**
 * Servlet implementation class Logout
 */
@WebServlet("/logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		session.removeAttribute("firstname");
		session.removeAttribute("lastname");
		session.removeAttribute("designation");
		session.invalidate();
		
		int flag = 0;
		
		RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
		PrintWriter out=response.getWriter();
		//out.println("<div style='align:center'><div class='alert alert-success' style='text-align:center;'>You logged out successfully</div></div>");
		//rd.include(request, response);
		flag=4;
		response.setContentType("application/json");
		JSONObject json = new JSONObject();
		try {
			json.put("flag", flag);
		} catch(JSONException e) {}
		request.setAttribute("jsonString", json.toString());
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
