package com.akconstruction.repository;

import com.akconstruction.model.Contact;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ContactRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Contact> contactRowMapper = new RowMapper<Contact>() {
        @Override
        public Contact mapRow(ResultSet rs, int rowNum) throws SQLException {
            Contact contact = new Contact();
            contact.setId(rs.getInt("id"));
            contact.setName(rs.getString("name"));
            contact.setEmail(rs.getString("email"));
            contact.setPhone(rs.getString("phone"));
            contact.setMessage(rs.getString("message"));
            contact.setSubmittedDate(rs.getTimestamp("submitted_date"));
            return contact;
        }
    };

    public int save(Contact contact) {
        String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, contact.getName(), contact.getEmail(), contact.getMessage());
    }

    public List<Contact> findAll() {
        return jdbcTemplate.query("SELECT * FROM contacts ORDER BY submitted_date DESC", contactRowMapper);
    }

    public int delete(int id) {
        return jdbcTemplate.update("DELETE FROM contacts WHERE id = ?", id);
    }
}
