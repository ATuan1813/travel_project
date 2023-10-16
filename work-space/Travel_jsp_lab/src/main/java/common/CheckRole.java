package common;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import service.UserService;

public class CheckRole {
	public static boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserService userService = new UserService();
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.getById(userId);
			if(user == null || user.getRole_id() == 2 || user.getStatus().equals("BLOCKED")) {
				response.sendRedirect(request.getContextPath() + "/user-login");
				return false;
			}
		} else {
    		response.sendRedirect(request.getContextPath() + "/user-login");
    		return false;
		}
		return true;
	}
	
	public static boolean isLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		UserService userService = new UserService();
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("userId") != null) {
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.getById(userId);
			if(user == null || user.getStatus().equals("BLOCKED")) {
				return false;
			}
		} else {
    		return false;
		}
		return true;
	}
}
