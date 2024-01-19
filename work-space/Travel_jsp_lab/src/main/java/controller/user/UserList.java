package controller.user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CheckRole;
import common.UrlManage;
import model.Paging;
import model.User;
import service.PagingService;
import service.UserService;

@WebServlet(value = "/user-list")
public class UserList extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserService userService = new UserService();
	private PagingService<User> pagingService = new PagingService<>();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(!CheckRole.isAdmin(req, resp)) {
			return;
		}
		HttpSession session = req.getSession(false);
		Long userId = (Long) session.getAttribute("userId");
		Long page = 1l;
		Long size = 5l;
		int searchType = 1;
		String pageStr = req.getParameter("page");
		String sizeStr = req.getParameter("size");
		String keysearch = req.getParameter("keysearch");
		String searchTypeStr = req.getParameter("searchType");
		if (keysearch == null || keysearch == "undefined") {
			keysearch = "";
		}else {
			keysearch = keysearch.trim();
		}
		if (searchTypeStr == null || searchTypeStr == "undefined") {
			searchTypeStr = "1";
		}
		try {
			searchType = Integer.parseInt(searchTypeStr);
		} catch (NumberFormatException e) {
		}
		try {
			page = Long.parseLong(pageStr);
		} catch (NumberFormatException e) {
		}
		try {
			size = Long.parseLong(sizeStr);
		} catch (NumberFormatException e) {
		}
		if (page < 1) {
			page = 1l;
		}
		if (size < 1) {
			size = 5l;
		}
		Long offset = (page - 1) * size;
		List<User> users = new ArrayList<User>();
		if(!keysearch.isEmpty()) {
			users = search(searchType, keysearch, offset, size);
		}else {
			users = userService.getAll(offset, size);
		}
		if (users.size() == 0 && page > 1) {
			page -= 1;
			offset = (page - 1) * size;
			if(!keysearch.isEmpty()) {
				users = search(searchType, keysearch, offset, size);
			}else {
				users = userService.getAll(offset, size);
			}
		}
		UrlManage url = new UrlManage();
		List<Integer> sizeOptions = Arrays.asList(5, 10, 25, 100);
		req.setAttribute("sizeOptions", sizeOptions);
		req.setAttribute("keysearch", keysearch);
		req.setAttribute("searchType", searchType);
		req.setAttribute("page", page);
		req.setAttribute("size", size);
		req.setAttribute("users", users);
		req.setAttribute("userId", userId);
		req.setAttribute("url", url);
		req.getRequestDispatcher("/view/admin/UserList.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action.equals("search")) {
			doPostSearch(request, response);
		}	
		if(action.equals("delete")) {
			doPostDelete(request, response);
		}	
		if(action.equals("lock")) {
			doPostLock(request, response);
		}	
		if(action.equals("open")) {
			doPostOpen(request, response);
		}	
	}
	
	private void doPostSearch(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		response.sendRedirect(request.getContextPath() + "/user-list?keysearch=" + keyword + "&searchType=" + searchType);
	}

	private void doPostDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idDeleteStr = request.getParameter("id");
		Long idDelete = Long.parseLong(idDeleteStr);
		userService.deleteUser(idDelete);
		response.sendRedirect(request.getContextPath() + "/user-list");
	}
	
	private void doPostLock(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idBlockStr = request.getParameter("id");
		Long idBlock = Long.parseLong(idBlockStr);
		userService.blockedUser(idBlock);
		response.sendRedirect(request.getContextPath() + "/user-list");
	}
	
	private void doPostOpen(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String idOpenStr = request.getParameter("id");
		Long idOpen = Long.parseLong(idOpenStr);
		userService.openUser(idOpen);
		response.sendRedirect(request.getContextPath() + "/user-list");
	}
	
	private List<User> search(int searchType, String keyword, Long offset, Long size) {
		List<User> users = new ArrayList<>();
		if (searchType == 1) {
			users = userService.searchByUsername(keyword, offset, size);
		}
		if (searchType == 2) {
			users = userService.searchByEmail(keyword, offset, size);
		}
		if (searchType == 3) {
			users = userService.searchByPhoneNumber(keyword, offset, size);
		}
		if (searchType == 4) {
			users = userService.searchByFullname(keyword, offset, size);
		}
		return users;
	}
}
