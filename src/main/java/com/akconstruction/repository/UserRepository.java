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
            user.setEmployeeCode(rs.getString("employee_code"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
            user.setProfileImage(rs.getString("profile_image"));
            user.setAddress(rs.getString("address"));
            user.setJoiningDate(rs.getDate("joining_date"));
            user.setStatus(rs.getString("status"));
            user.setCreatedDate(rs.getTimestamp("created_date"));
            return user;
        }
    };

    public int save(User user) {
        String sql = "INSERT INTO users (employee_code, name, email, phone, password, role, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String role = (user.getRole() != null && !user.getRole().trim().isEmpty()) ? user.getRole().trim().toUpperCase() : "USER";
        
        String prefix = "USR";
        if ("CONTRACTOR".equals(role)) prefix = "CON";
        else if ("WORKER".equals(role)) prefix = "WRK";
        else if ("EMPLOYEE".equals(role)) prefix = "EMP";
        else if ("ADMIN".equals(role)) prefix = "ADM";

        String empCode = (user.getEmployeeCode() != null && !user.getEmployeeCode().trim().isEmpty()) 
                ? user.getEmployeeCode().trim() 
                : (prefix + "-" + (1000 + (int)(Math.random() * 90000)));
                
        String status = (user.getStatus() != null && !user.getStatus().trim().isEmpty()) ? user.getStatus().trim() : "ACTIVE";
        String phone = (user.getPhone() != null) ? user.getPhone().trim() : "";
        String email = (user.getEmail() != null) ? user.getEmail().trim() : "";
        String name = (user.getName() != null) ? user.getName().trim() : "";
        String password = (user.getPassword() != null) ? user.getPassword().trim() : "";
        
        return jdbcTemplate.update(sql, empCode, name, email, phone, password, role, status);
    }

    public User findById(int id) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM users WHERE id = ?", userRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public User findByEmail(String email) {
        if (email == null) return null;
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM users WHERE LOWER(TRIM(email)) = LOWER(TRIM(?))", userRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean existsByEmail(String email) {
        if (email == null) return false;
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM users WHERE LOWER(TRIM(email)) = LOWER(TRIM(?))", Integer.class, email);
        return count != null && count > 0;
    }

    public List<User> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM users ORDER BY created_date DESC", userRowMapper);
    }

    public List<User> findByRole(String role) {
        return jdbcTemplate.query("SELECT * FROM users WHERE UPPER(role) = ? ORDER BY name ASC", userRowMapper, role.toUpperCase());
    }

    public List<User> findWorkersByContractorId(int contractorId) {
        String sql = "SELECT u.* FROM users u JOIN contractor_worker cw ON u.id = cw.worker_id WHERE cw.contractor_id = ? AND cw.status = 'ACTIVE' ORDER BY u.name ASC";
        return jdbcTemplate.query(sql, userRowMapper, contractorId);
    }

    public int count() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users", Integer.class);
        return count != null ? count : 0;
    }

    public int countByRole(String role) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM users WHERE UPPER(role) = ?", Integer.class, role.toUpperCase());
        return count != null ? count : 0;
    }

    public int updateRole(int id, String role) {
        return jdbcTemplate.update("UPDATE users SET role = ? WHERE id = ?", role.toUpperCase(), id);
    }

    public int updateUser(int id, String name, String email, String phone, String role, String status, String password) {
        String cleanRole = (role != null && !role.trim().isEmpty()) ? role.trim().toUpperCase() : "USER";
        String cleanStatus = (status != null && !status.trim().isEmpty()) ? status.trim().toUpperCase() : "ACTIVE";
        
        if (password != null && !password.trim().isEmpty()) {
            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, role = ?, status = ?, password = ? WHERE id = ?";
            return jdbcTemplate.update(sql, name.trim(), email.trim(), phone != null ? phone.trim() : "", cleanRole, cleanStatus, password.trim(), id);
        } else {
            String sql = "UPDATE users SET name = ?, email = ?, phone = ?, role = ?, status = ? WHERE id = ?";
            return jdbcTemplate.update(sql, name.trim(), email.trim(), phone != null ? phone.trim() : "", cleanRole, cleanStatus, id);
        }
    }

    public int delete(int id) {
        return jdbcTemplate.update("DELETE FROM users WHERE id = ?", id);
    }
}
