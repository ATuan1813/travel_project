package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DbContext;
import model.Tour;

public class TourDAO {
	public List<Tour> getAllTour() {
		List<Tour> listTour = new ArrayList<>();
		Connection con = null;
		DbContext db = new DbContext();
		try {
			con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM tour");
			while (rs.next()) {
				Tour tour = new Tour();
				tour.setId(rs.getLong("id"));
				tour.setName(rs.getString("name"));
				tour.setImage(rs.getString("image"));
				tour.setDescription(rs.getString("description"));
				tour.setPrice(rs.getLong("price"));
				tour.setStartDate(rs.getDate("start_day"));
				tour.setEndDate(rs.getDate("end_day"));
				tour.setStatus(rs.getBoolean("status"));
				tour.setAddress(rs.getString("address"));
				listTour.add(tour);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTour;
	}
	
	public List<Tour> getAllTourPaging(Long limit, Long offset, String keysearch) {
		List<Tour> listTour = new ArrayList<>();
		Connection con = null;
		DbContext db = new DbContext();
		try {
			con = db.getConnection();
			String query = "SELECT * FROM tour WHERE tour.name LIKE ? ORDER BY start_day DESC LIMIT ? OFFSET ?";
	        PreparedStatement pstmt = con.prepareStatement(query);
	        pstmt.setString(1, "%" + keysearch + "%");
	        pstmt.setLong(2, limit);
	        pstmt.setLong(3, offset);
	        ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Tour tour = new Tour();
				tour.setId(rs.getLong("id"));
				tour.setName(rs.getString("name"));
				tour.setImage(rs.getString("image"));
				tour.setDescription(rs.getString("description"));
				tour.setPrice(rs.getLong("price"));
				tour.setStartDate(rs.getDate("start_day"));
				tour.setEndDate(rs.getDate("end_day"));
				tour.setStatus(rs.getBoolean("status"));
				tour.setAddress(rs.getString("address"));
				listTour.add(tour);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listTour;
	}

	public Tour getTourById(long tourId) {
		Connection con = null;
		DbContext db = new DbContext();
		Tour tour = null;

		try {
			con = db.getConnection();
			String selectQuery = "SELECT * FROM tour WHERE id = ?";
			PreparedStatement preparedStatement = con.prepareStatement(selectQuery);
			preparedStatement.setLong(1, tourId);
			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				tour = new Tour();
				tour.setId(rs.getLong("id"));
				tour.setName(rs.getString("name"));
				tour.setImage(rs.getString("image"));
				tour.setDescription(rs.getString("description"));
				tour.setPrice(rs.getLong("price"));
				tour.setStartDate(rs.getDate("start_day"));
				tour.setEndDate(rs.getDate("end_day"));
				tour.setStatus(rs.getBoolean("status"));
				tour.setAddress(rs.getString("address"));
			}

			rs.close();
			preparedStatement.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return tour;
	}

	public boolean insertTour(Tour tour) {
		Connection con = null;
		DbContext db = new DbContext();
		PreparedStatement preparedStatement = null;

		try {
			con = db.getConnection();
			String insertQuery = "INSERT INTO tour (name, image, description, price, status, start_day, end_day, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(insertQuery);
			preparedStatement.setString(1, tour.getName());
			preparedStatement.setString(2, tour.getImage());
			preparedStatement.setString(3, tour.getDescription());
			preparedStatement.setLong(4, tour.getPrice());
			preparedStatement.setBoolean(5, tour.getStatus());
			preparedStatement.setDate(6, tour.getStartDate());
			preparedStatement.setDate(7, tour.getEndDate());
			preparedStatement.setString(8, tour.getAddress());

			int rowsAffected = preparedStatement.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				preparedStatement.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public boolean updateTour(Tour tour) {
	    Connection con = null;
	    DbContext db = new DbContext();
	    PreparedStatement preparedStatement = null;

	    try {
	        con = db.getConnection();
	        String updateQuery = "UPDATE tour SET name=?, image=?, description=?, price=?, status=?, start_day=?, end_day=?, address=? WHERE id=?";
	        preparedStatement = con.prepareStatement(updateQuery);
	        preparedStatement.setString(1, tour.getName());
	        preparedStatement.setString(2, tour.getImage());
	        preparedStatement.setString(3, tour.getDescription());
	        preparedStatement.setLong(4, tour.getPrice());
	        preparedStatement.setBoolean(5, tour.getStatus());
	        preparedStatement.setDate(6, tour.getStartDate());
	        preparedStatement.setDate(7, tour.getEndDate());
	        preparedStatement.setString(8, tour.getAddress());
	        preparedStatement.setLong(9, tour.getId()); 

	        int rowsAffected = preparedStatement.executeUpdate();
	        return rowsAffected > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        try {
	            preparedStatement.close();
	            con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}


	public boolean deleteTourById(Long tourId) {
		Connection con = null;
		DbContext db = new DbContext();
		PreparedStatement preparedStatement = null;

		try {
			con = db.getConnection();
			String deleteQuery = "DELETE FROM tour WHERE id = ?";
			preparedStatement = con.prepareStatement(deleteQuery);
			preparedStatement.setLong(1, tourId);

			int rowsAffected = preparedStatement.executeUpdate();
			return rowsAffected > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				preparedStatement.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Tour> getSearchTourPaging(String keysearch, Date startDate) {
	    List<Tour> listTour = new ArrayList<>();
	    Connection con = null;
	    DbContext db = new DbContext();
	    try {
	        con = db.getConnection();
	        String query = "SELECT * FROM tour WHERE tour.name LIKE ?";
	        
	        if (startDate != null) {
	            query += " AND tour.start_day = ?";
	        }

	        query += " ORDER BY start_day DESC";
	        
	        PreparedStatement pstmt = con.prepareStatement(query);
	        pstmt.setString(1, "%" + keysearch + "%");
	        
	        if (startDate != null) {
	            pstmt.setDate(2, new java.sql.Date(startDate.getTime()));
	        } 
	        
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
				Tour tour = new Tour();
				tour.setId(rs.getLong("id"));
				tour.setName(rs.getString("name"));
				tour.setImage(rs.getString("image"));
				tour.setDescription(rs.getString("description"));
				tour.setPrice(rs.getLong("price"));
				tour.setStartDate(rs.getDate("start_day"));
				tour.setEndDate(rs.getDate("end_day"));
				tour.setStatus(rs.getBoolean("status"));
				tour.setAddress(rs.getString("address"));
				listTour.add(tour);
			}
	        rs.close();
	        pstmt.close();
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return listTour;
	}


	

}
