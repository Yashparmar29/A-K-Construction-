package com.akconstruction.controller;

import com.akconstruction.model.Project;
import com.akconstruction.model.User;
import com.akconstruction.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class EmployeeController {

    @Autowired
    private ProjectRepository projectRepository;

    @GetMapping("/employee/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Employee Info from logged-in user
        String employeeName = user.getName();
        String employeeEmail = user.getEmail();
        int empId = user.getId();
        String employeeIdStr = "EMP-2026-" + (1000 + empId);

        // Dynamic Role & Department based on user ID
        String[] roles = {
            "Senior Site Engineer",
            "Safety & Quality Officer",
            "MEP & Electrical Coordinator",
            "Structural Integrity Inspector",
            "Site Cost & Quantity Surveyor"
        };
        String[] departments = {
            "Civil Construction & Supervision",
            "Safety & Compliance Management",
            "Electrical & Mechanical Engineering",
            "Structural Integrity & Design",
            "Site Costing & Material Procurement"
        };

        int roleIdx = Math.abs(empId % roles.length);
        String employeeRole = roles[roleIdx];
        String department = departments[roleIdx];

        // Fetch Real Projects from Database
        List<Project> dbProjects = projectRepository.findAll();
        List<Map<String, Object>> projects = new ArrayList<>();
        
        if (dbProjects != null && !dbProjects.isEmpty()) {
            int index = 1;
            for (Project p : dbProjects) {
                int progress = ((index * 23 + empId * 7) % 70) + 25;
                String status = (progress > 80) ? "Finishing" : (progress > 45) ? "In Progress" : "Active";
                String priority = (index % 3 == 0) ? "Critical" : (index % 2 == 0) ? "High" : "Normal";
                
                Map<String, Object> map = new HashMap<>();
                map.put("id", p.getId());
                map.put("name", p.getTitle());
                map.put("location", p.getCategory());
                map.put("description", p.getDescription());
                map.put("image", p.getImage());
                map.put("progress", progress);
                map.put("status", status);
                map.put("priority", priority);
                projects.add(map);
                index++;
            }
        }

        // Today's Tasks List (Personalized based on role & real project titles)
        List<Map<String, Object>> todaysTasks = new ArrayList<>();
        String proj1 = (projects.size() > 0) ? (String) projects.get(0).get("name") : "Modern Villa Residence";
        String proj2 = (projects.size() > 1) ? (String) projects.get(1).get("name") : "Corporate Office Complex";
        String proj3 = (projects.size() > 2) ? (String) projects.get(2).get("name") : "Luxury Apartment Complex";
        String proj4 = (projects.size() > 3) ? (String) projects.get(3).get("name") : "Shopping Mall Development";

        if (roleIdx == 0) { // Civil Engineer
            todaysTasks.add(createTask(101, "Inspect concrete curing on Floor 4 slab", proj1, "09:30 AM", "Completed", "High"));
            todaysTasks.add(createTask(102, "Review steel rebar density & tensile certificates", proj2, "11:00 AM", "Completed", "Critical"));
            todaysTasks.add(createTask(103, "Conduct site excavation depth verification", proj3, "01:30 PM", "Completed", "Medium"));
            todaysTasks.add(createTask(104, "Verify shuttering alignment for Block B", proj4, "03:30 PM", "Pending", "High"));
            todaysTasks.add(createTask(105, "Submit daily site progress log to Senior Consultant", "Digital Portal", "05:15 PM", "Pending", "Normal"));
        } else if (roleIdx == 1) { // Safety Officer
            todaysTasks.add(createTask(101, "Audit scaffolding stability & fall protection netting", proj1, "09:00 AM", "Completed", "Critical"));
            todaysTasks.add(createTask(102, "Inspect worker PPE hard hat & safety harness compliance", proj2, "10:30 AM", "Completed", "High"));
            todaysTasks.add(createTask(103, "Conduct daily toolbox safety talk for crew B", proj3, "01:00 PM", "Completed", "Medium"));
            todaysTasks.add(createTask(104, "Inspect site fire extinguishers & emergency exits", proj4, "03:00 PM", "Pending", "High"));
            todaysTasks.add(createTask(105, "Log weekly environmental safety compliance report", "Digital Portal", "05:00 PM", "Pending", "Normal"));
        } else if (roleIdx == 2) { // MEP Engineer
            todaysTasks.add(createTask(101, "Check electrical conduit alignment on 12th Floor", proj1, "09:30 AM", "Completed", "Normal"));
            todaysTasks.add(createTask(102, "Perform hydro-pressure test on main water lines", proj2, "11:15 AM", "Completed", "High"));
            todaysTasks.add(createTask(103, "Verify HVAC ducting installation parameters", proj3, "02:00 PM", "Completed", "Critical"));
            todaysTasks.add(createTask(104, "Inspect backup diesel generator wiring harness", proj4, "04:00 PM", "Pending", "High"));
            todaysTasks.add(createTask(105, "Review MEP technical drawings with vendor team", "Store Office", "05:30 PM", "Pending", "Normal"));
        } else if (roleIdx == 3) { // Quality Inspector
            todaysTasks.add(createTask(101, "Perform concrete cube compressive strength test", proj1, "09:15 AM", "Completed", "High"));
            todaysTasks.add(createTask(102, "Audit brickwork mortar ratio and wall verticality", proj2, "11:00 AM", "Completed", "Critical"));
            todaysTasks.add(createTask(103, "Inspect waterproofing membrane application in basements", proj3, "01:45 PM", "Completed", "High"));
            todaysTasks.add(createTask(104, "Verify plastering thickness & smooth finish quality", proj4, "03:45 PM", "Pending", "Medium"));
            todaysTasks.add(createTask(105, "Issue quality clearance certificate for 5th floor slab", "Digital Portal", "05:30 PM", "Pending", "Normal"));
        } else { // Quantity Surveyor
            todaysTasks.add(createTask(101, "Audit daily material dispatch log (Grade 53 OPC Cement)", proj1, "09:30 AM", "Completed", "High"));
            todaysTasks.add(createTask(102, "Reconcile TMT rebar weighbridge receipts", proj2, "11:30 AM", "Completed", "Critical"));
            todaysTasks.add(createTask(103, "Verify contractor measurement sheets for excavation", proj3, "02:15 PM", "Completed", "Medium"));
            todaysTasks.add(createTask(104, "Cross-check ready-mix concrete batching slips", proj4, "04:15 PM", "Pending", "High"));
            todaysTasks.add(createTask(105, "Prepare weekly material consumption report", "Digital Portal", "05:45 PM", "Pending", "Normal"));
        }

        // Upcoming Site Visits (USING REAL DATABASE PROJECTS)
        List<Map<String, Object>> siteVisits = new ArrayList<>();
        siteVisits.add(createVisit(proj1, "Structural Audit & Quality Inspection", "Today, 02:30 PM", "Er. " + employeeName + " (Lead)", "Confirmed", "bg-success"));
        siteVisits.add(createVisit(proj2, "Safety & Scaffolding Certification Walkthrough", "Tomorrow, 10:00 AM", "Safety Team Alpha", "Scheduled", "bg-info"));
        siteVisits.add(createVisit(proj3, "Final MEP & Structural Stability Assessment", "Aug 16, 11:30 AM", "Client Rep & Municipal Officers", "Pending Approval", "bg-warning text-dark"));
        siteVisits.add(createVisit(proj4, "Foundation Piling & Soil Density Test Verification", "Aug 18, 09:00 AM", "Geotech Solutions Team", "Scheduled", "bg-info"));

        // Count task metrics dynamically
        int totalTasks = todaysTasks.size();
        int completedCount = 0;
        for (Map<String, Object> t : todaysTasks) {
            if ("Completed".equalsIgnoreCase((String) t.get("status"))) {
                completedCount++;
            }
        }
        int pendingCount = totalTasks - completedCount;

        // Metrics & Stats
        int totalAssignedProjects = projects.size();
        String attendanceStatus = "Checked In (08:30 AM)";
        String shiftHours = "08:30 AM - 05:30 PM";

        // Notifications
        List<Map<String, Object>> notifications = new ArrayList<>();
        notifications.add(createNotification("Site Alert", "Mandatory compliance inspection scheduled for " + proj1, "10 mins ago", "danger", "fa-exclamation-triangle", true));
        notifications.add(createNotification("Material Arrival", "Raw materials delivered at " + proj2 + " site.", "1 hour ago", "success", "fa-truck-loading", true));
        notifications.add(createNotification("Task Schedule", "Submit daily site progress report before 06:00 PM.", "3 hours ago", "warning", "fa-tasks", false));
        notifications.add(createNotification("Inspection Approved", "Phase 2 stability report approved by Municipal Authorities.", "5 hours ago", "info", "fa-check-circle", false));

        // Date string
        String currentDateFormatted = LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy"));

        // Populate model
        model.addAttribute("employeeName", employeeName);
        model.addAttribute("employeeEmail", employeeEmail);
        model.addAttribute("employeeRole", employeeRole);
        model.addAttribute("employeeId", employeeIdStr);
        model.addAttribute("department", department);
        model.addAttribute("currentDate", currentDateFormatted);

        model.addAttribute("totalAssignedProjects", totalAssignedProjects);
        model.addAttribute("todaysTasksCount", totalTasks);
        model.addAttribute("completedTasksCount", completedCount);
        model.addAttribute("pendingTasksCount", pendingCount);
        model.addAttribute("attendanceStatus", attendanceStatus);
        model.addAttribute("shiftHours", shiftHours);

        model.addAttribute("projects", projects);
        model.addAttribute("todaysTasks", todaysTasks);
        model.addAttribute("siteVisits", siteVisits);
        model.addAttribute("notifications", notifications);

        return "employee/dashboard";
    }

    private Map<String, Object> createProject(int id, String name, String location, int progress, String status, String priority) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("location", location);
        map.put("progress", progress);
        map.put("status", status);
        map.put("priority", priority);
        return map;
    }

    private Map<String, Object> createTask(int id, String title, String project, String time, String status, String priority) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("title", title);
        map.put("project", project);
        map.put("time", time);
        map.put("status", status);
        map.put("priority", priority);
        return map;
    }

    private Map<String, Object> createVisit(String site, String purpose, String time, String supervisor, String status, String badgeClass) {
        Map<String, Object> map = new HashMap<>();
        map.put("site", site);
        map.put("purpose", purpose);
        map.put("time", time);
        map.put("supervisor", supervisor);
        map.put("status", status);
        map.put("badgeClass", badgeClass);
        return map;
    }

    private Map<String, Object> createNotification(String title, String message, String time, String type, String icon, boolean unread) {
        Map<String, Object> map = new HashMap<>();
        map.put("title", title);
        map.put("message", message);
        map.put("time", time);
        map.put("type", type);
        map.put("icon", icon);
        map.put("unread", unread);
        return map;
    }
}
