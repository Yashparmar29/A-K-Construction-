package com.akconstruction.controller;

import com.akconstruction.model.User;
import com.akconstruction.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    private String getRedirectUrlForRole(String role) {
        if (role == null) return "redirect:/planner/dashboard";
        switch (role.toUpperCase()) {
            case "ADMIN":
                return "redirect:/admin/dashboard";
            case "CONTRACTOR":
                return "redirect:/employee/contractor/dashboard";
            case "WORKER":
                return "redirect:/employee/worker/dashboard";
            case "EMPLOYEE":
                return "redirect:/employee/dashboard";
            default:
                return "redirect:/planner/dashboard";
        }
    }

    @GetMapping("/login")
    public String loginPage(
            @RequestParam(required = false) String logout,
            @RequestParam(required = false) String registered,
            HttpSession session,
            Model model) {
        if ("true".equalsIgnoreCase(logout)) {
            session.invalidate();
            model.addAttribute("success", "You have been logged out successfully.");
            return "login";
        }
        if ("true".equalsIgnoreCase(registered)) {
            model.addAttribute("success", "Registration successful! Please sign in with your credentials.");
        }
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return getRedirectUrlForRole(user.getRole());
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam(required = false) String selectedRole,
            HttpSession session,
            Model model) {
        
        session.removeAttribute("user");

        if (email != null && password != null) {
            User user = userRepository.findByEmail(email.trim());
            if (user != null && user.getPassword() != null && user.getPassword().trim().equals(password.trim())) {
                session.setAttribute("user", user);
                return getRedirectUrlForRole(user.getRole());
            }
        }
        
        model.addAttribute("error", "Invalid email or password!");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return getRedirectUrlForRole(user.getRole());
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam(required = false) String phone,
            @RequestParam(defaultValue = "USER") String role,
            Model model) {
        
        try {
            if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                model.addAttribute("error", "Please fill in all required fields!");
                return "register";
            }

            String cleanEmail = email.trim();
            if (userRepository.existsByEmail(cleanEmail)) {
                model.addAttribute("error", "Email is already registered! Please sign in or use another email.");
                return "register";
            }

            String userRole = (role != null && !role.trim().isEmpty()) ? role.trim().toUpperCase() : "USER";
            User newUser = new User(name.trim(), cleanEmail, password.trim(), userRole);
            if (phone != null && !phone.trim().isEmpty()) {
                newUser.setPhone(phone.trim());
            }

            int result = userRepository.save(newUser);
            
            if (result > 0) {
                return "redirect:/login?registered=true";
            } else {
                model.addAttribute("error", "Registration failed: Could not save user record.");
                return "register";
            }
        } catch (Exception e) {
            e.printStackTrace();
            String detail = e.getMessage();
            if (e.getCause() != null && e.getCause().getMessage() != null) {
                detail += " | Cause: " + e.getCause().getMessage();
            }
            model.addAttribute("error", "Registration error: " + detail);
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
