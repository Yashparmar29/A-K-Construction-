package com.akconstruction.controller;

import com.akconstruction.model.*;
import com.akconstruction.repository.*;
import com.akconstruction.service.PdfService;
import com.akconstruction.service.PlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class PlannerController {

    @Autowired
    private PropertyDetailRepository propertyDetailRepository;

    @Autowired
    private HousePlanRepository housePlanRepository;

    @Autowired
    private CostEstimationRepository costEstimationRepository;

    @Autowired
    private MaterialEstimationRepository materialEstimationRepository;

    @Autowired
    private PlannerService plannerService;

    @Autowired
    private PdfService pdfService;

    @GetMapping("/planner/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        List<PropertyDetail> requests = propertyDetailRepository.findByUserId(user.getId());
        model.addAttribute("requests", requests);
        return "planner/dashboard";
    }

    @GetMapping("/planner/new")
    public String newPlanForm(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "planner/form";
    }

    @PostMapping("/planner/generate")
    public String generatePlan(
            @RequestParam String ownerName,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam double length,
            @RequestParam double width,
            @RequestParam int floors,
            @RequestParam int bedrooms,
            @RequestParam int bathrooms,
            @RequestParam String kitchenType,
            @RequestParam String parking,
            @RequestParam String garden,
            @RequestParam String pool,
            @RequestParam String office,
            @RequestParam String budgetRange,
            @RequestParam String style,
            @RequestParam String vastu,
            @RequestParam String city,
            @RequestParam String state,
            @RequestParam String country,
            @RequestParam(required = false, defaultValue = "") String notes,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        PropertyDetail pd = new PropertyDetail();
        pd.setUserId(user.getId());
        pd.setOwnerName(ownerName);
        pd.setEmail(email);
        pd.setPhone(phone);
        pd.setLength(length);
        pd.setWidth(width);
        pd.setPlotArea(length * width);
        pd.setFloors(floors);
        pd.setBedrooms(bedrooms);
        pd.setBathrooms(bathrooms);
        pd.setKitchenType(kitchenType);
        pd.setParking(parking);
        pd.setGarden(garden);
        pd.setPool(pool);
        pd.setOffice(office);
        pd.setBudgetRange(budgetRange);
        pd.setStyle(style);
        pd.setVastu(vastu);
        pd.setCity(city);
        pd.setState(state);
        pd.setCountry(country);
        pd.setNotes(notes);

        int propertyId = plannerService.generateAndSavePlan(pd);

        return "redirect:/planner/detail?id=" + propertyId;
    }

    @GetMapping("/planner/detail")
    public String planDetail(@RequestParam int id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        PropertyDetail pd = propertyDetailRepository.findById(id);
        if (pd == null || (pd.getUserId() != user.getId() && !user.getRole().equalsIgnoreCase("ADMIN"))) {
            return "redirect:/planner/dashboard";
        }

        HousePlan hp = housePlanRepository.findByPropertyId(id);
        CostEstimation ce = costEstimationRepository.findByPropertyId(id);
        MaterialEstimation me = materialEstimationRepository.findByPropertyId(id);

        model.addAttribute("property", pd);
        model.addAttribute("plan", hp);
        model.addAttribute("cost", ce);
        model.addAttribute("material", me);

        return "planner/detail";
    }

    @PostMapping("/planner/pdf")
    public ResponseEntity<byte[]> downloadPdf(
            @RequestParam int id,
            @RequestParam(required = false, defaultValue = "") String base64Image,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        PropertyDetail pd = propertyDetailRepository.findById(id);
        if (pd == null || (pd.getUserId() != user.getId() && !user.getRole().equalsIgnoreCase("ADMIN"))) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        HousePlan hp = housePlanRepository.findByPropertyId(id);
        CostEstimation ce = costEstimationRepository.findByPropertyId(id);
        MaterialEstimation me = materialEstimationRepository.findByPropertyId(id);

        byte[] pdfBytes = pdfService.generatePlanPdf(pd, hp, ce, me, base64Image);

        String cleanName = pd.getOwnerName().replaceAll("[^a-zA-Z0-9]", "_");
        String filename = "AK_Construction_Plan_" + cleanName + ".pdf";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", filename);
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");

        return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
    }
}
