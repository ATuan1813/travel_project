package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CheckRole;
import dao.TourDAO;
import dao.UserDao;
import model.Tour;
import model.User;

public class TourSearch extends HttpServlet{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 6021350779392979736L;

	public TourSearch() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isLogin = CheckRole.isLogin(request, response);
		String keysearch = request.getParameter("keysearch");
		String startDateStr = request.getParameter("startDate");
		Date startDate = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if(startDateStr != null) {
		    try {
		        startDate = new java.sql.Date(dateFormat.parse(startDateStr).getTime());
		    } catch (ParseException e) {
		        
		    }
		}
		if(keysearch == null) {
			keysearch = "";
		}
		// Passing false to not create a new session if it doesn't exist
		HttpSession session = request.getSession(false); 
		if (session != null) {
		    Object userIdObj = session.getAttribute("userId");
		    if (userIdObj instanceof Long) {
		        Long userId = (Long) userIdObj;
		        UserDao userDao = new UserDao();
		        User user = userDao.getById(userId);
		        request.setAttribute("user", user);
		    }
		}
		
		TourDAO tourDao = new TourDAO();
		List<Tour> listTour = tourDao.getSearchTourPaging(keysearch, startDate);
		request.setAttribute("listTour", listTour);
		request.setAttribute("isLogin", isLogin);
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/tour.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keysearch = request.getParameter("keysearch");
		String startDate = request.getParameter("startDate");
        response.sendRedirect(request.getContextPath() + "/TourSearch?keysearch=" + keysearch + "&startDate="+startDate);
	}
}
