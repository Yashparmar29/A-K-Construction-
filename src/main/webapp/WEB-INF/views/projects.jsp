<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A K Construction Projects - Browse our portfolio of completed residential, commercial and civil projects.">
    <title>Projects - A K Construction</title>
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
                <li><a href="/projects" class="active">Projects</a></li>
                <li><a href="/contact">Contact</a></li>
            </ul>
            <button class="nav-toggle" id="navToggle"><i class="fas fa-bars"></i></button>
        </div>
    </nav>

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="page-hero-content">
            <div class="breadcrumb">
                <a href="/">Home</a> <i class="fas fa-chevron-right"></i> <span>Projects</span>
            </div>
            <h1>Our <span class="highlight">Projects</span></h1>
            <p>Quality Construction &nbsp;|&nbsp; Timely Delivery &nbsp;|&nbsp; Client Satisfaction</p>
        </div>
    </section>

    <!-- Projects Section -->
    <section class="section">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">Portfolio</span>
                <h2>Project Portfolio</h2>
                <p>Browse our completed projects across various categories and locations.</p>
            </div>

            <!-- Filter Bar -->
            <div class="filter-bar fade-in">
                <button class="filter-btn active" data-category="" id="filter-all">All Projects</button>
                <button class="filter-btn" data-category="Residential" id="filter-residential">Residential</button>
                <button class="filter-btn" data-category="Commercial" id="filter-commercial">Commercial</button>
                <button class="filter-btn" data-category="Renovation" id="filter-renovation">Renovation</button>
                <button class="filter-btn" data-category="Civil Engineering" id="filter-civil">Civil Engineering</button>
            </div>

            <!-- Projects Grid -->
            <div class="projects-grid" id="projectsGrid">
                <div class="loading-card">
                    <i class="fas fa-spinner fa-spin"></i>
                    <p>Loading projects...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="section cta-section">
        <div class="container">
            <div class="cta-box fade-in">
                <h2>Have a Project in Mind?</h2>
                <p>Let's discuss how we can bring your construction vision to life.</p>
                <a href="/contact" class="cta-button"><i class="fas fa-paper-plane"></i> Start a Project</a>
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
        // Filter buttons
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                loadProjects(this.dataset.category);
            });
        });

        // Load all on start
        loadProjects('');

        function loadProjects(category) {
            const grid = document.getElementById('projectsGrid');
            grid.innerHTML = '<div class="loading-card"><i class="fas fa-spinner fa-spin"></i><p>Loading projects...</p></div>';
            const url = category ? '/api/projects?category=' + encodeURIComponent(category) : '/api/projects';
            fetch(url)
                .then(r => r.json())
                .then(projects => {
                    grid.innerHTML = '';
                    if (projects.length === 0) {
                        grid.innerHTML = '<div class="loading-card"><i class="fas fa-folder-open"></i><p>No projects found in this category.</p></div>';
                        return;
                    }
                    projects.forEach(p => {
                        grid.innerHTML += `
                            <div class="project-card fade-in visible">
                                <div class="project-img-wrap">
                                    <img src="${p.image || '/images/default-project.jpg'}" alt="${p.title}" onerror="this.src='/images/default-project.jpg'">
                                    <span class="category-badge">${p.category}</span>
                                </div>
                                <div class="project-info">
                                    <h3>${p.title}</h3>
                                    <p>${p.description}</p>
                                </div>
                            </div>`;
                    });
                })
                .catch(() => {
                    grid.innerHTML = '<div class="loading-card"><i class="fas fa-exclamation-circle"></i><p>Error loading projects. Please try again.</p></div>';
                });
        }
    </script>
</body>
</html>
