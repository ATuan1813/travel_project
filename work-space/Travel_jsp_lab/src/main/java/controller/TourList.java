package controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CheckRole;
import dao.TourDAO;
import model.Tour;

public class TourList extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;

	public TourList() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!CheckRole.isAdmin(request, response)) {
			return;
		}
		Long page = 1l;
		Long size = 5l;
		
		String pageStr = request.getParameter("page");
		String sizeStr = request.getParameter("size");
		String keysearch = request.getParameter("keysearch");
		if(keysearch == null || keysearch == "undefined") {
			keysearch = "";
		}
		try {
			page =  Long.parseLong(pageStr);
		}catch(NumberFormatException e) {
		}
		try {
			size = Long.parseLong(sizeStr);
		}catch(NumberFormatException e) {
		}
		if(page < 1) {
			page = 1l;
		}
		if(size < 1) {
			size = 5l;
		}
		Long offset = (page - 1) * size;
		TourDAO tourDao = new TourDAO();
		List<Tour> listTour = tourDao.getAllTourPaging(size, offset, keysearch);
		if(listTour.size() == 0 && page > 1) {
			page -= 1;
			offset = (page - 1) * size;
			listTour = tourDao.getAllTourPaging(size,offset, keysearch);
		}
		List<Integer> sizeOptions = Arrays.asList(5, 10, 25, 100);
		request.setAttribute("listTour", listTour);
		request.setAttribute("sizeOptions", sizeOptions);
		request.setAttribute("keysearch", keysearch);
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/admin/TourList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action.equals("delete")) {
			onPostDelete(request, response);
		} else if(action.equals("search")) {
			onPostSearch(request, response);
		}
	}
	
	private void onPostSearch(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String keysearch = request.getParameter("keysearch");
		response.sendRedirect(request.getContextPath() + "/TourList?keysearch=" + keysearch);
	}
	
	private void onPostDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String tourIdStr = request.getParameter("tourId");
		Long tourId = null;
	    if (tourIdStr != null && !tourIdStr.isEmpty()) {
	        try {
	        	tourId = Long.parseLong(tourIdStr);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    if(tourId != null) {
	    	TourDAO tourDao = new TourDAO();
	    	Tour tourDeleted = tourDao.getTourById(tourId);
	    	String fileName = tourDeleted.getImage();
	    	if(tourDao.deleteTourById(tourId) == true) {
	    		deleteFile(fileName, request.getServletContext());
	    		response.sendRedirect(request.getContextPath() + "/TourList");
	    	}
	    }
	}
	
	
	public boolean deleteFile(String fileName, ServletContext context) {
		String uploadDirectory = context.getRealPath("/public/image");
		String filePath = uploadDirectory + File.separator + fileName;

		File fileToDelete = new File(filePath);
		if (fileToDelete.exists()) {
			return fileToDelete.delete();
		} else {
			return false;
		}
	}
	
}
