package com.akconstruction.repository;

import com.akconstruction.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<User> userRowMapper = new RowMapper<User>() {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
            user.setCreatedDate(rs.getTimestamp("created_date"));
            return user;
        }
    };

    public int save(User user) {
        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'USER')";
        return jdbcTemplate.update(sql, user.getName(), user.getEmail(), user.getPassword());
    }

    public User findByEmail(String email) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM users WHERE email = ?", userRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean existsByEmail(String email) {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM users WHERE email = ?", Integer.class, email);
        return count != null && count > 0;
    }

    public List<User> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM users ORDER BY created_date DESC", userRowMapper);
    }

    public int count() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
        return count != null ? count : 0;
    }
}
