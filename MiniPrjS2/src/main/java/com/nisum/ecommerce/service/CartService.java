package com.nisum.ecommerce.service;

import com.nisum.ecommerce.model.Cart;
import com.nisum.ecommerce.model.CartItem;
import com.nisum.ecommerce.model.Product;
import com.nisum.ecommerce.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class CartService {

    @Autowired
    private ProductDAO productDAO;

    public Cart getCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public boolean addToCart(HttpSession session, int productId, int quantity, String size) {
        try {
            Product product = productDAO.getProductById(productId);
            if (product == null) return false;

            Cart cart = getCart(session);

            // Check if item already exists in cart
            CartItem existingItem = cart.getItems().stream()
                    .filter(item -> item.getProductId() == productId && item.getSize().equals(size))
                    .findFirst()
                    .orElse(null);

            if (existingItem != null) {
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
            } else {
                CartItem newItem = new CartItem(
                        product.getProductId(),
                        product.getProductName(),
                        product.getImagePath(),
                        quantity,
                        product.getPrice(),
                        product.getPrice() - product.getDiscountPrice()
                );
                newItem.setSize(size);
                cart.getItems().add(newItem);
            }

            cart.calculateTotals();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public void updateQuantity(HttpSession session, int productId, String size, int quantity) {
        Cart cart = getCart(session);
        cart.getItems().stream()
                .filter(item -> item.getProductId() == productId && item.getSize().equals(size))
                .findFirst()
                .ifPresent(item -> {
                    if (quantity <= 0) {
                        cart.getItems().remove(item);
                    } else {
                        item.setQuantity(quantity);
                    }
                });
        cart.calculateTotals();
    }

    public void removeFromCart(HttpSession session, int productId, String size) {
        Cart cart = getCart(session);
        cart.getItems().removeIf(item ->
                item.getProductId() == productId && item.getSize().equals(size));
        cart.calculateTotals();
    }

    public void clearCart(HttpSession session) {
        session.removeAttribute("cart");
    }
}
