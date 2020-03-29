package com.techelevator.post;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

public class UserJdbcDao implements UserDao {

	private JdbcTemplate jdbcTemplate;

	public UserJdbcDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	// To insert a date into a prepared statement, wrap the date in
	// `Date.valueOf()`
	// method: `Date.valueOf(myObject.getCreated())`

	@Override
	public void save(User newUser) {

		newUser.setId(getNextUserId());
		String sqlCreateUser = "INSERT INTO users ( first_name, last_name, email, role, created) "
				+ " VALUES (?, ?, ?, ?, ?) ";
		jdbcTemplate.update(sqlCreateUser, newUser.getFirstName(), newUser.getLastName(),
				newUser.getEmail(), newUser.getRole(), Date.valueOf(newUser.getCreated()));

	}

	public Long getNextUserId() {
		SqlRowSet nextIdResult = jdbcTemplate.queryForRowSet(" SELECT nextval('users_id_seq') ");
		if (nextIdResult.next()) {
			return nextIdResult.getLong(1);
		} else {
			throw new RuntimeException("Uhoh!  Something went wrong while getting the next id!");
		}
	}

	@Override
	public List<User> getAllUsers() {

		List<User> allUsers = new ArrayList<>();
		String sqlFindAllUsers = "SELECT * FROM users";
		SqlRowSet result = jdbcTemplate.queryForRowSet(sqlFindAllUsers);

		while (result.next()) {
			allUsers.add(mapRowToUser(result));

		}
		return allUsers;

	}

	private User mapRowToUser(SqlRowSet results) {
		User userRow = new User();
		userRow.setId(results.getLong("id"));
		userRow.setFirstName(results.getString("first_name"));
		userRow.setLastName(results.getString("last_name"));
		userRow.setEmail(results.getString("email"));
		userRow.setRole(results.getString("role"));
		userRow.setCreated(results.getDate("created").toLocalDate());
		return userRow;
	}

}
