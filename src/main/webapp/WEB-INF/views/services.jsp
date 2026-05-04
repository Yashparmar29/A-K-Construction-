<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A K Construction Services - Residential, Commercial, Renovation, Civil Engineering and Interior Design services.">
    <title>Services - A K Construction</title>
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
                <li><a href="/services" class="active">Services</a></li>
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
                <a href="/">Home</a> <i class="fas fa-chevron-right"></i> <span>Services</span>
            </div>
            <h1>Our <span class="highlight">Services</span></h1>
            <p>Comprehensive construction solutions tailored to your needs</p>
        </div>
    </section>

    <!-- Services Detail -->
    <section class="section">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">What We Offer</span>
                <h2>Complete Construction Solutions</h2>
                <p>We provide end-to-end construction services from design to handover, backed by 20+ years of expertise.</p>
            </div>

            <!-- Service 1 -->
            <div class="service-detail-card fade-in">
                <div class="service-detail-icon">
                    <i class="fas fa-home"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Residential Construction</h3>
                    <p>We build custom homes, luxury villas, and apartment complexes that reflect your unique lifestyle. Our residential projects combine elegant design with structural integrity, modern amenities, and energy efficiency.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Custom Home Design</span>
                        <span><i class="fas fa-check"></i> Luxury Villas</span>
                        <span><i class="fas fa-check"></i> Apartment Complexes</span>
                        <span><i class="fas fa-check"></i> Smart Home Integration</span>
                        <span><i class="fas fa-check"></i> Vastu-Compliant Layouts</span>
                        <span><i class="fas fa-check"></i> Landscaping</span>
                    </div>
                </div>
            </div>

            <!-- Service 2 -->
            <div class="service-detail-card fade-in reverse">
                <div class="service-detail-icon" style="background: linear-gradient(135deg, #667eea, #764ba2);">
                    <i class="fas fa-building"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Commercial Construction</h3>
                    <p>From corporate headquarters to retail malls, we deliver commercial spaces that inspire productivity and attract customers. Our projects meet all regulatory requirements and are designed for operational efficiency.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Office Buildings</span>
                        <span><i class="fas fa-check"></i> Shopping Malls</span>
                        <span><i class="fas fa-check"></i> Hotels & Hospitality</span>
                        <span><i class="fas fa-check"></i> Warehouses</span>
                        <span><i class="fas fa-check"></i> Industrial Plants</span>
                        <span><i class="fas fa-check"></i> Medical Facilities</span>
                    </div>
                </div>
            </div>

            <!-- Service 3 -->
            <div class="service-detail-card fade-in">
                <div class="service-detail-icon" style="background: linear-gradient(135deg, #f093fb, #f5576c);">
                    <i class="fas fa-tools"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Renovation & Remodeling</h3>
                    <p>Transform your existing space without the hassle of building from scratch. Our renovation experts breathe new life into old structures while preserving their character and structural soundness.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Home Renovations</span>
                        <span><i class="fas fa-check"></i> Kitchen Remodeling</span>
                        <span><i class="fas fa-check"></i> Bathroom Upgrades</span>
                        <span><i class="fas fa-check"></i> Office Refurbishment</span>
                        <span><i class="fas fa-check"></i> Facade Restoration</span>
                        <span><i class="fas fa-check"></i> Structural Repairs</span>
                    </div>
                </div>
            </div>

            <!-- Service 4 -->
            <div class="service-detail-card fade-in reverse">
                <div class="service-detail-icon" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
                    <i class="fas fa-drafting-compass"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Civil Engineering</h3>
                    <p>Our civil engineering team handles complex infrastructure projects including bridges, roads, drainage systems, and public works with precision engineering and strict safety standards.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Bridge Construction</span>
                        <span><i class="fas fa-check"></i> Road Development</span>
                        <span><i class="fas fa-check"></i> Drainage Systems</span>
                        <span><i class="fas fa-check"></i> Retaining Walls</span>
                        <span><i class="fas fa-check"></i> Foundation Works</span>
                        <span><i class="fas fa-check"></i> Site Development</span>
                    </div>
                </div>
            </div>

            <!-- Service 5 -->
            <div class="service-detail-card fade-in">
                <div class="service-detail-icon" style="background: linear-gradient(135deg, #43e97b, #38f9d7);">
                    <i class="fas fa-couch"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Interior Design</h3>
                    <p>Complete interior design services that transform empty spaces into stunning, functional environments. From concept to installation, our designers create interiors that inspire and delight.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Space Planning</span>
                        <span><i class="fas fa-check"></i> 3D Visualization</span>
                        <span><i class="fas fa-check"></i> Furniture Selection</span>
                        <span><i class="fas fa-check"></i> Lighting Design</span>
                        <span><i class="fas fa-check"></i> False Ceiling Work</span>
                        <span><i class="fas fa-check"></i> Modular Kitchens</span>
                    </div>
                </div>
            </div>

            <!-- Service 6 -->
            <div class="service-detail-card fade-in reverse">
                <div class="service-detail-icon" style="background: linear-gradient(135deg, #fa709a, #fee140);">
                    <i class="fas fa-project-diagram"></i>
                </div>
                <div class="service-detail-content">
                    <h3>Project Management</h3>
                    <p>End-to-end project management services ensuring your construction project is delivered on time, within budget, and to the highest quality standards. We manage vendors, timelines, and budgets so you don't have to.</p>
                    <div class="service-features">
                        <span><i class="fas fa-check"></i> Planning & Scheduling</span>
                        <span><i class="fas fa-check"></i> Budget Management</span>
                        <span><i class="fas fa-check"></i> Quality Control</span>
                        <span><i class="fas fa-check"></i> Vendor Management</span>
                        <span><i class="fas fa-check"></i> Progress Reporting</span>
                        <span><i class="fas fa-check"></i> Risk Management</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Process Section -->
    <section class="section section-gray">
        <div class="container">
            <div class="section-header fade-in">
                <span class="section-tag">How We Work</span>
                <h2>Our Construction Process</h2>
                <p>A transparent, step-by-step approach from concept to completion.</p>
            </div>
            <div class="process-grid">
                <div class="process-step fade-in">
                    <div class="step-number">01</div>
                    <h4>Consultation</h4>
                    <p>Free initial meeting to understand your vision, requirements, and budget.</p>
                </div>
                <div class="process-step fade-in">
                    <div class="step-number">02</div>
                    <h4>Design & Planning</h4>
                    <p>Architects create detailed blueprints and 3D visualizations for your approval.</p>
                </div>
                <div class="process-step fade-in">
                    <div class="step-number">03</div>
                    <h4>Approvals</h4>
                    <p>We handle all permits, NOCs, and regulatory approvals on your behalf.</p>
                </div>
                <div class="process-step fade-in">
                    <div class="step-number">04</div>
                    <h4>Construction</h4>
                    <p>Expert teams execute the project with regular quality checks and updates.</p>
                </div>
                <div class="process-step fade-in">
                    <div class="step-number">05</div>
                    <h4>Handover</h4>
                    <p>Final inspection, snag resolution, and key handover with warranty documents.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="section cta-section">
        <div class="container">
            <div class="cta-box fade-in">
                <h2>Need a Custom Construction Solution?</h2>
                <p>Talk to our experts and get a detailed proposal within 48 hours — completely free.</p>
                <a href="/contact" class="cta-button"><i class="fas fa-paper-plane"></i> Request a Quote</a>
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
