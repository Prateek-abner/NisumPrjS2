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

    // Calculate all totals and discounts
    public void calculateTotals() {
        subtotal = 0;
        totalDiscount = 0;
        totalItems = 0;

        for (CartItem item : items) {
            subtotal += item.getUnitPrice() * item.getQuantity();
            totalDiscount += item.getDiscount() * item.getQuantity();
            totalItems += item.getQuantity();
        }

        // Calculate combo discounts
        comboDiscount = calculateComboDiscount();

        // Calculate bulk discounts
        bulkDiscount = calculateBulkDiscount();

        // Final total calculation
        finalTotal = subtotal - totalDiscount - comboDiscount - bulkDiscount;
        if (finalTotal < 0) finalTotal = 0;
    }

    // Combo discount logic (e.g., shirt + jacket = extra 10% off)
    private double calculateComboDiscount() {
        boolean hasShirt = items.stream().anyMatch(item -> item.getProductName().toLowerCase().contains("shirt"));
        boolean hasJacket = items.stream().anyMatch(item -> item.getProductName().toLowerCase().contains("jacket"));

        if (hasShirt && hasJacket) {
            return (subtotal - totalDiscount) * 0.10; // 10% combo discount
        }
        return 0;
    }

    // Bulk discount logic (e.g., buy 2+ items get 5% off, 3+ items get 8% off)
    private double calculateBulkDiscount() {
        if (totalItems >= 3) {
            return (subtotal - totalDiscount) * 0.08; // 8% for 3+ items
        } else if (totalItems >= 2) {
            return (subtotal - totalDiscount) * 0.05; // 5% for 2+ items
        }
        return 0;
    }

    // Getters and Setters
    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }

    public double getSubtotal() { return subtotal; }
    public double getTotalDiscount() { return totalDiscount; }
    public double getComboDiscount() { return comboDiscount; }
    public double getBulkDiscount() { return bulkDiscount; }
    public double getFinalTotal() { return finalTotal; }
    public int getTotalItems() { return totalItems; }
}
