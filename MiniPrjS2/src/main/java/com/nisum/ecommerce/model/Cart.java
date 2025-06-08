package com.nisum.ecommerce.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;
    private double subtotal;
    private double totalDiscount;
    private double comboDiscount;
    private double bulkDiscount;
    private double finalTotal;
    private int totalItems;

    public Cart() {
        this.items = new ArrayList<>();
    }

    
    public void calculateTotals() {
        subtotal = 0;
        totalDiscount = 0;
        totalItems = 0;

        for (CartItem item : items) {
            subtotal += item.getUnitPrice() * item.getQuantity();
            totalDiscount += item.getDiscount() * item.getQuantity();
            totalItems += item.getQuantity();
        }

        
        comboDiscount = calculateComboDiscount();

        
        bulkDiscount = calculateBulkDiscount();

        
        finalTotal = subtotal - totalDiscount - comboDiscount - bulkDiscount;
        if (finalTotal < 0) finalTotal = 0;
    }

    
    private double calculateComboDiscount() {
        boolean hasShirt = items.stream().anyMatch(item -> item.getProductName().toLowerCase().contains("shirt"));
        boolean hasJacket = items.stream().anyMatch(item -> item.getProductName().toLowerCase().contains("jacket"));

        if (hasShirt && hasJacket) {
            return (subtotal - totalDiscount) * 0.10; 
        }
        return 0;
    }


    private double calculateBulkDiscount() {
        if (totalItems >= 3) {
            return (subtotal - totalDiscount) * 0.08; 
        } else if (totalItems >= 2) {
            return (subtotal - totalDiscount) * 0.05; 
        }
        return 0;
    }

    
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }

    public double getSubtotal() { return subtotal; }
    public double getTotalDiscount() { return totalDiscount; }
    public double getComboDiscount() { return comboDiscount; }
    public double getBulkDiscount() { return bulkDiscount; }
    public double getFinalTotal() { return finalTotal; }
    public int getTotalItems() { return totalItems; }
}
