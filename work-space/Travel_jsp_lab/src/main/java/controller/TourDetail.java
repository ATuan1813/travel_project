package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CheckRole;
import dao.TourDAO;
import model.Tour;

@MultipartConfig(
        fileSizeThreshold = 1024 * 5000,  // 10 KB
        maxFileSize = 1024 * 5000,       // 5 MB
        maxRequestSize = 1024 * 5000    // 5 MB 
)
public class TourDetail extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;
	public TourDetail() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!CheckRole.isAdmin(request, response)) {
			return;
		}
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
	    request.getRequestDispatcher("./view/admin/TourDetail.jsp").forward(request, response);
	}

	
}
