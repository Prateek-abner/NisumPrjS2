<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product.productName} - FashionHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <!-- Product Detail Header -->
        <header class="product-header">
            <h1 class="product-main-title">${product.productName}</h1>
            <p class="brand-subtitle">by FashionHub</p>
        </header>

        <!-- Product Detail Content -->
        <main class="product-detail-container">
            <div class="product-detail-layout">
                <!-- Product Image Section -->
                <div class="product-image-section">
                    <div class="main-image-container">
                        <img src="${pageContext.request.contextPath}/${product.imagePath}"
                             alt="${product.productName}"
                             class="main-product-image"
                             onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'" />
                    </div>
                </div>

                <!-- Product Info Section -->
                <div class="product-info-panel">
                    <!-- Pricing -->
                    <div class="price-container">
                        <span class="current-price-large">₹${product.discountPrice}</span>
                        <span class="original-price-large">₹${product.price}</span>
                        <span class="discount-percentage">(${product.discount}% OFF)</span>
                    </div>

                    <!-- Offers Section -->
                    <div class="offers-container">
                        <h3 class="section-title">
                            <i class="fas fa-gift"></i> Available Offers
                        </h3>
                        <div class="offer-item">
                            <i class="fas fa-check-circle"></i>
                            <span>20% off on orders above ₹1500</span>
                        </div>
                    </div>

                    <!-- Size Selection -->
                    <div class="size-container">
                        <h3 class="section-title">Size:</h3>
                        <div class="size-options">
                            <button class="size-button" data-size="S">S</button>
                            <button class="size-button active" data-size="M">M</button>
                            <button class="size-button" data-size="L">L</button>
                        </div>
                    </div>

                    <!-- Quantity Selection -->
                    <div class="quantity-container">
                        <label class="section-title">Quantity:</label>
                        <div class="quantity-selector">
                            <button class="qty-decrease" onclick="changeQuantity(-1)">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="number" id="quantity" value="1" min="1" max="5" readonly class="qty-input">
                            <button class="qty-increase" onclick="changeQuantity(1)">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                        <p class="stock-warning">
                            <i class="fas fa-exclamation-triangle"></i>
                            Only 12 items left in stock. Hurry up!
                        </p>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons-container">
                        <button class="add-to-cart-button" onclick="addToCart()">
                            <i class="fas fa-shopping-cart"></i>
                            Add to Cart
                        </button>
                        <button class="buy-now-button" onclick="buyNow()">
                            <i class="fas fa-bolt"></i>
                            Buy Now
                        </button>
                    </div>

                    <!-- Back Link -->
                    <div class="back-link-container">
                        <a href="${pageContext.request.contextPath}/browse" class="back-link">
                            <i class="fas fa-arrow-left"></i>
                            Back to Browse
                        </a>
                    </div>

                    <!-- Message Container -->
                    <div id="cart-message" class="message-container" style="display: none;"></div>
                </div>
            </div>
        </main>
    </div>

    <script>
        let selectedSize = 'M';

        // Size selection functionality
        document.querySelectorAll('.size-button').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.size-button').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                selectedSize = this.getAttribute('data-size');
            });
        });

        // Quantity controls
        function changeQuantity(change) {
            const qtyInput = document.getElementById('quantity');
            let newQty = parseInt(qtyInput.value) + change;
            if (newQty >= 1 && newQty <= 5) {
                qtyInput.value = newQty;
            }
        }

        // Add to cart function
        function addToCart() {
            const quantity = document.getElementById('quantity').value;

            $.ajax({
                url: '${pageContext.request.contextPath}/cart/add',
                type: 'POST',
                data: {
                    productId: ${product.productId},
                    quantity: quantity,
                    size: selectedSize
                },
                success: function(response) {
                    const result = JSON.parse(response);
                    showMessage(result.message, result.status === 'success');
                },
                error: function() {
                    showMessage('Error adding item to cart', false);
                }
            });
        }

        // Buy now function
        function buyNow() {
            addToCart();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/cart/view';
            }, 1000);
        }

        // Show message function
        function showMessage(message, isSuccess) {
            const messageDiv = document.getElementById('cart-message');
            messageDiv.textContent = message;
            messageDiv.className = 'message-container ' + (isSuccess ? 'success' : 'error');
            messageDiv.style.display = 'block';

            setTimeout(() => {
                messageDiv.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html>
