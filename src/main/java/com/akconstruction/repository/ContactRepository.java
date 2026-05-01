package com.akconstruction.repository;

import com.akconstruction.model.Contact;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ContactRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int save(Contact contact) {
        String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, contact.getName(), contact.getEmail(), contact.getMessage());
    }
}
