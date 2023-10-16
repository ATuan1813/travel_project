package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CheckRole;
import common.UrlManage;
import dao.TourDAO;
import model.Tour;
import model.User;
import service.UserService;

@WebServlet(value = "/user-update")
public class UserUpdate extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(!CheckRole.isAdmin(req, resp)) {
			return;
		}
		String idStr = req.getParameter("id");

		User user = new User();
		if (idStr != null && !idStr.isEmpty()) {
			user = userService.getById(req);
		}
		
		req.setAttribute("url", new UrlManage());
		req.setAttribute("user", user);
		resp.setContentType("text/html");
		req.getRequestDispatcher("./view/admin/UserUpdate.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		userService.updateUser(req);

        resp.sendRedirect(UrlManage.getUserList());
	}
}
