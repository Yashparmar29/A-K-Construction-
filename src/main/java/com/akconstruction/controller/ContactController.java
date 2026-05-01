package com.akconstruction.controller;

import com.akconstruction.model.Contact;
import com.akconstruction.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ContactController {

    @Autowired
    private ContactRepository contactRepository;

    @GetMapping("/contact")
    public String contactPage() {
        return "contact";
    }

    @PostMapping("/contact")
    public String submitContact(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam(required = false) String phone,
            @RequestParam String message,
            RedirectAttributes redirectAttributes) {

        // Validation
        if (name == null || name.trim().isEmpty() ||
            email == null || !email.contains("@") ||
            message == null || message.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please fill all required fields correctly.");
            return "redirect:/contact";
        }

        try {
            Contact contact = new Contact(name.trim(), email.trim(), phone, message.trim());
            int result = contactRepository.save(contact);
            if (result > 0) {
                redirectAttributes.addFlashAttribute("success", "Thank you, " + name + "! Your message has been sent successfully. We'll contact you soon.");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to send message. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Database error. Please try again later.");
        }

        return "redirect:/contact";
    }
}
