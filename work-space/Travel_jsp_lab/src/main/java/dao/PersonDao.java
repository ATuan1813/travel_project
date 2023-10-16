package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLSyntaxErrorException;
import java.sql.Statement;
import java.util.ArrayList;

import db.DbContext;
import mapper.RowMapper;

public class PersonDao {
	
	private DbContext dbContext = new DbContext();

	// set parameters for statement
	public void setParameter(PreparedStatement statement, Object... parameters) {
		for (int i = 0; i < parameters.length; i++) {
			Object parameter = parameters[i];
			int index = i + 1;

			if (parameter instanceof Long) {
				try {
					statement.setLong(index, (Long) parameter);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (parameter instanceof String) {
				try {
					statement.setString(index, (String) parameter);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (parameter instanceof Integer) {
				try {
					statement.setInt(index, (Integer) parameter);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (parameter instanceof Date) {
				try {
					statement.setDate(index, (Date) parameter);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if (parameter instanceof Double) {
				try {
					statement.setDouble(index, (Double) parameter);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			// xá»­ lÃ½ trÆ°á»�ng há»£p data bá»‹ null
			else if (parameter == null) {
				try {
					statement.setNull(index, java.sql.Types.INTEGER);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public int insert(String sql, Object... parameters) {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		int generatedKey = 0;
		try {
			connection = dbContext.getConnection();
			connection.setAutoCommit(false);
			statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			setParameter(statement, parameters);

			statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();

			if (rs.next()) {
				generatedKey = rs.getInt(1);
			}
			connection.commit();
			return generatedKey;

		} catch (Exception e) {
			if (connection != null) {
				try {
					connection.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
				if (statement != null) {
					statement.close();
				}
				if (resultSet != null) {
					resultSet.close();
				}
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
		return generatedKey;
	}
	
	public int update(String sql, Object... parameters) {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		int generatedKey = 0;
		try {
			connection = dbContext.getConnection();
			connection.setAutoCommit(false);
			statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			setParameter(statement, parameters);
			statement.executeUpdate();
			ResultSet rs = statement.getGeneratedKeys();
			if (rs.next()) {
				generatedKey = rs.getInt(1);
			}
			connection.commit();
			Long result = (Long)parameters[parameters.length - 1];
			return result.intValue();

		} catch (Exception e) {
            e.printStackTrace();
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
				if (statement != null) {
					statement.close();
				}
				if (resultSet != null) {
					resultSet.close();
				}
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
		return generatedKey;
	}

	public <T> T getByAny(String sql, RowMapper<T> rowMapper, Object... parameters) {

        T results = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = dbContext.getConnection();
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            setParameter(statement, parameters);
            resultSet = statement.executeQuery();
            while(resultSet.next()) {
                results = rowMapper.mapRow(resultSet);
            }
            connection.commit();
            return results;

        } catch (SQLSyntaxErrorException sqlSyntaxException) {
            sqlSyntaxException.printStackTrace();     
            
            try {
                if(connection != null) {
                    connection.close();
                }if(statement != null) {
                    statement.close();
                }if(resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e2) {
                return null;
            }
            
            return null; 
        } catch (Exception e) {
            e.printStackTrace();

            return results;
        }finally {
            try {
                if(connection != null) {
                    connection.close();
                }if(statement != null) {
                    statement.close();
                }if(resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e2) {
                return null;
            }
        }
    }
	
	public <T> ArrayList<T> queryGetAllPaging(String sql, RowMapper<T> rowMapper, Object... parameters) {

        ArrayList<T> results = new ArrayList<T>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = dbContext.getConnection();
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            setParameter(statement, parameters);
            resultSet = statement.executeQuery();

            while(resultSet.next()) {
                results.add(rowMapper.mapRow(resultSet)); 
            }
            connection.commit();
            return results;

        } catch (Exception e) {
            e.printStackTrace();

            return results;
        }finally {
            try {
                if(connection != null) {
                    connection.close();
                }if(statement != null) {
                    statement.close();
                }if(resultSet != null) {
                    resultSet.close();
                }

            } catch (SQLException e2) {
                return null;
            }
        }
    }
	
	public int queryCount(String sql, Object... parameters) {
		int result = 0;

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = dbContext.getConnection();
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            setParameter(statement, parameters);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                result = resultSet.getInt(1);
            }
            connection.commit();
            return result;

        } catch (Exception e) {
            e.printStackTrace();

            return 0;
        }finally {
            try {
                if(connection != null) {
                    connection.close();
                }if(statement != null) {
                    statement.close();
                }if(resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e2) {
                return 0;
            }
        }
    }
	public Boolean checkExistUser(String sql, Object... parameters) {
		Boolean result = false;

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = dbContext.getConnection();
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(sql);

            setParameter(statement, parameters);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                result = resultSet.getBoolean(1);
            }
            connection.commit();
            return result;

        } catch (Exception e) {
            e.printStackTrace();

            return true;
        }finally {
            try {
                if(connection != null) {
                    connection.close();
                }if(statement != null) {
                    statement.close();
                }if(resultSet != null) {
                    resultSet.close();
                }

            } catch (SQLException e2) {
                return true;
            }
        }
	}
}
