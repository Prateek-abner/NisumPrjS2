<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to FashionHub - Your Style Destination</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="main-navigation">
        <div class="nav-container">
            <div class="brand-logo">
                <h2><i class="fas fa-gem"></i> FashionHub</h2>
            </div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/browse" class="nav-link">
                    <i class="fas fa-shopping-bag"></i> Browse Products
                </a>
                <a href="${pageContext.request.contextPath}/user/login" class="nav-link">
                    <i class="fas fa-user"></i> Login
                </a>
                <a href="${pageContext.request.contextPath}/user/register" class="nav-link">
                    <i class="fas fa-user-plus"></i> Register
                </a>
                <a href="${pageContext.request.contextPath}/cart/view" class="cart-link">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count">0</span>
                </a>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">Welcome to <span class="brand-highlight">FashionHub</span></h1>
                <p class="hero-subtitle">Discover the latest trends in fashion. From casual wear to elegant outfits, find your perfect style with our curated collection of premium clothing.</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/browse" class="btn-primary">
                        <i class="fas fa-shopping-bag"></i> Start Shopping
                    </a>
                </div>
            </div>
            <div class="hero-visual">
                <!-- Using CSS gradients instead of images for visual appeal -->
                <div style="width: 100%; height: 400px; background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%); border-radius: 20px; display: flex; align-items: center; justify-content: center; box-shadow: 0 20px 40px rgba(0,0,0,0.2);">
                    <div style="text-align: center; color: white;">
                        <i class="fas fa-tshirt" style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.9;"></i>
                        <h3 style="font-size: 1.5rem; font-weight: 600;">Premium Fashion</h3>
                        <p style="opacity: 0.9;">Up to 50% OFF</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="featured-products">
        <div class="container">
            <h2 class="section-title">Featured Products</h2>
            <div class="products-grid">
                <c:forEach items="${products}" var="product">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/${product.imagePath}"
                                 alt="${product.productName}"
                                 onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'" />
                            <div class="product-overlay">
                                <a href="${pageContext.request.contextPath}/products/detail/${product.productId}" class="quick-view">
                                    <i class="fas fa-eye"></i> Quick View
                                </a>
                            </div>
                            <span class="discount-tag">${product.discount}% OFF</span>
                        </div>
                        <div class="product-info">
                            <h3>${product.productName}</h3>
                            <div class="product-price">
                                <span class="current-price">₹${product.discountPrice}</span>
                                <span class="original-price">₹${product.price}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="view-all-container">
                <a href="${pageContext.request.contextPath}/browse" class="view-all-btn">
                    View All Products <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <script>
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        document.querySelectorAll('img').forEach(img => {
            img.addEventListener('load', function() {
                this.style.opacity = '1';
            });
        });
    </script>
</body>
</html>
