package com.nisum.ecommerce.controller;

import com.nisum.ecommerce.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping("/")
    public String index() {
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(Model model) {
        model.addAttribute("products", productDAO.getAllProducts());
        model.addAttribute("categories", productDAO.getAllCategories());
        return "home";
    }

    @GetMapping("/browse")
    public String browse(Model model) {
        model.addAttribute("products", productDAO.getAllProducts());
        model.addAttribute("categories", productDAO.getAllCategories());
        return "browse";
    }
}
