package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CheckRole;
import dao.BookingDAO;
import model.Booking;

public class BookingList extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013716279553262788L;
	public BookingList() {}

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

		BookingDAO bookingDAO = new BookingDAO();
		List<Booking> listBooking = bookingDAO.getAllBookingPaging(size,offset, keysearch);
		if(listBooking.size() == 0 && page > 1) {
			page -= 1;
			offset = (page - 1) * size;
			listBooking = bookingDAO.getAllBookingPaging(size,offset, keysearch);
		}
		List<Integer> sizeOptions = Arrays.asList(5, 10, 25, 100);
		request.setAttribute("sizeOptions", sizeOptions);
		request.setAttribute("listBooking", listBooking);
		request.setAttribute("keysearch", keysearch);
		request.setAttribute("page", page);
		request.setAttribute("size", size);
		response.setContentType("text/html");
	    request.getRequestDispatcher("./view/admin/BookingList.jsp").forward(request, response);
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keysearch = request.getParameter("keysearch");
		response.sendRedirect(request.getContextPath() + "/BookingList?keysearch=" + keysearch);
	}
	

}
