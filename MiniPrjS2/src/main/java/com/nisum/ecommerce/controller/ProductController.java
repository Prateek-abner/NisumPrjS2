package com.nisum.ecommerce.controller;

import com.nisum.ecommerce.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping("/search")
    public String searchProducts(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
            Model model) {

        if (keyword != null && !keyword.trim().isEmpty()) {
            model.addAttribute("products", productDAO.searchProducts(keyword));
        } else if (categoryId != null) {
            model.addAttribute("products", productDAO.getProductsByCategory(categoryId));
        } else {
            model.addAttribute("products", productDAO.getAllProducts());
        }

        model.addAttribute("categories", productDAO.getAllCategories());
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategoryId", categoryId);

        return "browse";
    }

    @GetMapping("/detail/{productId}")
    public String productDetail(@PathVariable String productId, Model model) {
        try {
            
            int id;
            if (productId.startsWith("P")) {
            
                String numPart = productId.substring(1, 2);
                id = Integer.parseInt(numPart);
            } else {
                id = Integer.parseInt(productId);
            }

            model.addAttribute("product", productDAO.getProductById(id));
            return "product-detail";
        } catch (Exception e) {
        
            return "redirect:/browse";
        }
    }
}
