package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CheckRole;
import dao.BookingDAO;
import dao.TourDAO;
import model.Tour;

@MultipartConfig(
        fileSizeThreshold = 1024 * 5000,  // 10 KB
        maxFileSize = 1024 * 5000,       // 5 MB
        maxRequestSize = 1024 * 5000    // 5 MB 
)
public class BookingDetail extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;
	public BookingDetail() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tourIdStr = request.getParameter("tourId");
		
		Long tourId = null;
	    if (tourIdStr != null && !tourIdStr.isEmpty()) {
	        try {
	        	tourId = Long.parseLong(tourIdStr);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    TourDAO tourDao = new TourDAO();
	    Tour tour = tourDao.getTourById(tourId);
		
	    request.setAttribute("tour", tour);
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/BookingDetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    if(!CheckRole.isLogin(request, response)) {
	    	 response.sendRedirect(request.getContextPath() + "/user-login");
	    	 return;
	    }
		HttpSession session = request.getSession(false);
		Long userId = (Long) session.getAttribute("userId");
		
	    String quantityAdultStr = request.getParameter("quantityAdult");
	    String quantityChildStr = request.getParameter("quantityChild");
	    String tourIdStr = request.getParameter("tourId");

	    Long quantityAdult = Long.parseLong(quantityAdultStr);
	    Long quantityChild = Long.parseLong(quantityChildStr);
	    Long tourId = Long.parseLong(tourIdStr);
	    BookingDAO bookingDao = new BookingDAO();
	    Boolean result = bookingDao.insertBooking(quantityAdult, quantityChild, userId, tourId);
	    if(result == true) {
	    	 response.sendRedirect(request.getContextPath()+"/acc-user-detail?userId=" + userId);
	    }
	}
	
}
