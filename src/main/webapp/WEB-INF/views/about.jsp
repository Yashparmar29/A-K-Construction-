<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="About A K Construction - 20+ years of excellence in construction. Meet our team and learn about our values.">
    <title>About Us - A K Construction</title>
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
                <li><a href="/about" class="active">About</a></li>
                <li><a href="/services">Services</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/contact">Contact</a></li>
            </ul>
            <button class="nav-toggle" id="navToggle"><i class="fas fa-bars"></i></button>
        </div>
    </nav>

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="page-hero-content">
            <div class="breadcrumb">
                <a href="/">Home</a> <i class="fas fa-chevron-right"></i> <span>About Us</span>
            </div>
            <h1>About <span class="highlight">A K Construction</span></h1>
            <p>Building excellence since 2005 — your trusted construction partner</p>
        </div>
    </section>

    <!-- Our Story -->
    <section class="section">
        <div class="container">
            <div class="story-grid fade-in">
                <div class="story-content">
                    <span class="section-tag">Our Story</span>
                    <h2>20+ Years of Building Excellence</h2>
                    <p>Founded in 2005 by Arvind Kumar, A K Construction started as a small residential contractor in Gujarat. Through unwavering dedication to quality and client satisfaction, we have grown into one of the region's most trusted construction companies.</p>
                    <p style="margin-top:1rem;">Today, we operate across residential, commercial, civil engineering, and renovation sectors — completing 500+ projects with a 98% client satisfaction rate.</p>
                    <div class="mini-stats">
                        <div class="mini-stat">
                            <strong>2005</strong>
                            <span>Founded</span>
                        </div>
                        <div class="mini-stat">
                            <strong>500+</strong>
                            <span>Projects</span>
                        </div>
                        <div class="mini-stat">
                            <strong>50+</strong>
                            <span>Team Members</span>
                        </div>
                        <div class="mini-stat">
                            <strong>10+</strong>
                            <span>Cities</span>
                        </div>
                    </div>
                </div>
                <div class="story-visual">
                    <div class="about-img-card">
                        <i class="fas fa-building" style="font-size:5rem; color:var(--primary-yellow);"></i>
                        <h3>A K Construction</h3>
                        <p>Established 2005</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Mission, Vision, Values -->
    <section class="section section-gray">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">Our Foundation</span>
                <h2>Mission, Vision & Values</h2>
            </div>
            <div class="mvv-grid">
                <div class="mvv-card fade-in">
                    <div class="mvv-icon"><i class="fas fa-bullseye"></i></div>
                    <h3>Our Mission</h3>
                    <p>To deliver superior construction services that transform our clients' visions into reality, while maintaining the highest standards of quality, safety, and integrity.</p>
                </div>
                <div class="mvv-card fade-in">
                    <div class="mvv-icon"><i class="fas fa-eye"></i></div>
                    <h3>Our Vision</h3>
                    <p>To be India's most trusted construction company, recognized for excellence in craftsmanship, innovation in design, and commitment to sustainable building practices.</p>
                </div>
                <div class="mvv-card fade-in">
                    <div class="mvv-icon"><i class="fas fa-heart"></i></div>
                    <h3>Our Values</h3>
                    <p>Integrity, Quality, Safety, Innovation, and Client-First approach guide every decision we make from blueprint to final handover.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="section">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">Our People</span>
                <h2>Meet Our Leadership Team</h2>
                <p>Experienced professionals dedicated to delivering your project with precision.</p>
            </div>
            <div class="team-grid">
                <div class="team-card fade-in">
                    <div class="team-avatar"><i class="fas fa-user-tie"></i></div>
                    <h3>Arvind Kumar</h3>
                    <span class="team-role">Founder & CEO</span>
                    <p>Civil Engineer with 25+ years of construction experience across India.</p>
                </div>
                <div class="team-card fade-in">
                    <div class="team-avatar"><i class="fas fa-user-tie"></i></div>
                    <h3>Rajesh Sharma</h3>
                    <span class="team-role">Chief Architect</span>
                    <p>Award-winning architect specializing in sustainable modern design.</p>
                </div>
                <div class="team-card fade-in">
                    <div class="team-avatar"><i class="fas fa-user-tie"></i></div>
                    <h3>Priya Patel</h3>
                    <span class="team-role">Project Manager</span>
                    <p>PMP-certified manager ensuring on-time, on-budget delivery for all projects.</p>
                </div>
                <div class="team-card fade-in">
                    <div class="team-avatar"><i class="fas fa-user-tie"></i></div>
                    <h3>Suresh Mehta</h3>
                    <span class="team-role">Head of Engineering</span>
                    <p>Structural engineer with expertise in large-scale civil infrastructure projects.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Certifications -->
    <section class="section section-dark">
        <div class="container">
            <div class="section-header fade-in" style="color:white;">
                <span class="section-tag">Our Credentials</span>
                <h2 style="color:white;">Certifications & Awards</h2>
            </div>
            <div class="cert-grid">
                <div class="cert-card fade-in">
                    <i class="fas fa-certificate"></i>
                    <h4>ISO 9001:2015</h4>
                    <p>Quality Management System</p>
                </div>
                <div class="cert-card fade-in">
                    <i class="fas fa-hard-hat"></i>
                    <h4>OSHA Certified</h4>
                    <p>Occupational Safety Standards</p>
                </div>
                <div class="cert-card fade-in">
                    <i class="fas fa-award"></i>
                    <h4>Best Builder 2023</h4>
                    <p>Gujarat Construction Awards</p>
                </div>
                <div class="cert-card fade-in">
                    <i class="fas fa-leaf"></i>
                    <h4>Green Building</h4>
                    <p>IGBC Certified Projects</p>
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
</body>
</html>
