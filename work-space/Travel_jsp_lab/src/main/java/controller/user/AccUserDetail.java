package controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;
import model.Booking;
import model.User;
import service.UserService;

@WebServlet(value = "/acc-user-detail")
public class AccUserDetail extends HttpServlet{
	
	/**
	 * 
	 */
	UserService service = new UserService();
	BookingDAO bookingDAO = new BookingDAO();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idStr = req.getParameter("userId");
		HttpSession session = req.getSession(false);
		if(idStr != null && session != null) {
			Object object = session.getAttribute("userId");
			if(object instanceof Long) {
				Long userId2 = (Long) object;
				Long userId = Long.parseLong(idStr);
				Long id1 = userId;
				Long id2 = userId2;
				if(id1 != id2) {
					resp.sendRedirect("./");
				}else {
					User user =  service.getById(req);
					
					List<Booking> bookings = bookingDAO.getByUserId(user.getId());
					req.setAttribute("listBooking", bookings);
					req.setAttribute("user", user);	
					req.getRequestDispatcher("./view/UserDetail.jsp").forward(req, resp);
				}
			}
		}
	}
}
