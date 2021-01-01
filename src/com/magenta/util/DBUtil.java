package com.magenta.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	private static Connection conn;
	private static final String url = "jdbc:mysql://localhost:3306/logindb";
	private static final String user = "root";
	private static final String pass = "chaitanya";
	
	private static Connection getConnection() {
		if (conn != null) {
			return conn;
		}
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static ResultSet executeQuery(String sql) throws Exception {
		Statement st = getConnection().createStatement();
		ResultSet rs = st.executeQuery(sql);
		return rs;
	}
	
	public static void executeUpdate(String sql) throws Exception {
		Statement st = getConnection().createStatement();
		st.executeUpdate(sql);
	}
}
