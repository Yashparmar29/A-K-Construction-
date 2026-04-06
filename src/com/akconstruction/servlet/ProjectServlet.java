package com.akconstruction.servlet;

import com.akconstruction.db.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/projects")
public class ProjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Simple POJO for project data
    public static class Project {
        private int id;
        private String title;
        private String category;
        private String image;
        private String description;
        
        public Project(int id, String title, String category, String image, String description) {
            this.id = id;
            this.title = title;
            this.category = category;
            this.image = image;
            this.description = description;
        }
        
        // Getters
        public int getId() { return id; }
        public String getTitle() { return title; }
        public String getCategory() { return category; }
        public String getImage() { return image; }
        public String getDescription() { return description; }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryFilter = request.getParameter("category");
        List<Project> projects = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM projects";
            if (categoryFilter != null && !categoryFilter.isEmpty()) {
                sql += " WHERE category = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, categoryFilter);
            } else {
                pstmt = conn.prepareStatement(sql);
            }
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Project project = new Project(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("image"),
                    rs.getString("description")
                );
                projects.add(project);
            }
            
            // Send JSON response for AJAX
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            
            out.print("[");
            for (int i = 0; i < projects.size(); i++) {
                Project p = projects.get(i);
                out.print("{\"id\":" + p.getId() + 
                         ",\"title\":\"" + p.getTitle() + "\"" +
                         ",\"category\":\"" + p.getCategory() + "\"" +
                         ",\"image\":\"" + p.getImage() + "\"" +
                         ",\"description\":\"" + p.getDescription() + "\"}");
                if (i < projects.size() - 1) out.print(",");
            }
            out.print("]");
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
