// A K Construction - Main JavaScript
document.addEventListener('DOMContentLoaded', function() {
    
    // Mobile menu toggle (if needed)
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Navbar background on scroll
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(26, 26, 26, 0.98)';
        } else {
            navbar.style.background = 'linear-gradient(135deg, #1a1a1a, rgba(26,26,26,0.95))';
        }
        
        // Back to top button
        const backToTop = document.querySelector('.back-to-top');
        if (window.scrollY > 300) {
            backToTop.classList.add('show');
        } else {
            backToTop.classList.remove('show');
        }
    });
    
    // Scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, observerOptions);
    
    document.querySelectorAll('.fade-in').forEach(el => {
        observer.observe(el);
    });
    
    // Back to top functionality
    const backToTop = document.createElement('button');
    backToTop.innerHTML = '↑';
    backToTop.className = 'back-to-top';
    document.body.appendChild(backToTop);
    
    backToTop.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
    
    // Form validation
    const forms = document.querySelectorAll('.contact-form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            const name = form.querySelector('input[name="name"]').value.trim();
            const email = form.querySelector('input[name="email"]').value.trim();
            const message = form.querySelector('textarea[name="message"]').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!name || !email || !message) {
                e.preventDefault();
                showAlert('Please fill all fields', 'error');
                return false;
            }
            
            if (!emailRegex.test(email)) {
                e.preventDefault();
                showAlert('Please enter valid email', 'error');
                return false;
            }
            
            if (message.length < 10) {
                e.preventDefault();
                showAlert('Message should be at least 10 characters', 'error');
                return false;
            }
        });
    });
    
    // Load projects dynamically on projects page
    const currentPage = window.location.pathname;
    if (currentPage.includes('projects')) {
        loadProjects();
    }
    
    // Project filter functionality
    document.addEventListener('change', function(e) {
        if (e.target.classList.contains('project-filter')) {
            loadProjects(e.target.value);
        }
    });
    
    // Global functions
    window.loadProjects = loadProjects;
    window.showAlert = showAlert;
});

function loadProjects(category = '') {
    const projectsContainer = document.querySelector('.projects-grid');
    if (!projectsContainer) return;
    
    // Show loading
    projectsContainer.innerHTML = '<div class="glass-card text-center p-5"><h3>Loading projects...</h3></div>';
    
    const url = category ? `/projects?category=${encodeURIComponent(category)}` : '/projects';
    
    fetch(url)
        .then(response => response.json())
        .then(projects => {
            projectsContainer.innerHTML = '';
            
            if (projects.length === 0) {
                projectsContainer.innerHTML = '<div class="glass-card text-center p-5 col-span-full"><h3>No projects found</h3></div>';
                return;
            }
            
            projects.forEach(project => {
                const projectCard = `
                    <div class="project-card fade-in">
                        <img src="${project.image || 'images/default-project.jpg'}" 
                             alt="${project.title}" 
                             loading="lazy">
                        <div class="project-info">
                            <span class="category-badge">${project.category}</span>
                            <h3>${project.title}</h3>
                            <p>${project.description.substring(0, 100)}...</p>
                        </div>
                    </div>
                `;
                projectsContainer.innerHTML += projectCard;
            });
        })
        .catch(error => {
            console.error('Error loading projects:', error);
            projectsContainer.innerHTML = '<div class="glass-card text-center p-5 col-span-full"><h3>Error loading projects</h3></div>';
        });
}

function showAlert(message, type = 'success') {
    // Remove existing alerts
    const existingAlert = document.querySelector('.alert');
    if (existingAlert) {
        existingAlert.remove();
    }
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.textContent = message;
    
    const form = document.querySelector('.contact-form');
    if (form) {
        form.parentNode.insertBefore(alertDiv, form);
    }
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

// Navbar scroll effect
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 100) {
        navbar.style.padding = '0.5rem 0';
    } else {
        navbar.style.padding = '1rem 0';
    }
});
