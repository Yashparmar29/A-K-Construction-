package com.akconstruction.controller;

import com.akconstruction.model.Project;
import com.akconstruction.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ProjectController {

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping("/projects")
    public String projects(Model model) {
        return "projects";
    }

    // JSON API endpoint for AJAX calls
    @GetMapping("/api/projects")
    @ResponseBody
    public ResponseEntity<List<Project>> getProjectsApi(
            @RequestParam(required = false) String category) {
        try {
            List<Project> projects;
            if (category != null && !category.isEmpty()) {
                projects = projectRepository.findByCategory(category);
            } else {
                projects = projectRepository.findAll();
            }
            return ResponseEntity.ok(projects);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
