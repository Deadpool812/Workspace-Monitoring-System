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
import com.magenta.util.DBUtil;

/**
 * Servlet implementation class Reschedule
 */
@WebServlet("/Reschedule")
public class Reschedule extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reschedule() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				HttpSession session = request.getSession();
				
				String meet_id = request.getParameter("meet_id");
				String date = request.getParameter("sched-date");
				String time = request.getParameter("sched-time");
				String emp_id =request.getParameter("emp_id");
				
				String sched = time + " " + date;
				
				String uname = (String) session.getAttribute("username");
				String cust_id = null;
				
				UserDao dao = new UserDao();
				
				Date date1 = new Date();
				Calendar cal = Calendar.getInstance();
				String sql = new String();
				
				int flag=0;
				
				Date meet_date = new Date();
				try {
					meet_date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} 
				if (meet_date.before(new Date())){
					flag = 2;
					RequestDispatcher rd1 = request.getRequestDispatcher("reschedule.jsp");
					response.setContentType("application/json");
					JSONObject json = new JSONObject();
					try {
						json.put("flag", flag);
					} catch(JSONException e) {}
					request.setAttribute("jsonString", json.toString());
					rd1.forward(request, response);
				}
				else {
					if(emp_id!=null) {
						sql = "update active_meet set sched_time = '" + sched + "' where meet_id = '" + meet_id + "'";
					}
					else {
						sql = "update active_meet set sched_time = '" + sched + 
								"', status='Assigned', completed='0'" +
								" where meet_id = '" + meet_id + "'";
					}
					
					try {
						DBUtil.executeUpdate(sql);
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					
					flag = 1;
					RequestDispatcher rd = request.getRequestDispatcher("cust_meet.jsp");
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
