package com.akconstruction.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute("javax.servlet.error.status_code");
        Object exception = request.getAttribute("javax.servlet.error.exception");
        
        String errorMessage = "An unexpected error occurred.";
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            if (statusCode == 404) {
                errorMessage = "The requested page was not found (404).";
            } else if (statusCode == 500) {
                errorMessage = "Internal server error (500). Please check application logs.";
            }
        }
        if (exception != null && exception instanceof Throwable) {
            Throwable t = (Throwable) exception;
            if (t.getMessage() != null && !t.getMessage().isEmpty()) {
                errorMessage += " (" + t.getMessage() + ")";
            }
        }

        model.addAttribute("error", errorMessage);
        return "login";
    }
}
