<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>A K Construction - Building Dreams into Reality</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="logo">
                <i class="fas fa-hammer"></i> A K Construction
            </a>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="projects.jsp">Projects</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="hero-content">
            <h1>Building Dreams into Reality</h1>
            <p>Excellence in Construction | Quality You Can Trust | On Time Delivery</p>
            <a href="contact.jsp" class="cta-button">
                <i class="fas fa-phone"></i> Get Free Quote
            </a>
        </div>
    </section>

    <!-- Services Preview -->
    <section class="section">
        <div class="container">
            <div class="glass-card fade-in" style="max-width: 800px; margin: 0 auto 3rem;">
                <h2 style="text-align: center; color: var(--primary-black); margin-bottom: 1rem;">
                    Our Core Services
                </h2>
                <p style="text-align: center; font-size: 1.1rem; color: #666;">
                    From residential homes to commercial complexes, we deliver excellence in every project.
                </p>
            </div>
            
            <div class="services-grid">
                <div class="service-card fade-in">
                    <div class="service-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <h3>Residential</h3>
                    <p>Custom homes, villas, apartments with modern designs and smart features.</p>
                </div>
                
                <div class="service-card fade-in">
                    <div class="service-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <h3>Commercial</h3>
                    <p>Office complexes, retail spaces, hotels with premium construction quality.</p>
                </div>
                
                <div class="service-card fade-in">
                    <div class="service-icon">
                        <i class="fas fa-tools"></i>
                    </div>
                    <h3>Renovation</h3>
                    <p>Complete makeovers and renovations for homes and commercial spaces.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Projects -->
    <section class="section" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
        <div class="container">
            <div class="glass-card fade-in" style="max-width: 800px; margin: 0 auto 3rem;">
                <h2 style="text-align: center; color: var(--primary-black);">
                    Featured Projects
                </h2>
            </div>
            
            <div class="projects-grid" id="featured-projects">
                <!-- Projects loaded dynamically -->
                <div class="glass-card text-center p-5 fade-in">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary-yellow);"></i>
                    <p>Loading featured projects...</p>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 3rem;">
                <a href="projects.jsp" class="cta-button">
                    View All Projects
                </a>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="section" style="background: var(--primary-black); color: white;">
        <div class="container">
            <div class="glass-card fade-in" style="text-align: center; max-width: 700px; margin: 0 auto;">
                <h2>Ready to Start Your Project?</h2>
                <p style="font-size: 1.2rem; margin: 1rem 0 2rem;">
                    Contact us today for a free consultation and quote.
                </p>
                <a href="contact.jsp" class="cta-button" style="
                    background: linear-gradient(45deg, var(--primary-yellow), var(--secondary-yellow));
                    color: var(--primary-black);
                ">
                    Get In Touch <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <script src="js/main.js"></script>
    <script>
        // Load featured projects on home page
        document.addEventListener('DOMContentLoaded', function() {
            fetch('/projects')
                .then(response => response.json())
                .then(projects => {
                    const container = document.getElementById('featured-projects');
                    container.innerHTML = '';
                    
                    // Show only first 3 projects
                    projects.slice(0, 3).forEach(project => {
                        const projectCard = `
                            <div class="project-card fade-in">
                                <img src="${project.image || 'images/default-project.jpg'}" alt="${project.title}">
                                <div class="project-info">
                                    <span class="category-badge">${project.category}</span>
                                    <h3>${project.title}</h3>
                                    <p>${project.description.substring(0, 80)}...</p>
                                </div>
                            </div>
                        `;
                        container.innerHTML += projectCard;
                    });
                })
                .catch(() => {
                    document.getElementById('featured-projects').innerHTML = 
                        '<div class="glass-card text-center p-5 col-span-full"><p>Projects coming soon!</p></div>';
                });
        });
    </script>
</body>
</html>
