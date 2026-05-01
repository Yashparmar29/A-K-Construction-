<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Contact A K Construction - Get a free quote for your construction project today.">
    <title>Contact Us - A K Construction</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar" id="navbar">
        <div class="nav-container">
            <a href="/" class="logo"><i class="fas fa-hammer"></i> A K Construction</a>
            <ul class="nav-menu">
                <li><a href="/">Home</a></li>
                <li><a href="/about">About</a></li>
                <li><a href="/services">Services</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/contact" class="active">Contact</a></li>
            </ul>
            <button class="nav-toggle" id="navToggle"><i class="fas fa-bars"></i></button>
        </div>
    </nav>

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="page-hero-content">
            <div class="breadcrumb">
                <a href="/">Home</a> <i class="fas fa-chevron-right"></i> <span>Contact</span>
            </div>
            <h1>Contact <span class="highlight">Us</span></h1>
            <p>Get in touch for a free consultation and quote</p>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="section">
        <div class="container">
            <div class="contact-layout">

                <!-- Contact Form -->
                <div class="contact-form-wrap fade-in">
                    <h2>Send Us a Message</h2>
                    <p style="color:#666; margin-bottom:2rem;">Fill in the form below and we'll get back to you within 24 hours.</p>

                    <!-- Flash Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" id="alertMsg">
                            <i class="fas fa-check-circle"></i> ${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-error" id="alertMsg">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <form action="/contact" method="post" class="contact-form" id="contactForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Full Name *</label>
                                <input type="text" id="name" name="name" placeholder="Your full name" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email Address *</label>
                                <input type="email" id="email" name="email" placeholder="your@email.com" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="+91 98765 43210">
                        </div>
                        <div class="form-group">
                            <label for="service">Service Interested In</label>
                            <select id="service" name="service" style="width:100%; padding:1rem; border:1px solid #ddd; border-radius:10px; font-size:1rem; background:white;">
                                <option value="">Select a service...</option>
                                <option value="Residential">Residential Construction</option>
                                <option value="Commercial">Commercial Construction</option>
                                <option value="Renovation">Renovation & Remodeling</option>
                                <option value="Civil">Civil Engineering</option>
                                <option value="Interior">Interior Design</option>
                                <option value="PM">Project Management</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="message">Your Message *</label>
                            <textarea id="message" name="message" rows="5" placeholder="Tell us about your project requirements..." required></textarea>
                        </div>
                        <button type="submit" class="submit-btn" id="submitBtn">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </button>
                    </form>
                </div>

                <!-- Contact Info -->
                <div class="contact-info-wrap fade-in">
                    <h2>Get In Touch</h2>
                    <p style="color:#666; margin-bottom:2rem;">We're here to help you build your dream. Reach out through any of the following.</p>

                    <div class="contact-info-cards">
                        <div class="contact-info-card">
                            <div class="contact-info-icon"><i class="fas fa-map-marker-alt"></i></div>
                            <div>
                                <h4>Our Office</h4>
                                <p>123 Construction Avenue<br>Ahmedabad, Gujarat 380001<br>India</p>
                            </div>
                        </div>
                        <div class="contact-info-card">
                            <div class="contact-info-icon"><i class="fas fa-phone"></i></div>
                            <div>
                                <h4>Call Us</h4>
                                <p>+91 98765 43210<br>+91 87654 32109</p>
                            </div>
                        </div>
                        <div class="contact-info-card">
                            <div class="contact-info-icon"><i class="fas fa-envelope"></i></div>
                            <div>
                                <h4>Email Us</h4>
                                <p>info@akconstruction.com<br>projects@akconstruction.com</p>
                            </div>
                        </div>
                        <div class="contact-info-card">
                            <div class="contact-info-icon"><i class="fas fa-clock"></i></div>
                            <div>
                                <h4>Working Hours</h4>
                                <p>Monday – Saturday<br>9:00 AM – 6:00 PM IST</p>
                            </div>
                        </div>
                    </div>

                    <!-- Map Placeholder -->
                    <div class="map-placeholder">
                        <i class="fas fa-map-marked-alt"></i>
                        <p>Ahmedabad, Gujarat, India</p>
                        <small>123 Construction Avenue, 380001</small>
                    </div>

                    <!-- Social Links -->
                    <div class="social-section">
                        <h4>Follow Us</h4>
                        <div class="social-links">
                            <a href="#" class="social-btn"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-btn"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-btn"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-btn"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <a href="/" class="logo" style="font-size:1.5rem;"><i class="fas fa-hammer"></i> A K Construction</a>
                    <p style="margin-top:1rem; color:#aaa;">Building dreams into reality since 2005.</p>
                </div>
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="/">Home</a></li>
                        <li><a href="/about">About Us</a></li>
                        <li><a href="/services">Services</a></li>
                        <li><a href="/projects">Projects</a></li>
                        <li><a href="/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Contact Info</h4>
                    <div class="footer-contact">
                        <div><i class="fas fa-phone"></i><span>+91 98765 43210</span></div>
                        <div><i class="fas fa-envelope"></i><span>info@akconstruction.com</span></div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 A K Construction. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <button class="back-to-top" id="backToTop"><i class="fas fa-chevron-up"></i></button>
    <script src="/js/main.js"></script>
    <script>
        // Auto-dismiss alerts
        const alertMsg = document.getElementById('alertMsg');
        if (alertMsg) {
            setTimeout(() => { alertMsg.style.opacity = '0'; alertMsg.style.transition = '0.5s'; }, 5000);
        }
    </script>
</body>
</html>
