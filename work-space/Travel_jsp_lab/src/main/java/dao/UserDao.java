package dao;

import java.util.List;

import mapper.UserMapper;
import model.EUserStatus;
import model.User;

public class UserDao extends PersonDao{
	
	public Boolean checkExistUser(String username, String email) {
		Boolean result = true;
		String query = "SELECT CASE WHEN EXISTS(SELECT 1 FROM user WHERE user.username = ? "
				+ "OR user.email = ?) THEN TRUE ELSE FALSE END AS RESULT";	
		result = checkExistUser(query, username, email);
		return result;
	}
	
	public User getByUsernameOrEmail(String username) {
		User result = new User();
		String query = "SELECT * FROM user WHERE username = ? OR email = ?";
		result = getByAny(query, new UserMapper(), username, username);
		return result;
	}
	
	public int adduser(User user) {
        String query = "INSERT INTO user(username, password, email, full_name, "
        		+ "phone_number, address, status, role_id) "
        		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return insert(query, user.getUsername(), user.getPassword(), user.getEmail(), user.getFullName(),
        		user.getPhoneNumber(), user.getAddress(), user.getStatus(), user.getRole_id());
    }
	
	public int updateUser(User user) {
        String query = "UPDATE user SET username = ?, password = ?, email = ?, full_name = ?, "
        		+ "phone_number = ?, address = ?, status = ?, role_id = ? WHERE id = ?";
        return update(query, user.getUsername(), user.getPassword(), user.getEmail(), user.getFullName(),
        		user.getPhoneNumber(), user.getAddress(), user.getStatus(), user.getRole_id(), user.getId());
    }
	
	public User setBlockedUser(Long userId) {
        String query = "UPDATE user SET status = ? WHERE id = ?";
        update(query, EUserStatus.BLOCKED.name(), userId);
        
        String queryGetById = "SELECT * FROM user WHERE id = ?";
        return getByAny(queryGetById, new UserMapper() , userId);
    }
	
	public User setOpenUser(Long userId) {
        String query = "UPDATE user SET status = ? WHERE id = ?";
        update(query, EUserStatus.ACTIVATED.name(), userId);
        
        String queryGetById = "SELECT * FROM user WHERE id = ?";
        return getByAny(queryGetById, new UserMapper() , userId);
    }
	
	public User deleteUserNotUser(Long userId) {
        String query = "UPDATE user SET status = ? WHERE id = ?";
        update(query, EUserStatus.BLOCKED.name(), userId);
        
        String queryGetById = "SELECT * FROM user WHERE id = ?";
        return getByAny(queryGetById, new UserMapper() , userId);
    }
	
	public User getById(Long userId) {
        String query = "SELECT * FROM user WHERE id = ?";
        return getByAny(query, new UserMapper() , userId);
    }
	
	public List<User> getAll(Long offset, Long size) {
        String query = "SELECT * FROM user ORDER BY user.id LIMIT ? OFFSET ?";
        return queryGetAllPaging(query, new UserMapper(), size, offset);
    }
	
	public int countGetAll() {
        String query = "SELECT COUNT(*) FROM user";
        return queryCount(query);
    }
	
	public List<User> searchByUsername(String keyword, Long offset, Long size){
		String searchWith = "user.username";
		String query = "SELECT * FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%') ORDER BY user.id LIMIT ? OFFSET ?";
		
		return queryGetAllPaging(query, new UserMapper(), keyword, size, offset);
	}
	
	public int countByUsername(String keyword) {
		String searchWith = "user.username";
		String query = "SELECT COUNT(*) FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%')";
        return queryCount(query, keyword);
    }
	
	public List<User> searchByFullName(String keyword, Long offset, Long size){
		String searchWith = "user.full_name";
		String query = "SELECT * FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%') ORDER BY user.id LIMIT ? OFFSET ?";
		
		return queryGetAllPaging(query, new UserMapper(), keyword, size, offset);
	}
	
	public int countByFullName(String keyword) {
		String searchWith = "user.full_name";
		String query = "SELECT COUNT(*) FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%')";
        return queryCount(query, keyword);
    }
	
	
	public List<User> searchByEmail(String keyword, Long offset, Long size){
		String searchWith = "user.email";
		String query = "SELECT * FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%') ORDER BY user.id LIMIT ? OFFSET ?";
		return queryGetAllPaging(query, new UserMapper(), keyword, size, offset);
	}
	
	public int countByEmail(String keyword) {
		String searchWith = "user.email";
		String query = "SELECT COUNT(*) FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%')";
        return queryCount(query, keyword);
    }
	
	public List<User> searchByPhoneNumber(String keyword, Long offset, Long size){
		String searchWith = "user.phone_number";
		String query = "SELECT * FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%') ORDER BY user.id LIMIT ? OFFSET ?";
		
		return queryGetAllPaging(query, new UserMapper(), keyword, size, offset);
	}
	
	public int countByPhoneNumber(String keyword) {
		String searchWith = "user.phone_number";
		String query = "SELECT COUNT(*) FROM user WHERE "+ searchWith +" LIKE CONCAT('%', ? ,'%')";
        return queryCount(query, keyword);
    }
	
	public User deleteUser(Long userId) {
		
		String queryRelated = "SELECT COUNT(*) FROM (SELECT user_id FROM booking UNION ALL "
				+ "SELECT user_id FROM comment UNION ALL "
				+ "SELECT user_id FROM rate) AS related_tables WHERE user_id = ?";		
		int countRelate = queryCount(queryRelated, userId);	
		if(countRelate > 0) return null;
		
        String queryGetById = "SELECT * FROM user WHERE id = ?";
		User user = getByAny(queryGetById, new UserMapper() , userId);
		
        String query = "DELETE FROM user WHERE id = ?";
        update(query, userId);
        
        return user;
    } 

}
