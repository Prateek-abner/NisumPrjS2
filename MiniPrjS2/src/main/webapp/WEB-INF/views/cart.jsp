<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart - FashionHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <header class="cart-header">
            <h1 class="page-title">🛒 Shopping Cart</h1>
            <nav>
                <a href="${pageContext.request.contextPath}/browse" class="nav-btn">Continue Shopping</a>
            </nav>
        </header>

        <main class="cart-main">
            <c:choose>
                <c:when test="${empty cart.items}">
                    <div class="empty-cart">
                        <h2>Your cart is empty</h2>
                        <p>Add some amazing products to your cart!</p>
                        <a href="${pageContext.request.contextPath}/browse" class="continue-shopping-btn">Start Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cart-content">
                        <div class="cart-items-section">
                            <h2>Cart Items (${cart.totalItems})</h2>

                            <c:forEach items="${cart.items}" var="item">
                                <div class="cart-item" data-product-id="${item.productId}" data-size="${item.size}">
                                    <div class="item-image">
                                        <img src="${pageContext.request.contextPath}/${item.imagePath}" alt="${item.productName}" />
                                    </div>

                                    <div class="item-details">
                                        <h3>${item.productName}</h3>
                                        <p class="item-size">Size: ${item.size}</p>
                                        <div class="item-pricing">
                                            <span class="item-price">₹<fmt:formatNumber value="${item.unitPrice - item.discount}" pattern="#,##0.00"/></span>
                                            <span class="item-original-price">₹<fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00"/></span>
                                        </div>
                                    </div>

                                    <div class="item-quantity">
                                        <button class="qty-btn" onclick="updateQuantity(${item.productId}, '${item.size}', ${item.quantity - 1})">-</button>
                                        <span class="qty-display">${item.quantity}</span>
                                        <button class="qty-btn" onclick="updateQuantity(${item.productId}, '${item.size}', ${item.quantity + 1})">+</button>
                                    </div>

                                    <div class="item-total">
                                        ₹<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/>
                                    </div>

                                    <div class="item-actions">
                                        <button class="remove-btn" onclick="removeItem(${item.productId}, '${item.size}')">🗑️</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="cart-summary">
                            <h2>Order Summary</h2>

                            <div class="summary-row">
                                <span>Subtotal (${cart.totalItems} items):</span>
                                <span>₹<fmt:formatNumber value="${cart.subtotal}" pattern="#,##0.00"/></span>
                            </div>

                            <div class="summary-row discount">
                                <span>Product Discounts:</span>
                                <span>-₹<fmt:formatNumber value="${cart.totalDiscount}" pattern="#,##0.00"/></span>
                            </div>

                            <c:if test="${cart.bulkDiscount > 0}">
                                <div class="summary-row discount">
                                    <span>Bulk Discount (${cart.totalItems >= 3 ? '8%' : '5%'}):</span>
                                    <span>-₹<fmt:formatNumber value="${cart.bulkDiscount}" pattern="#,##0.00"/></span>
                                </div>
                            </c:if>

                            <c:if test="${cart.comboDiscount > 0}">
                                <div class="summary-row discount">
                                    <span>🎉 Combo Discount (10%):</span>
                                    <span>-₹<fmt:formatNumber value="${cart.comboDiscount}" pattern="#,##0.00"/></span>
                                </div>
                            </c:if>

                            <div class="summary-row shipping">
                                <span>Shipping:</span>
                                <span>${cart.finalTotal >= 999 ? 'FREE' : '₹99'}</span>
                            </div>

                            <hr>

                            <div class="summary-row total">
                                <span>Total Amount:</span>
                                <span>₹<fmt:formatNumber value="${cart.finalTotal + (cart.finalTotal >= 999 ? 0 : 99)}" pattern="#,##0.00"/></span>
                            </div>

                            <div class="savings-info">
                                <p>🎉 You saved ₹<fmt:formatNumber value="${cart.totalDiscount + cart.bulkDiscount + cart.comboDiscount}" pattern="#,##0.00"/> on this order!</p>
                            </div>

                            <div class="checkout-actions">
                                <button class="checkout-btn" onclick="proceedToCheckout()">Proceed to Checkout</button>
                                <button class="clear-cart-btn" onclick="clearCart()">Clear Cart</button>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>

    <script>
        function updateQuantity(productId, size, newQuantity) {
            if (newQuantity <= 0) {
                removeItem(productId, size);
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/cart/update',
                type: 'POST',
                data: {
                    productId: productId,
                    size: size,
                    quantity: newQuantity
                },
                success: function() {
                    location.reload();
                }
            });
        }

        function removeItem(productId, size) {
            if (confirm('Remove this item from cart?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/cart/remove',
                    type: 'POST',
                    data: {
                        productId: productId,
                        size: size
                    },
                    success: function() {
                        location.reload();
                    }
                });
            }
        }

        function clearCart() {
            if (confirm('Clear all items from cart?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/cart/clear',
                    type: 'POST',
                    success: function() {
                        location.reload();
                    }
                });
            }
        }

        function proceedToCheckout() {
            alert('Checkout functionality coming soon!');
        }
    </script>
</body>
</html>
