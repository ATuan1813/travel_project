package controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.UrlManage;
import model.User;
import service.UserService;

@WebServlet(value = "/user-register")
public class UserRegister extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("url", new UrlManage());
		
		req.getRequestDispatcher("/view/admin/UserRegister.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String full_name = req.getParameter("fullName");
		String phone_number = req.getParameter("phoneNumber");
		Long role_id = null;
		if(req.getParameter("role") != null) {
			 role_id = Long.parseLong(req.getParameter("role"));
		}
				
		if(username == null || email == null || password == null || 
				full_name == null || phone_number == null) {
			
			req.setAttribute("url", new UrlManage());
			req.setAttribute("notify", "Vui lòng nhập đầy đủ thông tin");
		    req.getRequestDispatcher("/view/admin/UserRegister.jsp").forward(req, resp);

		}
		if(userService.checkExistUser(req)==true) {
			User user = new User(username, password, email, full_name, phone_number, null, role_id);
			req.setAttribute("user", user);
			req.setAttribute("url", new UrlManage());
			req.setAttribute("notify", "Tên tài khoản hoặc email đã tồn tại");
		    req.getRequestDispatcher("/view/admin/UserRegister.jsp").forward(req, resp);

		}else {
			userService.registerUser(req);
	        resp.sendRedirect(UrlManage.getUserList());
		}
	}
}
