package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.UrlManage;
import model.EUserStatus;
import model.User;
import service.PagingService;
import service.UserService;

@WebServlet(value = "/user-login")
public class UserLogin extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
		    session.removeAttribute("userId");
		}
		req.setAttribute("url", new UrlManage());
		req.getRequestDispatcher("/view/admin/UserLogin.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("url", new UrlManage());
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		if(username == null || password == null || username.trim() == "" || password.trim() == "") {
			req.setAttribute("url", new UrlManage());
			req.setAttribute("notify", "Vui Long vui lòng điền đầy đủ thông tin");
		    req.getRequestDispatcher("/view/admin/UserLogin.jsp").forward(req, resp);
		}
		User user = userService.getByUserNameOrEmail(req);
		if(user == null) {
			req.setAttribute("url", new UrlManage());
			req.setAttribute("user", new User(username, password));
			req.setAttribute("notify", "Tên tài khoản hoặc email không chính xác");
		    req.getRequestDispatcher("/view/admin/UserLogin.jsp").forward(req, resp);
		}
		else if(userService.loginUser(user, password) == null) {
			req.setAttribute("url", new UrlManage());
			req.setAttribute("user", new User(username, password));
			req.setAttribute("notify", "Mật khẩu không chính xác");
		    req.getRequestDispatcher("/view/admin/UserLogin.jsp").forward(req, resp);
		}
		else if(userService.loginUser(user, password) != null 
				&& user.getStatus().equals(EUserStatus.BLOCKED.toString())) {
			
			req.setAttribute("url", new UrlManage());
			req.setAttribute("user", new User(username, password));
			req.setAttribute("notify", "Tài khoản của bạn đã bị khóa");
		    req.getRequestDispatcher("/view/admin/UserLogin.jsp").forward(req, resp);
		}
		else if(userService.loginUser(user, password) != null 
				&& user.getStatus().equals(EUserStatus.ACTIVATED.toString())) {
			
			HttpSession session = req.getSession(true);
			session.setAttribute("userId", user.getId());
			if(user.getRole_id() == 2) {
				resp.sendRedirect(req.getContextPath() + "?userId=" + user.getId());
			}else {
				resp.sendRedirect(req.getContextPath() + "/TourList");
			}
		}		
	}
}
