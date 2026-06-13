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

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return user.getRole().equals("ADMIN") ? "redirect:/admin/dashboard" : "redirect:/planner/dashboard";
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {
        
        User user = userRepository.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("user", user);
            if (user.getRole().equalsIgnoreCase("ADMIN")) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/planner/dashboard";
        }
        
        model.addAttribute("error", "Invalid email or password!");
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "redirect:/planner/dashboard";
        }
        return "register";
    }

    @PostMapping("/register")
    public String register(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String password,
            Model model) {
        
        if (userRepository.existsByEmail(email)) {
            model.addAttribute("error", "Email is already registered!");
            return "register";
        }

        User newUser = new User(name, email, password, "USER");
        int result = userRepository.save(newUser);
        
        if (result > 0) {
            model.addAttribute("success", "Registration successful! Please login.");
            return "login";
        } else {
            model.addAttribute("error", "Something went wrong. Please try again.");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
