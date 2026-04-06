package com.akconstruction.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.akconstruction.db.DBConnection;

public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        
        // Server-side validation
        if (name == null || name.trim().isEmpty() || 
            email == null || !email.contains("@") || 
            message == null || message.trim().isEmpty()) {
            response.sendRedirect("contact.jsp?error=Please fill all fields correctly");
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO contacts (name, email, message) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, message);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("contact.jsp?success=Thank you! Your message has been sent.");
            } else {
                response.sendRedirect("contact.jsp?error=Failed to send message. Please try again.");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?error=Database error. Please try again.");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
