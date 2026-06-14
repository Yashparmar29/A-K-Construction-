<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - A K Construction</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/planner.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f0f15 0%, #151525 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            max-width: 450px;
            width: 100%;
            padding: 3rem;
            text-align: center;
        }
        .login-logo {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--yellow);
            margin-bottom: 2rem;
            display: inline-block;
            text-decoration: none;
        }
        .login-logo i {
            margin-right: 8px;
        }
    </style>
</head>
<body class="planner-bg">
    <div class="container d-flex justify-content-center">
        <div class="login-card glass-card fade-in">
            <a href="/" class="login-logo"><i class="fas fa-hammer"></i> A K Construction</a>
            
            <h3 class="mb-4" style="font-weight: 700; color: #fff;">Sign In</h3>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger rounded-4 py-2" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success border-0 bg-success bg-opacity-10 text-success rounded-4 py-2" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                </div>
            </c:if>

            <form action="/login" method="post" class="text-start">
                <div class="mb-3">
                    <label for="email" class="form-label" style="font-weight: 500; color: rgba(255,255,255,0.8);">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text border-0 bg-opacity-10 bg-white text-white-50 rounded-start-4"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control glass-input rounded-end-4" id="email" name="email" placeholder="name@example.com" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <div class="d-flex justify-content-between">
                        <label for="password" class="form-label" style="font-weight: 500; color: rgba(255,255,255,0.8);">Password</label>
                    </div>
                    <div class="input-group">
                        <span class="input-group-text border-0 bg-opacity-10 bg-white text-white-50 rounded-start-4"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control glass-input rounded-end-4" id="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-gold w-100 py-3 mb-4 rounded-4">
                    <i class="fas fa-sign-in-alt me-2"></i> Sign In
                </button>
            </form>
            
            <p style="color: rgba(255,255,255,0.6);" class="mb-0">
                Don't have an account? 
                <a href="/register" style="color: var(--yellow); text-decoration: none; font-weight: 600;">Sign Up</a>
            </p>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
