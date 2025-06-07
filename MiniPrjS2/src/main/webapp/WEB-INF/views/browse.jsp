<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FashionHub - Search and Browse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!-- Modern Header -->
        <header class="modern-header">
            <h1 class="brand-title">FashionHub - Search and Browse</h1>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/cart/view" class="cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="cart-count">0</span>
                </a>
            </div>
        </header>

        <!-- Search Section -->
        <section class="search-container">
            <form action="${pageContext.request.contextPath}/products/search" method="get" class="modern-search-form">
                <div class="search-group">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Search by Product Name" class="modern-search-input" />
                    <select name="categoryId" class="modern-select">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryId}" ${selectedCategoryId == category.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="modern-search-btn">Search</button>
                </div>
            </form>
        </section>

        <!-- Products Grid -->
        <section class="products-container">
            <div class="modern-products-grid">
                <c:forEach items="${products}" var="product">
                    <div class="modern-product-card">
                        <div class="product-image-container">
                            <img src="${pageContext.request.contextPath}/${product.imagePath}"
                                 alt="${product.productName}"
                                 class="product-image"
                                 onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'" />
                            <div class="discount-badge">${product.discount}% OFF</div>
                        </div>

                        <div class="product-content">
                            <h3 class="product-title">${product.productName}</h3>
                            <p class="product-category">Category: ${product.categoryName}</p>

                            <div class="pricing-section">
                                <span class="current-price">₹${product.discountPrice}</span>
                                <span class="original-price">₹${product.price}</span>
                            </div>

                            <a href="${pageContext.request.contextPath}/products/detail/${product.productId}" class="view-details-button">
                                View Details
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty products}">
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h3>No products found</h3>
                    <p>Try different search criteria or browse all categories.</p>
                </div>
            </c:if>
        </section>
    </div>
</body>
</html>
