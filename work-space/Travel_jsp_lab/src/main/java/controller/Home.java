package controller;

import java.io.IOException;
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

public class Home extends HttpServlet{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 6021350779392979736L;

	public Home() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isLogin = CheckRole.isLogin(request, response);
		TourDAO tourDao = new TourDAO();
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
		
		List<Tour> listTour = tourDao.getAllTourPaging(5l, 0l, "");
		request.setAttribute("listTour", listTour);
		request.setAttribute("isLogin", isLogin);
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/index.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keysearch = request.getParameter("keysearch");
		String startDate = request.getParameter("startDate");
        response.sendRedirect(request.getContextPath() + "/TourSearch?keysearch=" + keysearch + "&startDate="+startDate);
	}
}
