package com.nisum.ecommerce.controller;

import com.nisum.ecommerce.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/add")
    @ResponseBody
    public String addToCart(@RequestParam int productId,
                            @RequestParam int quantity,
                            @RequestParam String size,
                            HttpSession session) {
        boolean success = cartService.addToCart(session, productId, quantity, size);
        if (success) {
            return "{\"status\":\"success\",\"message\":\"Item added to cart!\"}";
        } else {
            return "{\"status\":\"error\",\"message\":\"Failed to add item to cart\"}";
        }
    }

    @GetMapping("/view")
    public String viewCart(HttpSession session, Model model) {
        model.addAttribute("cart", cartService.getCart(session));
        return "cart";
    }

    @PostMapping("/update")
    @ResponseBody
    public String updateCart(@RequestParam int productId,
                             @RequestParam String size,
                             @RequestParam int quantity,
                             HttpSession session) {
        cartService.updateQuantity(session, productId, size, quantity);
        return "{\"status\":\"success\"}";
    }

    @PostMapping("/remove")
    @ResponseBody
    public String removeFromCart(@RequestParam int productId,
                                 @RequestParam String size,
                                 HttpSession session) {
        cartService.removeFromCart(session, productId, size);
        return "{\"status\":\"success\"}";
    }

    @PostMapping("/clear")
    @ResponseBody
    public String clearCart(HttpSession session) {
        cartService.clearCart(session);
        return "{\"status\":\"success\"}";
    }

    @GetMapping("/count")
    @ResponseBody
    public String getCartCount(HttpSession session) {
        int count = cartService.getCart(session).getTotalItems();
        return "{\"count\":" + count + "}";
    }
}
