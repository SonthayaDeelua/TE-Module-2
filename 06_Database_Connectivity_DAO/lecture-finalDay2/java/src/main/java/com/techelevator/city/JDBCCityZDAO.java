package com.techelevator.city;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

public class JDBCCityZDAO implements CityDAO {

	private JdbcTemplate jdbcTemplate;

	public JDBCCityZDAO(DataSource datasource) {
		jdbcTemplate = new JdbcTemplate(datasource);

	}

	@Override

	public void save(City newCity) {
		String sqlAddNewCity = "INSERT INTO city (id, name, countrycode, district, population) "
				+ " VALUES (?,?,?,?,?) ";
		newCity.setId(getNextCityId());
		jdbcTemplate.update(sqlAddNewCity);
		newCity.getId();
		newCity.getName();
		newCity.getCountryCode();
		newCity.getDistrict();
		newCity.getPopulation();

	}

	private int getNextCityId() {
		SqlRowSet nextId = jdbcTemplate.queryForRowSet("SELECT nextVal ('sql_city_id') ");
		if (nextId.next()) {
			return nextId.getInt(1);
		} else {
			throw new RuntimeException("Next ID is not available");
		}

	}

	@Override
	public City findCityById(int id) {
		City theCity = null;
		String sqlFindCityById = "SELECT id, name, countrycode, district, population " + "FROM city WHERE id = ? ";

		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlFindCityById, id);
		if (results.next()) {
			theCity = mapRowToCity(results);
		}
		return null;
	}

	private City mapRowToCity(SqlRowSet results) {
		City theCity = new City();
		theCity.setId(results.getInt("id"));
		theCity.setName(results.getString("name"));
		theCity.setCountryCode(results.getString("countrycode"));
		theCity.setDistrict(results.getString("district"));
		theCity.setPopulation(results.getInt("population"));

		return theCity;
	}

	@Override
	public List<City> findCitiesByCountryCode(String countryCode) {
		List<City> cityList = new ArrayList<>();
		String sqlFindCitiesByCountryCode = "SELECT id, name, countrycode, district, population "
				+ "FROM city WHERE countrycode = ? ";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlFindCitiesByCountryCode, countryCode);
		while (results.next()) {
			City theCity = mapRowToCity(results);
			cityList.add(theCity);

		}
		return cityList;
	}

	@Override
	public List<City> findCitiesByDistrict(String district) {
		List<City> cityList = new ArrayList<>();
		String sqlFindCitiesByDistrict = "SELECT * FROM city WHERE district = ? ";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlFindCitiesByDistrict, district);
		while(results.next()) {
			City theCity = mapRowToCity(results);
			cityList.add(theCity);
		}
								
		return cityList;
	}

	@Override
	public void update(City city) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(City city) {
		// TODO Auto-generated method stub

	}

}
