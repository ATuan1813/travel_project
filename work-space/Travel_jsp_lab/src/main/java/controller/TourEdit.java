package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import common.CheckRole;
import dao.TourDAO;
import model.Tour;

@MultipartConfig(
        fileSizeThreshold = 1024 * 5000,  // 10 KB
        maxFileSize = 1024 * 5000,       // 5 MB
        maxRequestSize = 1024 * 5000    // 5 MB 
)
public class TourEdit extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;
	public TourEdit() {}

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
	    request.getRequestDispatcher("./view/admin/TourEdit.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    TourDAO tourDao = new TourDAO();
	    String tourIdStr = request.getParameter("tourId");
	    String tripName = request.getParameter("tripName");
	    String priceStr = request.getParameter("price");
	    String startDateStr = request.getParameter("startDate");
	    String endDateStr = request.getParameter("endDate");
	    String address = request.getParameter("address");
	    String description = request.getParameter("description");
	   
	    Long price = null;
	    Long tourId = null;
	    if (priceStr != null && !priceStr.isEmpty()) {
	        try {
	            price = Long.parseLong(priceStr);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
	    }
	    if (tourIdStr != null && !tourIdStr.isEmpty()) {
	        try {
	        	tourId = Long.parseLong(tourIdStr);
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	        }
	    }
	    Tour oldTour = tourDao.getTourById(tourId);

	    java.sql.Date startDate = null;
	    java.sql.Date endDate = null;
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    try {
	        startDate = new java.sql.Date(dateFormat.parse(startDateStr).getTime());
	        endDate = new java.sql.Date(dateFormat.parse(endDateStr).getTime());
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    
	    Part filePart = request.getPart("image");
	    String fileName = null; 
	    if (filePart != null && filePart.getSize() > 0) {
	        fileName = writeFile(filePart, request.getServletContext());
	        deleteFile(oldTour.getImage(), request.getServletContext());
	    }else {
	    	fileName = oldTour.getImage();
	    }
	    Tour tour = new Tour();
	    tour.setId(tourId);
	    tour.setName(tripName);
	    tour.setPrice(price);
	    tour.setAddress(address);
	    tour.setDescription(description);
	    tour.setStartDate(startDate);
	    tour.setEndDate(endDate);
	    tour.setImage(fileName);
	    
	   
	    if(tourDao.updateTour(tour)) {
	        response.sendRedirect(request.getContextPath() + "/TourList");
	    }
	}

	private String writeFile(Part filePart, ServletContext context) {
		String uploadDirectory = context.getRealPath("/public/image"); 

		String uniqueFileName = UUID.randomUUID().toString() + ".png";
		String filePath = uploadDirectory + File.separator + uniqueFileName;
		try (InputStream inputStream = filePart.getInputStream();
		     FileOutputStream outputStream = new FileOutputStream(filePath)) {
		    byte[] buffer = new byte[4096];
		    int bytesRead;
		    while ((bytesRead = inputStream.read(buffer)) != -1) {
		        outputStream.write(buffer, 0, bytesRead);
		    }
		} catch (IOException e) {
			e.printStackTrace();
		}
		return uniqueFileName;
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
