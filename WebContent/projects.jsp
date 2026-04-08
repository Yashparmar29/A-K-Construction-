<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects - A K Construction</title>
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
                <li><a href="index.jsp">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="projects.jsp" class="active">Projects</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" style="background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwMCIgaGVpZ2h0PSI2MDAiIHZpZXdCb3g9IjAgMCAxMjAwIDYwMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGNpcmNsZSBjeD0iNjAwIiBjeT0iMzAwIiByPSIyNTAiIGZpbGw9IiM0QzhCMkYiLz4KPGNpcmNsZSBjeD0iODAwIiBjeT0iNDAwIiByPSIxNTAiIGZpbGw9IiNCMzk1RkYiLz4KPGNpcmNsZSBjeD0iNDAwIiBjeT0iNDUwIiByPSIxMjAiIGZpbGw9IiM5RkJCM0YiLz4KPC9zdmc+'); height: 60vh;">
        <div class="hero-content">
            <h1>Our Projects</h1>
            <p>Quality Construction | Timely Delivery | Client Satisfaction</p>
        </div>
    </section>

    <!-- Projects Section -->
    <section class="section">
        <div class="container">
            <div class="glass-card fade-in" style="max-width: 800px; margin: 0 auto 3rem; text-align: center;">
                <h2>Project Portfolio</h2>
                <p>Browse our completed projects across various categories and locations.</p>
            </div>
            
            <!-- Filter -->
            <div class="glass-card fade-in" style="padding: 2rem; margin-bottom: 3rem; text-align: center;">
                <label for="categoryFilter" style="font-weight: bold; margin-right: 1rem; color: var(--primary-black);">Filter by Category:</label>
                <select id="categoryFilter" class="project-filter" style="padding: 0.7rem 1.5rem; border-radius: 25px; border: 2px solid var(--glass-border); font-size: 1rem; background: var(--glass-bg); backdrop-filter: blur(10px); min-width: 200px;">
                    <option value="">All Projects</option>
                    <option value="Residential">Residential</option>
                    <option value="Commercial">Commercial</option>
                    <option value="Renovation">Renovation</option>
                    <option value="Civil Engineering">Civil Engineering</option>
                </select>
            </div>
            
            <!-- Projects Grid -->
            <div class="projects-grid" id="projectsGrid">
                <div class="glass-card text-center p-5">
                    <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary-yellow);"></i>
                    <p>Loading projects...</p>
                </div>
            </div>
        </div>
    </section>

    <script src="js/main.js"></script>
    <script>
        // Load projects on page load
        window.loadProjects = function(category) {
            const categoryFilter = document.getElementById('categoryFilter');
            if (category) {
                categoryFilter.value = category;
            }
            // main.js handles the actual loading
        };
        
        // Load projects immediately
        loadProjects();
    </script>
</body>
</html>
