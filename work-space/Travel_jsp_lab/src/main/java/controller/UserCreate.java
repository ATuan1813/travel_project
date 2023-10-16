package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserCreate extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;
	public UserCreate() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/admin/UserCreate.jsp").forward(request, response);
	}
	
}
