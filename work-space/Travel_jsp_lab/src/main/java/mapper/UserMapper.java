package mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;

public class UserMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet resultSet) {
		
		try {
			User user = new User(
				resultSet.getLong("id"),
				resultSet.getString("username"), 
				resultSet.getString("password"), 
				resultSet.getString("email"), 
				resultSet.getString("full_name"), 
				resultSet.getString("phone_number"),
				resultSet.getString("address"),
				resultSet.getString("status"),
				resultSet.getLong("role_id"));
			return user;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
