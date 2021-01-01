package com.magenta.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

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
 * Servlet implementation class AddTask
 */
public class AddMeet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMeet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		String title = request.getParameter("title");
		String email = request.getParameter("email");
		String desc = request.getParameter("desc");
		String footnotes = request.getParameter("footnotes");
		String date = request.getParameter("sched-date");
		String time = request.getParameter("sched-time");
		
		String sched = time + " " + date;
		
		String uname = (String) session.getAttribute("username");
		String cust_id = null;
		
		UserDao dao = new UserDao();
		
		Date date1 = new Date();
		Calendar cal = Calendar.getInstance();
		
		int flag=0;
		
		if (footnotes != null) {
			Date meet_date = new Date();
			try {
				meet_date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
			if (meet_date.before(new Date())){
				flag = 2;
				RequestDispatcher rd = request.getRequestDispatcher("addmeet.jsp");
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				rd.forward(request, response);
			}
			else {
				ArrayList<String> columns = new ArrayList<String> ();
				ArrayList<String> data = new ArrayList<String> ();
			
				try {
					cust_id = dao.getId("cust_login", "id", uname);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				columns.add("cust_id");
				columns.add("title");
				columns.add("email");
				columns.add("descript");
				columns.add("footnotes");
				columns.add("req_time");
				columns.add("sched_time");
				
				data.add(cust_id);
				data.add(title);
				data.add(email);
				data.add(desc);
				data.add(footnotes);
				data.add(date1.getHours() + ":" + date1.getMinutes() + " " + cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1) + "-" + cal.get(Calendar.DATE));
				data.add(sched);
				
				try {
					dao.registerUser("active_meet", columns, data);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				flag = 1;
				RequestDispatcher rd = request.getRequestDispatcher("addmeet.jsp");
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				rd.forward(request, response);
			}
		}
		else {
			Date meet_date = new Date();
			try {
				meet_date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
			if (meet_date.before(new Date())){
				flag = 2;
				RequestDispatcher rd = request.getRequestDispatcher("addmeet.jsp");
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				rd.forward(request, response);
			}
			else {
				ArrayList<String> columns = new ArrayList<String> ();
				ArrayList<String> data = new ArrayList<String> ();
				
				try {
					cust_id = dao.getId("cust_login", "id", uname);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				columns.add("cust_id");
				columns.add("title");
				columns.add("email");
				columns.add("descript");
				columns.add("req_time");
				columns.add("sched_time");
				
				data.add(cust_id);
				data.add(title);
				data.add(email);
				data.add(desc);
				data.add(date1.getHours() + ":" + date1.getMinutes() + " " + cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1) + "-" + cal.get(Calendar.DATE));
				data.add(sched);
				
				try {
					dao.registerUser("active_meet", columns, data);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				flag = 1;
				RequestDispatcher rd = request.getRequestDispatcher("addmeet.jsp");
				response.setContentType("application/json");
				JSONObject json = new JSONObject();
				try {
					json.put("flag", flag);
				} catch(JSONException e) {}
				request.setAttribute("jsonString", json.toString());
				PrintWriter pw = response.getWriter();
				rd.forward(request, response);
			}
		}
	}

}
