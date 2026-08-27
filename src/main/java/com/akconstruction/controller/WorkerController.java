package com.akconstruction.controller;

import com.akconstruction.model.User;
import com.akconstruction.model.WorkerWorkAssignment;
import com.akconstruction.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class WorkerController {

    @Autowired
    private EmployeeService employeeService;

    private User getWorkerSessionUser(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return null;
        String role = user.getRole();
        if ("WORKER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
            return user;
        }
        return null;
    }

    @GetMapping("/employee/worker/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User worker = getWorkerSessionUser(session);
        if (worker == null) return "redirect:/login";

        int workerId = worker.getId();

        // 1. Assigned Contractor
        User contractor = employeeService.getAssignedContractor(workerId);

        // 2. Work Assignments
        List<WorkerWorkAssignment> assignments = employeeService.getAssignmentsByWorker(workerId);

        int totalTasks = assignments.size();
        int completedTasks = 0;
        int pendingTasks = 0;
        for (WorkerWorkAssignment a : assignments) {
            if ("COMPLETED".equalsIgnoreCase(a.getStatus()) || "SUBMITTED".equalsIgnoreCase(a.getStatus()) || a.getCompletionPercentage() >= 100) {
                completedTasks++;
            } else {
                pendingTasks++;
            }
        }

        model.addAttribute("worker", worker);
        model.addAttribute("contractor", contractor);
        model.addAttribute("assignments", assignments);
        model.addAttribute("totalTasks", totalTasks);
        model.addAttribute("completedTasks", completedTasks);
        model.addAttribute("pendingTasks", pendingTasks);
        model.addAttribute("attendanceStatus", "Checked In (08:30 AM)");
        model.addAttribute("weeklyHours", 38.5);
        model.addAttribute("efficiencyRate", 94);

        return "employee/worker/dashboard";
    }

    @PostMapping("/employee/worker/submit-report")
    public String submitWorkReport(
            @RequestParam int assignmentId,
            @RequestParam(defaultValue = "100") int completionPercentage,
            @RequestParam(required = false, defaultValue = "COMPLETED") String status,
            @RequestParam(required = false, defaultValue = "") String remarks,
            @RequestParam(required = false, defaultValue = "8.0") String hoursWorked,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User worker = getWorkerSessionUser(session);
        if (worker == null) return "redirect:/login";

        String finalRemarks = remarks;
        if (hoursWorked != null && !hoursWorked.trim().isEmpty()) {
            finalRemarks = (remarks != null && !remarks.isEmpty() ? remarks + " " : "") + "[Hours Logged: " + hoursWorked + "h]";
        }

        employeeService.updateAssignmentStatus(assignmentId, status, completionPercentage, finalRemarks);
        redirectAttributes.addFlashAttribute("successMessage", "Work log and report submitted successfully!");

        return "redirect:/employee/worker/dashboard";
    }

    @GetMapping("/employee/worker/profile")
    public String profile(HttpSession session, Model model) {
        User worker = getWorkerSessionUser(session);
        if (worker == null) return "redirect:/login";

        User contractor = employeeService.getAssignedContractor(worker.getId());

        model.addAttribute("worker", worker);
        model.addAttribute("contractor", contractor);
        return "employee/worker/profile";
    }

    @GetMapping("/employee/worker/assignments")
    public String assignments(HttpSession session, Model model) {
        User worker = getWorkerSessionUser(session);
        if (worker == null) return "redirect:/login";

        List<WorkerWorkAssignment> assignments = employeeService.getAssignmentsByWorker(worker.getId());

        model.addAttribute("worker", worker);
        model.addAttribute("assignments", assignments);
        return "employee/worker/assignments";
    }

    @GetMapping("/employee/worker/attendance")
    public String attendance(
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            HttpSession session,
            Model model) {

        User worker = getWorkerSessionUser(session);
        if (worker == null) return "redirect:/login";

        java.time.LocalDate now = java.time.LocalDate.now();
        int targetYear = (year != null) ? year : now.getYear();
        int targetMonth = (month != null) ? month : now.getMonthValue();

        List<com.akconstruction.model.EmployeeAttendance> attendanceList = employeeService.getWorkerMonthlyAttendance(worker.getId(), targetYear, targetMonth);

        int daysPresent = employeeService.getDaysPresentCount(attendanceList);
        double totalHours = employeeService.getTotalMonthlyHours(attendanceList);
        int totalDaysInLog = attendanceList.size();
        double attendancePercentage = (totalDaysInLog > 0) ? ((double) daysPresent / totalDaysInLog) * 100.0 : 0.0;

        User contractor = employeeService.getAssignedContractor(worker.getId());

        model.addAttribute("worker", worker);
        model.addAttribute("contractor", contractor);
        model.addAttribute("attendanceList", attendanceList);
        model.addAttribute("selectedYear", targetYear);
        model.addAttribute("selectedMonth", targetMonth);
        model.addAttribute("daysPresent", daysPresent);
        model.addAttribute("totalDaysInLog", totalDaysInLog);
        model.addAttribute("totalHours", String.format("%.1f", totalHours));
        model.addAttribute("attendancePercentage", String.format("%.1f", attendancePercentage));

        return "employee/worker/attendance";
    }
}
