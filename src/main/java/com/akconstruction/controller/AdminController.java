package com.akconstruction.controller;

import com.akconstruction.model.*;
import com.akconstruction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private PropertyDetailRepository propertyDetailRepository;

    @Autowired
    private HousePlanRepository housePlanRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }

        // Fetch all requests
        List<PropertyDetail> requests = propertyDetailRepository.findAll();
        
        // Assemble detail list
        List<AdminPlanWrapper> wrappers = new ArrayList<>();
        int approvedCount = 0;
        int vastuCount = 0;
        double totalBudgetSum = 0;

        for (PropertyDetail pd : requests) {
            HousePlan hp = housePlanRepository.findByPropertyId(pd.getId());
            wrappers.add(new AdminPlanWrapper(pd, hp));
            
            if (hp != null && hp.isApproved()) {
                approvedCount++;
            }
            if (pd.getVastu().equalsIgnoreCase("Yes")) {
                vastuCount++;
            }
        }

        // Send statistics to dashboard
        model.addAttribute("requests", wrappers);
        model.addAttribute("totalRequests", requests.size());
        model.addAttribute("approvedRequests", approvedCount);
        model.addAttribute("vastuRequests", vastuCount);
        model.addAttribute("usersCount", userRepository.count());

        return "admin/dashboard";
    }

    @PostMapping("/admin/plan/approve")
    public String approvePlan(@RequestParam int propertyId, @RequestParam boolean approve, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }

        HousePlan hp = housePlanRepository.findByPropertyId(propertyId);
        if (hp != null) {
            hp.setApproved(approve);
            housePlanRepository.update(hp);
        }

        return "redirect:/admin/dashboard";
    }

    @PostMapping("/admin/plan/edit")
    public String editPlan(
            @RequestParam int propertyId,
            @RequestParam String recommendations,
            HttpSession session) {
        
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }

        HousePlan hp = housePlanRepository.findByPropertyId(propertyId);
        if (hp != null) {
            hp.setRecommendations(recommendations);
            housePlanRepository.update(hp);
        }

        return "redirect:/admin/dashboard";
    }

    @PostMapping("/admin/plan/upload-drawing")
    public String uploadDrawing(
            @RequestParam int propertyId,
            @RequestParam("drawingFile") MultipartFile file,
            HttpServletRequest request,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }

        if (!file.isEmpty()) {
            try {
                // Determine absolute path to webapp root folder 'uploads'
                String uploadsDir = request.getServletContext().getRealPath("/") + "uploads" + File.separator;
                File dir = new File(uploadsDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String filename = "drawing_" + propertyId + "_" + file.getOriginalFilename().replaceAll("[^a-zA-Z0-9.]", "_");
                File dest = new File(uploadsDir + filename);
                file.transferTo(dest);

                HousePlan hp = housePlanRepository.findByPropertyId(propertyId);
                if (hp != null) {
                    hp.setArchitectDrawingUrl("/uploads/" + filename);
                    housePlanRepository.update(hp);
                }
            } catch (Exception e) {
                System.err.println("Failed to upload file: " + e.getMessage());
            }
        }

        return "redirect:/admin/dashboard";
    }

    // Helper wrapper class for JSP list rendering
    public static class AdminPlanWrapper {
        private PropertyDetail propertyDetail;
        private HousePlan housePlan;

        public AdminPlanWrapper(PropertyDetail pd, HousePlan hp) {
            this.propertyDetail = pd;
            this.housePlan = hp;
        }

        public PropertyDetail getPropertyDetail() { return propertyDetail; }
        public HousePlan getHousePlan() { return housePlan; }
    }
}
