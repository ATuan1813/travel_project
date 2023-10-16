package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DbContext;
import model.Booking;
import model.Tour;

public class BookingDAO {
	public boolean insertBooking(Long quantityAdult, Long quantityChild, Long userBookingId, Long tourId) {
	    Connection con = null;
	    DbContext db = new DbContext();
	    PreparedStatement bookingStatement = null;
	    PreparedStatement bookingAdultStatement = null;
	    PreparedStatement bookingChildStatement = null;
	    try {
	        con = db.getConnection();
	        con.setAutoCommit(false);

	        String bookingInsertQuery = "INSERT INTO booking (user_id, tour_id, create_date, status) VALUES (?, ?, NOW(), ?)";
	        bookingStatement = con.prepareStatement(bookingInsertQuery, Statement.RETURN_GENERATED_KEYS);
	        bookingStatement.setLong(1, userBookingId);
	        bookingStatement.setLong(2, tourId);
	        bookingStatement.setBoolean(3, true);
	        int bookingRowsAffected = bookingStatement.executeUpdate();

	        long lastBookingId;
	        try (ResultSet generatedKeys = bookingStatement.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                lastBookingId = generatedKeys.getLong(1);
	            } else {
	                throw new SQLException("Creating booking failed, no ID obtained.");
	            }
	        }
	        int bookingAdultRowsAffected = -1;
	        if(quantityAdult > 0) {
        	 	String bookingAdultInsertQuery = "INSERT INTO booking_people (booking_id, people_id, quantity) VALUES (?, 1, ?)";
	 	        bookingAdultStatement = con.prepareStatement(bookingAdultInsertQuery);
	 	        bookingAdultStatement.setLong(1, lastBookingId);
	 	        bookingAdultStatement.setLong(2, quantityAdult);
	 	        bookingAdultRowsAffected = bookingAdultStatement.executeUpdate();
	        }
	        int bookingChildRowsAffected = -1;
	        if(quantityChild > 0) {
	        	String bookingChildInsertQuery = "INSERT INTO booking_people (booking_id, people_id, quantity) VALUES (?, 2, ?)";
		        bookingChildStatement = con.prepareStatement(bookingChildInsertQuery);
		        bookingChildStatement.setLong(1, lastBookingId);
		        bookingChildStatement.setLong(2, quantityChild);
		        bookingChildRowsAffected = bookingChildStatement.executeUpdate();
	        }

	        con.commit();

	        return bookingRowsAffected > 0 && (bookingAdultRowsAffected > 0 || bookingAdultRowsAffected == -1) && (bookingChildRowsAffected > 0 || bookingChildRowsAffected == -1);
	    } catch (Exception e) {
	        e.printStackTrace();
	        try {
	            if (con != null) {
	                con.rollback();
	            }
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        return false;
	    } finally {
	        try {
	            if (bookingStatement != null) {
	                bookingStatement.close();
	            }
	            if (bookingAdultStatement != null) {
	            	bookingAdultStatement.close();
	            }
	            if (bookingChildStatement != null) {
	            	bookingChildStatement.close();
	            }
	            if (con != null) {
	                con.setAutoCommit(true); 
	                con.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	/*
		SELECT b.id,t.name, SUM(CASE WHEN bp.people_id = 1 THEN bp.quantity ELSE 0 END) AS adult,
		SUM(CASE WHEN bp.people_id = 2 THEN bp.quantity ELSE 0 END) AS child,
		u.full_name, SUM(t.price * bp.quantity) as price, MAX(b.create_date) as create_date FROM booking b 
		JOIN booking_people bp ON b.id = bp.booking_id 
		JOIN tour t ON t.id = b.tour_id
		JOIN user u ON u.id = b.user_id
		WHERE u.full_name LIKE ? OR t.name LIKE ?
		GROUP BY b.id, t.name,u.full_name
		ORDER BY create_date DESC LIMIT ? OFFSET ?
	 */
	public List<Booking> getAllBookingPaging(Long limit, Long offset,String keysearch) {
		List<Booking> listBooking = new ArrayList<>();
		Connection con = null;
		DbContext db = new DbContext();
		try {
			con = db.getConnection();
			String query = "SELECT b.id,t.name, SUM(CASE WHEN bp.people_id = 1 THEN bp.quantity ELSE 0 END) AS adult,\r\n"
					+ "		SUM(CASE WHEN bp.people_id = 2 THEN bp.quantity ELSE 0 END) AS child,\r\n"
					+ "		u.full_name, SUM(t.price * bp.quantity) as price, MAX(b.create_date) as create_date FROM booking b \r\n"
					+ "		JOIN booking_people bp ON b.id = bp.booking_id \r\n"
					+ "		JOIN tour t ON t.id = b.tour_id\r\n"
					+ "		JOIN user u ON u.id = b.user_id\r\n"
					+ " WHERE u.full_name LIKE ? OR t.name LIKE ?"
					+ "		GROUP BY b.id, t.name,u.full_name\r\n"
					+ "		ORDER BY create_date DESC LIMIT ? OFFSET ?";
	        PreparedStatement pstmt = con.prepareStatement(query);
	        String searchValue = "%" + keysearch + "%";
	        pstmt.setString(1, searchValue);
	        pstmt.setString(2, searchValue); 
	        pstmt.setLong(3, limit);
	        pstmt.setLong(4, offset);
	        ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Booking booking = new Booking();
				booking.setId(rs.getLong("id"));
				booking.setName(rs.getString("name"));
				booking.setAdult(rs.getLong("adult"));
				booking.setChild(rs.getLong("child"));
				booking.setFullName(rs.getString("full_name"));
				booking.setPrice(rs.getLong("price"));
				booking.setCreateDate(rs.getDate("create_date"));
				listBooking.add(booking);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listBooking;
	}
	

}
