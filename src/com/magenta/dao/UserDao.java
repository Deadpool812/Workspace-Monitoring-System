package com.magenta.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Optional;

import com.magenta.util.DBUtil;
import com.magenta.util.HashUtil;


public class UserDao {
	
	public UserDao() {
		
	}
	
	public void registerUser(String tablename, ArrayList<String> tabledata) throws Exception {
		String sSql = "insert into " + tablename + " values (";
		for(String s : tabledata) {
			sSql = sSql.concat("'" + s + "',");
		}
		String sql = sSql.substring(0, sSql.length() - 1);
		sql = sql.concat(")");
		DBUtil.executeUpdate(sql);
	}
	
	public void registerUser(String tablename, ArrayList<String> columns, ArrayList<String> tabledata) throws Exception {
		String xSql = "insert into " + tablename + " (";
		for(String c : columns) {
			xSql = xSql.concat(c + ",");
		}
		String sSql = xSql.substring(0, xSql.length() - 1);
		sSql = sSql.concat(") values (");
		for(String s : tabledata) {
			sSql = sSql.concat("'" + s + "',");
		}
		String sql = sSql.substring(0, sSql.length() - 1);
		sql = sql.concat(")");
		DBUtil.executeUpdate(sql);
	}
	
	public boolean authenticate(String tablename, String username, String password) throws Exception {
		boolean authenticated = false;
		String sql = "select username, password, salt, count(username) as count from " + tablename +
				" where username='" + username + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			int count=rs.getInt("count");
			if(count>0) {
				String user = rs.getString("username");
				String pass = rs.getString("password");
				String salt = rs.getString("salt");
				
				Optional<String> str = HashUtil.hashPassword(password, salt);
				if(str.isPresent()) {
					if(user.equals(username) && pass.equals(str.get())) {
						authenticated = true;
					}
					else {
						authenticated = false;
					}
				}
			}
			else {
				authenticated = false;
			}
		}
		return authenticated;
	}
	
	public String getDesignation(String username, String password) throws Exception {
		String designation = null;
		String sql = "select username, password, designation, salt, count(username) as count from login_data "
				+ "where username='" + username + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			String user = rs.getString("username");
			String pass = rs.getString("password");
			String salt = rs.getString("salt");
			designation = rs.getString("designation");
			
			Optional<String> str = HashUtil.hashPassword(password, salt);
			if(str.isPresent()) {
				if(user.equals(username) && pass.equals(str.get())) {
					return designation;
				}
			}
		}
		return null;
	}
	
	public String getFirstname(String username, String password) throws Exception {
		String firstname = null;
		String sql = "select firstname, username, password, salt, count(username) as count from login_data "
				+ "where username='" + username + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			String user = rs.getString("username");
			String pass = rs.getString("password");
			String salt = rs.getString("salt");
			firstname = rs.getString("firstname");
			
			Optional<String> str = HashUtil.hashPassword(password, salt);
			if(str.isPresent()) {
				if(user.equals(username) && pass.equals(str.get())) {
					return firstname;
				}
			}
		}
		return null;
	}
	
	public String getLastname(String username, String password) throws Exception {
		String lastname = null;
		String sql = "select lastname, username, password, salt, count(username) as count from login_data "
				+ "where username='" + username + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			String user = rs.getString("username");
			String pass = rs.getString("password");
			String salt = rs.getString("salt");
			lastname = rs.getString("lastname");
			
			Optional<String> str = HashUtil.hashPassword(password, salt);
			if(str.isPresent()) {
				if(user.equals(username) && pass.equals(str.get())) {
					return lastname;
				}
			}
		}
		return null;
	}
	
	public boolean isExist(String tablename, String username) throws Exception {
		boolean exist = false;
		String sql = "select count(username) as count from " + tablename + " where username='" + username + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			int count = rs.getInt("count");
			if(count>0) {
				exist = true;
			}
		}
		return exist;
	}
	
	public boolean managerExist(String firstname, String lastname) throws Exception {
		boolean exist = false;
		String sql = "select count(man_id) as count from man_data where firstname='" + firstname + "'" + " and lastname='" + lastname + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			int count = rs.getInt("count");
			if(count>0) {
				exist = true;
			}
		}
		return exist;
	}
	
	public boolean companyExist(String coname) throws Exception {
		boolean exist = false;
		String sql = "select count(username) as count from cust_login where username='" + coname + "'";
		ResultSet rs = DBUtil.executeQuery(sql);
		while(rs.next()) {
			int count = rs.getInt("count");
			if(count>0) {
				exist = true;
			}
		}
		return exist;
	}
	
	public String getId(String tablename, String colname, String username) {
		String sql = "select " + colname + ", count(username) as count from " + tablename + " where username='" + username + "'";
		ResultSet rs;
		try {
			rs = DBUtil.executeQuery(sql);
		
			String id = null;
			while(rs.next()) {
				int count = rs.getInt("count");
				if(count==0) {
					return null;
				}
				id = rs.getString(colname);
			}
			return id;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
