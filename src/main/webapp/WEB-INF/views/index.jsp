<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A K Construction - Premier construction company building dreams into reality. Residential, commercial, and renovation projects.">
    <title>A K Construction - Building Dreams into Reality</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar" id="navbar">
        <div class="nav-container">
            <a href="/" class="logo">
                <i class="fas fa-hammer"></i> A K Construction
            </a>
            <ul class="nav-menu">
                <li><a href="/" class="active">Home</a></li>
                <li><a href="/about">About</a></li>
                <li><a href="/services">Services</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/contact">Contact</a></li>
            </ul>
            <button class="nav-toggle" id="navToggle"><i class="fas fa-bars"></i></button>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <div class="hero-badge fade-in-hero">⭐ Trusted Since 2005</div>
            <h1 class="fade-in-hero">Building Dreams<br><span class="highlight">into Reality</span></h1>
            <p class="fade-in-hero">Excellence in Construction &nbsp;|&nbsp; Quality You Can Trust &nbsp;|&nbsp; On Time Delivery</p>
            <div class="hero-buttons fade-in-hero">
                <a href="/contact" class="cta-button">
                    <i class="fas fa-phone"></i> Get Free Quote
                </a>
                <a href="/projects" class="cta-button-outline">
                    <i class="fas fa-eye"></i> View Projects
                </a>
            </div>
        </div>
        <div class="hero-stats fade-in-hero">
            <div class="stat-item">
                <span class="stat-number">500+</span>
                <span class="stat-label">Projects Done</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">20+</span>
                <span class="stat-label">Years Experience</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">98%</span>
                <span class="stat-label">Client Satisfaction</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">50+</span>
                <span class="stat-label">Expert Team</span>
            </div>
        </div>
    </section>

    <!-- Services Preview -->
    <section class="section">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">What We Do</span>
                <h2>Our Core Services</h2>
                <p>From residential homes to commercial complexes, we deliver excellence in every project.</p>
            </div>
            <div class="services-grid">
                <div class="service-card fade-in">
                    <div class="service-icon"><i class="fas fa-home"></i></div>
                    <h3>Residential</h3>
                    <p>Custom homes, villas, and apartments designed with modern aesthetics and smart features.</p>
                    <a href="/services" class="card-link">Learn More <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="service-card fade-in">
                    <div class="service-icon"><i class="fas fa-building"></i></div>
                    <h3>Commercial</h3>
                    <p>Office complexes, retail spaces, and hotels built with premium construction quality.</p>
                    <a href="/services" class="card-link">Learn More <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="service-card fade-in">
                    <div class="service-icon"><i class="fas fa-tools"></i></div>
                    <h3>Renovation</h3>
                    <p>Complete makeovers and renovations transforming spaces into modern masterpieces.</p>
                    <a href="/services" class="card-link">Learn More <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="service-card fade-in">
                    <div class="service-icon"><i class="fas fa-drafting-compass"></i></div>
                    <h3>Civil Engineering</h3>
                    <p>Bridges, roads, and infrastructure projects with precision engineering and safety.</p>
                    <a href="/services" class="card-link">Learn More <i class="fas fa-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Projects -->
    <section class="section section-dark">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">Our Work</span>
                <h2>Featured Projects</h2>
                <p>Explore our portfolio of completed projects across various categories.</p>
            </div>
            <div class="projects-grid" id="featured-projects">
                <div class="loading-card">
                    <i class="fas fa-spinner fa-spin"></i>
                    <p>Loading projects...</p>
                </div>
            </div>
            <div style="text-align: center; margin-top: 3rem;" class="fade-in">
                <a href="/projects" class="cta-button">
                    <i class="fas fa-th-large"></i> View All Projects
                </a>
            </div>
        </div>
    </section>

    <!-- Why Choose Us -->
    <section class="section">
        <div class="container">
            <div class="why-us-grid fade-in">
                <div class="why-us-content">
                    <span class="section-tag">Why Choose Us</span>
                    <h2>We Build More Than Structures</h2>
                    <p>With over 20 years of experience, A K Construction delivers projects that exceed expectations — on time and within budget.</p>
                    <div class="feature-list">
                        <div class="feature-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Licensed & Certified Professionals</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Transparent Pricing & No Hidden Costs</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check-circle"></i>
                            <span>On-Time Project Delivery Guaranteed</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Premium Quality Materials Only</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-check-circle"></i>
                            <span>5-Year Construction Warranty</span>
                        </div>
                    </div>
                    <a href="/about" class="cta-button" style="margin-top: 2rem; display: inline-flex;">
                        <i class="fas fa-info-circle"></i> About Us
                    </a>
                </div>
                <div class="why-us-visual">
                    <div class="visual-card vc-1">
                        <i class="fas fa-medal"></i>
                        <span>ISO Certified</span>
                    </div>
                    <div class="visual-card vc-2">
                        <i class="fas fa-hard-hat"></i>
                        <span>Safe & Secure</span>
                    </div>
                    <div class="visual-card vc-3">
                        <i class="fas fa-leaf"></i>
                        <span>Eco-Friendly</span>
                    </div>
                    <div class="visual-card vc-4">
                        <i class="fas fa-award"></i>
                        <span>Award Winning</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="section cta-section">
        <div class="container">
            <div class="cta-box fade-in">
                <h2>Ready to Start Your Dream Project?</h2>
                <p>Contact us today for a free consultation and detailed quote. Our team is ready to bring your vision to life.</p>
                <div class="cta-buttons">
                    <a href="/contact" class="cta-button">
                        <i class="fas fa-paper-plane"></i> Get In Touch
                    </a>
                    <a href="tel:+919876543210" class="cta-button-outline" style="color:white; border-color:white;">
                        <i class="fas fa-phone"></i> Call Now
                    </a>
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
                    <p style="margin-top:1rem; color:#aaa;">Building dreams into reality since 2005. Quality construction services across India.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
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
                    <h4>Services</h4>
                    <ul class="footer-links">
                        <li><a href="/services">Residential Construction</a></li>
                        <li><a href="/services">Commercial Buildings</a></li>
                        <li><a href="/services">Renovation & Remodeling</a></li>
                        <li><a href="/services">Civil Engineering</a></li>
                        <li><a href="/services">Interior Design</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Contact Info</h4>
                    <div class="footer-contact">
                        <div><i class="fas fa-map-marker-alt"></i><span>123 Construction Ave, Gujarat, India 380001</span></div>
                        <div><i class="fas fa-phone"></i><span>+91 98765 43210</span></div>
                        <div><i class="fas fa-envelope"></i><span>info@akconstruction.com</span></div>
                        <div><i class="fas fa-clock"></i><span>Mon-Sat: 9:00 AM - 6:00 PM</span></div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 A K Construction. All Rights Reserved. | Built with ❤️ in Java</p>
            </div>
        </div>
    </footer>

    <button class="back-to-top" id="backToTop" title="Back to top"><i class="fas fa-chevron-up"></i></button>

    <script src="/js/main.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('/api/projects')
                .then(response => response.json())
                .then(projects => {
                    const container = document.getElementById('featured-projects');
                    container.innerHTML = '';
                    projects.slice(0, 3).forEach(project => {
                        container.innerHTML += `
                            <div class="project-card fade-in">
                                <div class="project-img-wrap">
                                    <img src="${project.image || '/images/default-project.jpg'}" alt="${project.title}" onerror="this.src='/images/default-project.jpg'">
                                    <span class="category-badge">${project.category}</span>
                                </div>
                                <div class="project-info">
                                    <h3>${project.title}</h3>
                                    <p>${project.description.substring(0, 90)}...</p>
                                    <a href="/projects" class="card-link">View Details <i class="fas fa-arrow-right"></i></a>
                                </div>
                            </div>`;
                    });
                    document.querySelectorAll('.fade-in').forEach(el => {
                        setTimeout(() => el.classList.add('visible'), 100);
                    });
                })
                .catch(() => {
                    document.getElementById('featured-projects').innerHTML =
                        '<div class="loading-card"><i class="fas fa-exclamation-circle"></i><p>Projects coming soon!</p></div>';
                });
        });
    </script>
</body>
</html>
