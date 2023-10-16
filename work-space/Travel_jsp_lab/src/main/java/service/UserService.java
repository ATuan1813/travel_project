package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.UserDao;
import model.EUserStatus;
import model.Paging;
import model.User;

public class UserService {

	UserDao userDao = new UserDao();
	
	public Boolean checkExistUser(HttpServletRequest request) {
		Boolean result = true;
		String username = request.getParameter("username");
		String email = request.getParameter("email");

		result = userDao.checkExistUser(username, email);
		return result;
	}
	
	public User loginUser(User user, String password) {	
		if(user == null) {
			return null;
		}
		if(user.getPassword().equals(password.trim())) {
			return user;
		}
		return null;
	}

	public int addUser(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String full_name = request.getParameter("fullName");
		String phone_number = request.getParameter("phoneNumber");
		String address = request.getParameter("address");
		Long role_id = Long.parseLong(request.getParameter("role"));
		String status = EUserStatus.ACTIVATED.name();
		
		User user = new User(username, password, email, full_name, phone_number, address, status, role_id);
		int userId = userDao.adduser(user);
		return userId;
	}
	
	public int registerUser(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String full_name = request.getParameter("fullName");
		String phone_number = request.getParameter("phoneNumber");
		String address = request.getParameter("address");
		address = "HCM";
		Long role_id = 2l;
		String status = EUserStatus.ACTIVATED.name();
		
		User user = new User(username, password, email, full_name, phone_number, address, status, role_id);
		int userId = userDao.adduser(user);
		return userId;
	}
	
	public int updateUserByUser(HttpServletRequest request) {
		User getUser = userDao.getById(Long.parseLong(request.getParameter("id")));
		Long userId = getUser.getId();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String full_name = request.getParameter("fullName");
		String phone_number = request.getParameter("phoneNumber");
		String address = request.getParameter("address");
		String status = getUser.getStatus();
		Long role_id = 2l;

		getUser = new User(userId, username, password, email, full_name, phone_number, address, status, role_id);
		int userIdUpdate = userDao.updateUser(getUser);
		return userIdUpdate;
	}

	public int updateUser(HttpServletRequest request) {
		User getUser = userDao.getById(Long.parseLong(request.getParameter("id")));
		Long userId = getUser.getId();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String full_name = request.getParameter("fullName");
		String phone_number = request.getParameter("phoneNumber");
		String address = request.getParameter("address");
		String status = getUser.getStatus();
		Long role_id = Long.parseLong(request.getParameter("role"));

		getUser = new User(userId, username, password, email, full_name, phone_number, address, status, role_id);
		int userIdUpdate = userDao.updateUser(getUser);
		return userIdUpdate;
	}

	public User blockedUser(Long userId) {
		User user = userDao.setBlockedUser(userId);
		return user;
	}
	
	public User openUser(Long userId) {
		User user = userDao.setOpenUser(userId);
		return user;
	}
	
	public User deleteUser(Long userId) {
		User user = userDao.deleteUser(userId);
		return user;
	}

	public User getById(HttpServletRequest request) {
		Long userId = Long.parseLong(request.getParameter("id"));

		User user = userDao.getById(userId);
		return user;
	}
	public User getById(Long userId) {
		User user = userDao.getById(userId);
		return user;
	}
	
	public User findById(Long userId) {
		User user = userDao.getById(userId);
		return user;
	}
	
	public User getByUserNameOrEmail(HttpServletRequest request) {
		User result = new User();
		String username = request.getParameter("username");

		result = userDao.getByUsernameOrEmail(username);
		return result;
	}

	public List<User> getAll(Long offset, Long size) {
		List<User> users = userDao.getAll(offset, size);
		return users;
	}

	public List<User> searchByUsername(String keyword, Long offset, Long size){
		List<User> users = userDao.searchByUsername(keyword, offset, size);		
		return users;
	}
	
	public int countByUsername(HttpServletRequest request){
		String keyword  = request.getParameter("keyword");
		int result = userDao.countByUsername(keyword);
		
		return result;
	}
	
	public List<User> searchByFullname(String keyword, Long offset, Long size){
		List<User> users = userDao.searchByFullName(keyword, offset, size);
		return users;
	}
	
	public int countByFullname(HttpServletRequest request){
		String keyword  = request.getParameter("keyword");
		int result = userDao.countByFullName(keyword);
		
		return result;
	}
	
	public List<User> searchByPhoneNumber(String keyword, Long offset, Long size){
		List<User> users = userDao.searchByPhoneNumber(keyword, offset, size);
		return users;
	}
	
	public int countByPhoneNumber(HttpServletRequest request){
		String keyword  = request.getParameter("keyword");
		int result = userDao.countByPhoneNumber(keyword);
		return result;
	}
	
	public List<User> searchByEmail(String keyword, Long offset, Long size){
		List<User> users = userDao.searchByEmail(keyword, offset, size);
		return users;
	}
	
	public int countByEmail(HttpServletRequest request){
		String keyword  = request.getParameter("keyword");
		int result = userDao.countByEmail(keyword);
		
		return result;
	}
	
	

}
